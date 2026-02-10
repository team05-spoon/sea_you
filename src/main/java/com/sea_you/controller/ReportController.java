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
import com.sea_you.dto.MemberDTO;
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
        // 1) 신고 내역을 가져옵니다.
        ReportBoardDTO dto = bdao.reportviewDao(rb_no);
        
        if (dto == null) {
            return "redirect:/Report/ReportList";
        }

        // [핵심 추가] 2) 신고 내역에 적힌 원본 게시글 번호(rb_bno)로 실제 게시글 정보를 가져옵니다.
        // 이 코드가 없어서 그동안 화면에 안 나왔던 겁니다!
        com.sea_you.dto.BoardDTO boarddto = boardDAO.boardviewDao(dto.getRb_bno());

        // 3) 모델에 'dto'와 'boarddto' 두 개를 모두 담아서 JSP로 보냅니다.
        model.addAttribute("dto", dto);
        model.addAttribute("boarddto", boarddto); // JSP의 <% BoardDTO boarddto = ... %> 와 연결됨

        // 로그 확인 (콘솔창에 찍힘)
        System.out.println("신고번호: " + rb_no + " / 원본글번호: " + dto.getRb_bno());
        System.out.println("원본글 조회 결과: " + (boarddto == null ? "실패" : "성공"));

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
        // 1. 신고 내역 가져오기
        ReportMemberDTO dto = mdao.reportviewDao(rm_no);
        
        if (dto != null) {
            // 2. [수정] 신고자 번호(m_no)가 아닌, 신고 대상자 닉네임(rm_nick)으로 조회
            // memberDAO에 이미 만들어두신 findByMnick 메서드를 활용합니다.
            MemberDTO memberdto = memberDAO.findByMnick(dto.getRm_nick());

            model.addAttribute("dto", dto);         // 신고 내역
            model.addAttribute("memberdto", memberdto); // 진짜 '신고 당한 사람' 정보
        }
        
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