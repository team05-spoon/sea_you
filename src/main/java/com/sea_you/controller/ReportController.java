package com.sea_you.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sea_you.dao.BoardDAO;
import com.sea_you.dao.MemberDAO;
import com.sea_you.dao.ReportBoardDAO;
import com.sea_you.dao.ReportMemberDAO;
import com.sea_you.dto.ReportBoardDTO;
import com.sea_you.dto.ReportMemberDTO;

@Controller
public class ReportController {
    
    @Autowired
    private ReportMemberDAO mdao; // ReportMemberDAO
    
    @Autowired
    private ReportBoardDAO bdao; // ReportBoardDAO
    
    @Autowired
    private BoardDAO boardDAO; // 원본 게시판 DAO
    
    @Autowired
    private MemberDAO memberDAO; // 회원 DAO
    
    // 1. 신고 통합 목록 (게시글 신고 + 회원 신고)
    @RequestMapping("/Report/ReportList")
    public String ReportList(Model model) {
        List<ReportBoardDTO> boardList = bdao.reportadminlist();
        List<ReportMemberDTO> memberList = mdao.reportadminlist();
 
        model.addAttribute("boardList", boardList);
        model.addAttribute("memberList", memberList);
        
        return "Report/ReportList";
    }
    
    // 2. 게시글 신고 상세보기
    @RequestMapping("/Report/ReportBoardDetail")
    public String ReportBoardDetail(@RequestParam("rb_no") int rb_no, Model model) {
        ReportBoardDTO dto = bdao.reportviewDao(rb_no);
        if (dto == null) {
            return "redirect:/Report/ReportList";
        }
        model.addAttribute("dto", dto);
        return "Report/ReportBoardDetail"; 
    }

    // 3. 신고된 원본 게시글 삭제 및 신고 내역 삭제
    @PostMapping("/Report/DeleteOriginalBoard")
    public String deleteOriginalBoard(
            @RequestParam("b_no") int b_no, 
            @RequestParam("rb_no") int rb_no) {

        boardDAO.delete(b_no);      // 원본 게시글 삭제
        bdao.reportDeleteDao(rb_no); // 신고 내역 삭제
        return "redirect:/Report/ReportList";
    }
    
    // 4. 회원 신고 상세보기
    @RequestMapping("/Report/ReportMemberDetail")
    public String ReportMemberDetail(@RequestParam("rm_no") int rm_no, Model model) {
        ReportMemberDTO dto = mdao.reportviewDao(rm_no);
        if (dto == null) {
            return "redirect:/Report/ReportList";
        }
        model.addAttribute("dto", dto);
        return "Report/ReportMemberDetail"; 
    }

    // 5. [핵심] 닉네임으로 회원 강제 탈퇴 및 신고 내역 삭제
    @PostMapping("/Report/DeleteMemberReport")
    public String deleteMemberReport(
            @RequestParam("m_nick") String mNick,
            @RequestParam("rm_no") int rmNo) {

        // 1. 자식 레코드(신고 내역)를 먼저 삭제 (순서 중요!)
        mdao.reportDeleteDao(rmNo);
        
        // 2. 부모 레코드(회원)를 그 다음에 삭제
        memberDAO.deletememberDao(mNick);

        System.out.println("삭제 완료 - 신고기록 선삭제 후 회원 삭제: " + mNick);

        return "redirect:/Report/ReportList"; 
    }
}