package com.sea_you.controller;

import java.security.Principal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sea_you.dto.CommentDTO;
import com.sea_you.service.CommentService;

@Controller
@RequestMapping("/Comment")
public class CommentController {

    @Autowired
    private CommentService commentService;

    @PostMapping("/Write")
    public String write(CommentDTO dto, Principal principal) {
        // 1. 로그인 체크
        if (principal == null) {
            return "redirect:/Member/MemberLoginForm";
        }

        // 2. 작성자 ID 설정 (현재 로그인한 사람)
        dto.setWriter(principal.getName());
        
        // 3. 서비스 호출 (서비스에서 m_no를 채우도록 로직을 짜는게 가장 좋습니다)
        commentService.insertComment(dto); 
        
        return "redirect:/Board/BoardDetail?b_no=" + dto.getBoard_id();
    }

    // [수정 핵심] Principal을 추가하여 로그인한 사용자의 ID를 가져옵니다.
    @GetMapping("/Like")
    public String like(@RequestParam("comment_id") int comment_id, 
                       @RequestParam("b_no") int b_no, 
                       Principal principal,
                       RedirectAttributes rttr) {
        
        // 로그인하지 않은 경우 처리
        if (principal == null) {
            return "redirect:/Member/MemberLoginForm";
        }

        // 서비스에 (댓글번호, 사용자ID) 두 개를 전달합니다.
        String m_id = principal.getName();
        boolean isSuccess = commentService.plusLike(comment_id, m_id);

        if (!isSuccess) {
            // 이미 좋아요를 누른 경우 알림 메시지 (JSP에서 ${msg}로 확인 가능)
            rttr.addFlashAttribute("msg", "이미 좋아요를 누르셨습니다.");
        }

        return "redirect:/Board/BoardDetail?b_no=" + b_no;
    }

    @GetMapping("/Delete")
    public String delete(@RequestParam("comment_id") int comment_id, 
                         @RequestParam("b_no") int b_no) {
        commentService.deleteComment(comment_id);
        return "redirect:/Board/BoardDetail?b_no=" + b_no;
    }
}