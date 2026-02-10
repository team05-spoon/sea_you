package com.sea_you.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sea_you.dao.MemberDAO;
import com.sea_you.dto.MemberDTO;
import com.sea_you.service.RankingService;

@RestController 
public class RankingController {

    @Autowired
    private RankingService rankingService;

    @Autowired
    private MemberDAO memberdao;

    // 브라우저 http://localhost:8080/sync-ranking (동기화)
    @GetMapping("/sync-ranking")
    public String syncRanking() {
        try {
            List<MemberDTO> memberList = memberdao.listDao();

            for (MemberDTO member : memberList) {
 
                int followerCount = memberdao.getFollowerCount(member.getM_no());


                rankingService.sendFollowerCountToEs(
                    member.getM_no(), 
                    member.getM_nick(), 
                    member.getM_name(), 
                    followerCount
                );
            }
            return "Kibana 데이터 동기화 성공! 총 " + memberList.size() + "명 전송됨.";
        } catch (Exception e) {
            e.printStackTrace();
            return "동기화 실패: " + e.getMessage();
        }
    }
}