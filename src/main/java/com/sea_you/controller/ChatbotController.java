package com.sea_you.controller;

import com.sea_you.dto.ChatbotAskRequest;
import com.sea_you.dto.ChatbotAskResponse;
import com.sea_you.service.ChatbotService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/ChatBot")
public class ChatbotController {

    private final ChatbotService chatbotService;

    public ChatbotController(ChatbotService chatbotService) {
        this.chatbotService = chatbotService;
    }

    @PostMapping("/Ask")
    public ChatbotAskResponse ask(@RequestBody ChatbotAskRequest req) {
        String msg = (req.getMessage() == null) ? "" : req.getMessage().trim();
        if (msg.isEmpty()) return new ChatbotAskResponse("질문을 입력해줘 🙂");

        String reply = chatbotService.ask(msg);
        return new ChatbotAskResponse(reply);
    }
}
