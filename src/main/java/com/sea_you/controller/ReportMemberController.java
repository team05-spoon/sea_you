package com.sea_you.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sea_you.dao.MemberDAO;
import com.sea_you.dao.ReportMemberDAO;
import com.sea_you.dto.MemberDTO;
import com.sea_you.dto.ReportMemberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReportMemberController {

    @Autowired
    private ReportMemberDAO reportDao;

    @Autowired
    private MemberDAO memberDao;

    @RequestMapping(value = "/Report/ReportMemberWriteForm", method = {RequestMethod.GET, RequestMethod.POST})
    public String write(
            @RequestParam(value="target_m_no", required=false, defaultValue="0") int targetMno,
            @RequestParam(value="rm_ctg", required=false, defaultValue="일반") String rmCtg,
            @RequestParam(value="rm_title", required=false, defaultValue="제목 없음") String rmTitle,
            @RequestParam(value="rm_content", required=false, defaultValue="내용 없음") String rmContent,
            HttpServletRequest request,
            Principal principal,
            HttpSession session,
            Model model) {


        if (principal == null) return "redirect:/Member/MemberLoginForm";

        if (targetMno <= 0) return "redirect:/";


        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) {

            loginUser = memberDao.findByMnick(principal.getName());
        }

        if (loginUser == null) return "redirect:/Member/MemberLoginForm";

        if (loginUser.getM_no() == targetMno) {
            return "redirect:/Member/MemberView?m_no=" + targetMno;
        }

        if ("GET".equalsIgnoreCase(request.getMethod())) {
            model.addAttribute("targetMno", targetMno);
            return "Report/ReportMemberWriteForm";
        }


        MemberDTO targetUser = memberDao.findByMno(targetMno);


        ReportMemberDTO dto = new ReportMemberDTO();
        dto.setM_no(loginUser.getM_no()); 

        if (targetUser != null) {
            dto.setRm_nick(targetUser.getM_nick()); 
        } else {
            dto.setRm_nick("Unknown");
        }

        dto.setRm_ctg(rmCtg);
        dto.setRm_title(rmTitle);
        dto.setRm_content(rmContent);

        // DB Insert
        reportDao.insert(dto);

        return "redirect:/";
    }
}
