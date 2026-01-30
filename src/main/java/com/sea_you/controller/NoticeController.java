package com.sea_you.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.sea_you.dao.MemberDAO;
import com.sea_you.dao.NoticeDAO;
import com.sea_you.dto.MemberDTO;
import com.sea_you.dto.NoticeDTO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/Notice")
public class NoticeController {

    @Autowired
    private NoticeDAO noticeDAO;

    @Autowired
    private MemberDAO memberDAO;

    // 공통: 로그인 유저를 세션에 보장
    private MemberDTO syncLoginMemberToSession(Principal principal, HttpSession session) {
        if (principal == null) return null;

        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember != null) return loginMember;

        // principal.getName()이 m_nick 기준이면 이거 그대로
        loginMember = memberDAO.findByMnick(principal.getName());
        if (loginMember != null) session.setAttribute("loginMember", loginMember);

        return loginMember;
    }

    @GetMapping("/NoticeList")
    public String list(Model model, Principal principal, HttpSession session) {
        List<NoticeDTO> list = noticeDAO.noticelistDao();
        model.addAttribute("list", list);

        // 목록에서도 세션 동기화
        syncLoginMemberToSession(principal, session);

        return "Notice/NoticeList";
    }

    @GetMapping("/NoticeDetail")
    public String detail(@RequestParam("n_no") int n_no, Model model,
                         Principal principal, HttpSession session) {

        // ✅ 여기서도 세션 동기화 (이게 핵심)
        syncLoginMemberToSession(principal, session);

        model.addAttribute("dto", noticeDAO.noticeviewDao(n_no));
        return "Notice/NoticeDetail";
    }

    @GetMapping("/NoticeWriteForm")
    public String writeForm(Principal principal, HttpSession session) {
        MemberDTO mdto = syncLoginMemberToSession(principal, session);
        if (mdto == null) return "redirect:/Member/MemberLoginForm";
        if (!"ADMIN".equals(mdto.getM_temp())) return "redirect:/";
        return "Notice/NoticeWriteForm";
    }

    @PostMapping("/NoticeWrite")
    public String write(NoticeDTO dto, Principal principal, HttpSession session) {
        MemberDTO mdto = syncLoginMemberToSession(principal, session);
        if (mdto == null) return "redirect:/Member/MemberLoginForm";
        if (!"ADMIN".equals(mdto.getM_temp())) return "redirect:/Notice/NoticeList";

        dto.setN_write(dto.getN_write());

        noticeDAO.insert(dto);
        return "redirect:/Notice/NoticeList";
    }

    @GetMapping("/NoticeEdit")
    public String editForm(@RequestParam("n_no") int n_no, Model model,
                           Principal principal, HttpSession session) {
        MemberDTO mdto = syncLoginMemberToSession(principal, session);
        if (mdto == null) return "redirect:/Member/MemberLoginForm";
        if (!"ADMIN".equals(mdto.getM_temp())) return "redirect:/Notice/NoticeList";

        model.addAttribute("dto", noticeDAO.noticeviewDao(n_no));
        return "Notice/NoticeEdit";
    }

    @PostMapping("/NoticeEdit")
    public String noticeEdit(NoticeDTO dto, Principal principal, HttpSession session) {
        MemberDTO mdto = syncLoginMemberToSession(principal, session);
        if (mdto == null) return "redirect:/Member/MemberLoginForm";
        if (!"ADMIN".equals(mdto.getM_temp())) return "redirect:/Notice/NoticeList";

        noticeDAO.update(dto);
        return "redirect:/Notice/NoticeDetail?n_no=" + dto.getN_no();
    }

    @PostMapping("/NoticeDelete")
    public String delete(@RequestParam("n_no") int n_no, Principal principal, HttpSession session) {
        MemberDTO mdto = syncLoginMemberToSession(principal, session);
        if (mdto == null) return "redirect:/Member/MemberLoginForm";
        if (!"ADMIN".equals(mdto.getM_temp())) return "redirect:/Notice/NoticeList";

        noticeDAO.delete(n_no);
        return "redirect:/Notice/NoticeList";
    }
}
