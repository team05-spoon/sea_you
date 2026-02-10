package com.sea_you.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@Service
public class ChatbotService {

    @Value("${huggingface.api.key}")
    private String apiKey;

    @Value("${huggingface.model}")
    private String model;

    private final RestTemplate restTemplate = new RestTemplate();

    public String ask(String userMessage) {
        try {
            // ✅ Hugging Face Router (OpenAI-compatible)
            String url = "https://router.huggingface.co/v1/chat/completions";

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setBearerAuth(apiKey);

            // ✅ OpenAI-compatible request body
            Map<String, Object> body = new HashMap<>();
            body.put("model", model);

            List<Map<String, String>> messages = new ArrayList<>();
            messages.add(Map.of(
            		  "role", "system",
            		  "content",
            		  "너는 SEA_YOU(한국 해수욕장/여행) 안내 챗봇이다. " +
            		  "반드시 '대한민국에 실제로 존재하는 해수욕장'만 추천해라. " +
            		  "모르면 모른다고 하고, 모호한 지명(예: 정선 해수욕장 같은 비정상/불확실)은 절대 쓰지 마라. " +
            		  "답변은 번호 목록 5개 이하로 짧고 명확하게, 각 항목은 (지역/포인트/겨울 즐길거리)로 써라."
            		));

            messages.add(Map.of(
                    "role", "user",
                    "content", userMessage
            ));

            body.put("messages", messages);
            body.put("temperature", 0.7);

            // 너무 길어지지 않게
            body.put("max_tokens", 500);

            HttpEntity<Map<String, Object>> req = new HttpEntity<>(body, headers);

            ResponseEntity<Map> res = restTemplate.postForEntity(url, req, Map.class);
            Map<?, ?> resBody = res.getBody();

            if (resBody == null) return "지금은 답변을 생성할 수 없어요. (응답 없음)";

            // ✅ Parse: choices[0].message.content
            Object choicesObj = resBody.get("choices");
            if (!(choicesObj instanceof List)) {
                // 에러 형태일 수 있음
                Object err = resBody.get("error");
                if (err != null) return "에러: " + err;
                return "응답 형식이 예상과 달라요(choices 없음).";
            }

            List<?> choices = (List<?>) choicesObj;
            if (choices.isEmpty() || !(choices.get(0) instanceof Map)) {
                return "응답 형식이 예상과 달라요(choices 비었음).";
            }

            Map<?, ?> firstChoice = (Map<?, ?>) choices.get(0);
            Object msgObj = firstChoice.get("message");
            if (!(msgObj instanceof Map)) {
                return "응답 형식이 예상과 달라요(message 없음).";
            }

            Map<?, ?> msg = (Map<?, ?>) msgObj;
            Object content = msg.get("content");
            if (content == null) return "답변이 비었어요.";

            String text = content.toString().trim();
            if (text.isEmpty()) return "답변이 비었어요.";

            return text;

        } catch (RestClientException e) {
            return "HF 호출 실패: " + e.getMessage();
        } catch (Exception e) {
            return "챗봇 오류: " + e.getClass().getSimpleName() + " - " + e.getMessage();
        }
    }
}
