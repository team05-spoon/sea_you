package com.sea_you.controller;

import java.security.Principal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sea_you.dao.MemberDAO;
import com.sea_you.dao.ReportBoardDAO;
import com.sea_you.dto.MemberDTO;
import com.sea_you.dto.ReportBoardDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReportBoardController {

    @Autowired
    private ReportBoardDAO reportBoardDao;

    @Autowired
    private MemberDAO memberDao;

    @RequestMapping(value = "/Report/ReportBoardWriteForm", method = {RequestMethod.GET, RequestMethod.POST})
    public String write(
            @RequestParam(value="target_b_no", required=false, defaultValue="0") int targetBno,
            @RequestParam(value="rb_ctg", required=false) String rbCtg,
            @RequestParam(value="rb_title", required=false) String rbTitle,
            @RequestParam(value="rb_content", required=false) String rbContent,
            HttpServletRequest request,
            Principal principal,
            HttpSession session,
            Model model) {

        // 1. GET: 신고 폼 열기
        if ("GET".equalsIgnoreCase(request.getMethod())) {
            model.addAttribute("targetBno", targetBno);
            return "Report/ReportBoardWriteForm";
        }

        // 2. POST: DB 저장
        if (principal == null) return "redirect:/Member/MemberLoginForm";

        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            loginUser = memberDao.findByMnick(principal.getName());
        }

        // [DTO 생성 및 데이터 매핑]
        // ★ 테이블/DTO 필드명인 m_no와 rb_bno를 사용합니다.
        ReportBoardDTO dto = new ReportBoardDTO();
        
        dto.setM_no(loginUser.getM_no());     // 신고자 번호 (m_no)
        dto.setRb_bno(targetBno);             // 대상 게시글 번호 (rb_bno)
        
        dto.setRb_ctg(rbCtg);
        dto.setRb_title(rbTitle);
        dto.setRb_content(rbContent);

        // DB 인서트
        reportBoardDao.insert(dto);

        return "redirect:/Board/BoardList"; 
    }
}