package com.sea_you.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sea_you.dao.BeachDAO;
import com.sea_you.dao.MemberDAO;
import com.sea_you.dto.BeachDTO;
import com.sea_you.dto.BoardDTO;
import com.sea_you.dto.MemberDTO;
import com.sea_you.dto.NoticeDTO;
import com.sea_you.service.MainService;

@Controller
public class MainController {

    @Autowired
    private MainService mainService;
    
    @Autowired
    private MemberDAO memberdao;
    
    @Autowired
    private BeachDAO beachdao;

    @GetMapping("/")
    public String mainPage(Model model,Principal principal) {
        try {
            List<NoticeDTO> noticeList = mainService.getNoticeList();
            List<BoardDTO> boardList = mainService.getBoardList();
            
            List<BeachDTO> topBeaches = beachdao.getTop5Beaches();
            
            model.addAttribute("noticeList", noticeList);
            model.addAttribute("boardList", boardList);
            model.addAttribute("topBeaches", topBeaches);
            
            if (principal != null) {
             
                MemberDTO member = memberdao.findByMnick(principal.getName()); 
                model.addAttribute("member", member); 
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "Main";
    }

    @GetMapping("/autocomplete")
    @ResponseBody
    public List<Map<String, String>> autocomplete(@RequestParam("keyword") String keyword) {
        try {
            return mainService.autocomplete(keyword);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @GetMapping("/sync-beach")
    @ResponseBody
    public String syncBeach() {
        try {
            mainService.syncBeachData();
            return "Success: Beach data synchronized to Elasticsearch.";
        } catch (Exception e) {
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }
    }
}