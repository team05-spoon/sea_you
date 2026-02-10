package com.sea_you.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.xcontent.XContentType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.Date;

@Service
public class RankingService {

    @Autowired
    private RestHighLevelClient client; 

    @Autowired
    private ObjectMapper objectMapper; 

    public void sendFollowerCountToEs(int m_no, String m_nick, String m_name, int count) {
        try {
            Map<String, Object> dataMap = new HashMap<>();
            dataMap.put("m_no", m_no);
            dataMap.put("m_nick", m_nick);
            dataMap.put("name", m_name);         
            dataMap.put("follower_count", count);
            dataMap.put("log_date", new Date()); 


            String jsonString = objectMapper.writeValueAsString(dataMap);


            IndexRequest request = new IndexRequest("member_ranking")
                    .id(String.valueOf(m_no)) 
                    .source(jsonString, XContentType.JSON);

            client.index(request, RequestOptions.DEFAULT);
            

            System.out.println(">>> [ES 전송 완료] 이름: " + m_name + "(닉네임: " + m_nick + "), 팔로워수: " + count);

        } catch (Exception e) {
            System.err.println("!!! [ES 전송 실패] 에러 메시지: " + e.getMessage());
            e.printStackTrace();
        }
    }
}