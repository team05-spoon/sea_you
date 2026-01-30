package com.sea_you.controller;

import java.security.Principal;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.sea_you.dao.BoardDAO;
import com.sea_you.dao.MemberDAO;
import com.sea_you.dto.BoardDTO;
import com.sea_you.dto.CommentDTO;
import com.sea_you.dto.MemberDTO;
import com.sea_you.service.CommentService;

@Controller
@RequestMapping("/Board")
public class BoardController {
   
    @Autowired
    private BoardDAO boardDAO;

    @Autowired
    private MemberDAO memberDAO;

    @Autowired
    private CommentService commentService;
    
    // 게시판 목록
    @GetMapping("/BoardList")
    public String list(Model model) {
        List<BoardDTO> list = boardDAO.boardlistDao();
        model.addAttribute("list", list);
        return "Board/BoardList";
    }

    // [수정 핵심] @RequestParam 뒤에 ("b_no") 이름을 명시해야 합니다.
    @GetMapping("/BoardDetail")
    public String boardDetail(@RequestParam("b_no") int b_no, Model model) {
        BoardDTO board = boardDAO.boardviewDao(b_no);
        model.addAttribute("dto", board);

        List<CommentDTO> commentList = commentService.getCommentList(b_no);
        model.addAttribute("commentList", commentList);
        
        return "Board/BoardDetail"; 
    }

    // 나머지 메서드들도 동일하게 파라미터 이름을 명시하거나 객체로 받습니다.
    @GetMapping("/BoardWrite")
    public String writeForm(Principal principal) {
        if (principal == null) return "redirect:/Member/MemberLoginForm";
        return "Board/BoardWriteForm";
    }

    @PostMapping("/BoardWrite")
    public String write(@RequestParam("b_title") String b_title,
                        @RequestParam("b_memo") String b_memo,
                        Principal principal) {
        if (principal == null) return "redirect:/Member/MemberLoginForm";
        MemberDTO loginMember = memberDAO.findByMnick(principal.getName());
        if (loginMember == null) return "redirect:/Member/MemberLoginForm";

        BoardDTO dto = new BoardDTO();
        dto.setB_title(b_title);
        dto.setB_memo(b_memo);
        dto.setB_write(loginMember.getM_nick());
        dto.setM_no(loginMember.getM_no());

        boardDAO.insert(dto);
        return "redirect:/Board/BoardList";
    }

    @GetMapping("/BoardEdit")
    public String editForm(@RequestParam("b_no") int b_no, Model model, Principal principal) {
        if (principal == null) return "redirect:/Member/MemberLoginForm";
        MemberDTO loginMember = memberDAO.findByMnick(principal.getName());
        BoardDTO dto = boardDAO.boardviewDao(b_no);
        if (dto == null || dto.getM_no() != loginMember.getM_no()) {
            return "redirect:/Board/BoardDetail?b_no=" + b_no;
        }
        model.addAttribute("dto", dto);
        return "Board/BoardEdit";
    }
    @PostMapping("/BoardEdit")
    public String editUpdate(@ModelAttribute BoardDTO updateDto, Principal principal) {
        if (principal == null) return "redirect:/Member/MemberLoginForm";

        // 실제 작성자인지 DB에서 다시 확인 (보안)
        BoardDTO existingDto = boardDAO.boardviewDao(updateDto.getB_no());
        MemberDTO loginMember = memberDAO.findByMnick(principal.getName());

        if (existingDto != null && loginMember != null && existingDto.getM_no() == loginMember.getM_no()) {
            // DAO의 메서드명이 updateDao인지 확인하세요! 
            // 만중 혹은 다른 이름이라면 그에 맞게 수정 필요
            boardDAO.update(updateDto); 
        }

        return "redirect:/Board/BoardDetail?b_no=" + updateDto.getB_no();
    }
    @GetMapping("/BoardDelete")
    public String delete(@RequestParam("b_no") int b_no, Principal principal) {
        // 1. 로그인 여부 확인
        if (principal == null) return "redirect:/Member/MemberLoginForm";
        
        // 2. 본인 확인을 위한 정보 조회
        BoardDTO dto = boardDAO.boardviewDao(b_no);
        MemberDTO loginMember = memberDAO.findByMnick(principal.getName());
        
        // 3. 게시글이 존재하고, 로그인한 유저의 m_no와 작성자의 m_no가 일치할 때만 삭제
        if (dto != null && loginMember != null && dto.getM_no() == loginMember.getM_no()) {
            // DAO의 삭제 메서드 호출 (메서드명이 deleteDao인지 확인 필요)
            boardDAO.delete(b_no); 
        }
        
        // 4. 삭제 후 목록 페이지로 리다이렉트
        return "redirect:/Board/BoardList";
    }
}