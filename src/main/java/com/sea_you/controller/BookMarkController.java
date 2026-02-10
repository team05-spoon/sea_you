package com.sea_you.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sea_you.dto.BeachDTO;
import com.sea_you.service.BookMarkService;

@Controller
public class BookMarkController {

    @Autowired
    private BookMarkService bookMarkService;

    @PostMapping("/bookmark/toggle")
    @ResponseBody
    public String toggleBookMark(@RequestParam("bc_no") int bc_no, Principal principal) {
        
        // 1. 시큐리티 세션에서 아이디 확인
        if (principal == null) {
            return "LOGIN_REQUIRED";
        }

        String m_id = principal.getName(); 

        // 2. 아이디를 기반으로 찜 처리를 하도록 서비스에 명령 (메서드 명 주의)
        return bookMarkService.toggleWithMemberId(m_id, bc_no);
    }
    @RequestMapping("/BookMark/MyBookMarkList")
    public String myBookMark(Principal principal, Model model) {
        if (principal == null) return "redirect:/login";
        
        String m_id = principal.getName(); 
        List<BeachDTO> bookmarkList = bookMarkService.getMyBookmarkList(m_id);

        model.addAttribute("bookmarkList", bookmarkList);
        model.addAttribute("m_id", m_id);
        
        // 이 리턴값이 JSP 파일의 경로와 "정확히" 일치해야 404가 안 납니다!
        return "BookMark/MyBookMarkList"; 
    }
    @RequestMapping("/BookMark/DeleteBookMark")
    public String DeleteBookmark(@RequestParam("bc_no") int bc_no, Principal principal) {
       bookMarkService.removeBookmark(principal.getName(), bc_no);
        return "redirect:/BookMark/MyBookMarkList";
    }
}