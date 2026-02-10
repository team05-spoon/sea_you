package com.sea_you.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sea_you.dao.MessageDAO;
import com.sea_you.dto.MessageDTO;

@Controller
public class MessageController {

    @Autowired
    private MessageDAO dao;

    // 공통 로직: 로그인한 유저의 m_nick(principal.getName())으로 m_no를 가져옴
    private int getLoginMno(Principal principal) {
        if (principal == null) return -1;
        String nick = principal.getName(); // 닉네임이 로그인 아이디
        Integer m_no = dao.getMnoById(nick);
        return (m_no == null) ? -1 : m_no;
    }

    @RequestMapping("/Message/MessageWriteForm")
    public String MessageWriteFrom(@RequestParam(value="recv_nick", required=false) String recv_nick, Model model) {
        model.addAttribute("recv_nick", recv_nick);
        return "Message/MessageWriteForm";
    }

    @RequestMapping("/Message/MessageWrite")
    public String MessageWrite(Principal principal, MessageDTO dto) {
        int m_no = getLoginMno(principal);
        if (m_no == -1) return "redirect:/login"; // 로그인 폼으로 리다이렉트
        
        dto.setSend_m_no(m_no);
        dao.writeDao(dto);
        return "redirect:/Message/SentMessageList";
    }

    @RequestMapping("/Message/SentMessageList")
    public String SentMessageList(Principal principal, Model model) {
        int m_no = getLoginMno(principal);
        if (m_no == -1) return "redirect:/login";
        
        model.addAttribute("list", dao.sendlistDao(m_no));
        return "Message/SentMessageList";
    }

    @RequestMapping("/Message/SentMessageView")
    public String SentMessageView(@RequestParam("ms_no") int ms_no, Model model) {
        model.addAttribute("dto", dao.viewDao(ms_no));
        return "Message/SentMessageView";
    }

    @RequestMapping("/Message/RecvMessageList")
    public String RecvMessageList(Principal principal, Model model) {
        int m_no = getLoginMno(principal);
        if (m_no == -1) return "redirect:/login";
        
        model.addAttribute("list", dao.listDao(m_no));
        return "Message/RecvMessageList";
    }

    @RequestMapping("/Message/RecvMessageView")
    public String RecvMessageView(Principal principal, @RequestParam("ms_no") int ms_no, Model model) {
        int m_no = getLoginMno(principal);
        if (m_no == -1) return "redirect:/login";

        dao.updateDao(m_no, ms_no); 

        model.addAttribute("dto", dao.viewDao(ms_no));
        return "Message/RecvMessageView";
    }

    @RequestMapping("/Message/DeleteSentMessage")
    public String DeleteSentMessage(@RequestParam("ms_no") int ms_no, @RequestParam("type") String type) {
        dao.deleteDao(ms_no, type);
        return "redirect:/Message/SentMessageList";
    }

    @RequestMapping("/Message/DeleteRecvMessage")
    public String DeleteRecvMessage(@RequestParam("ms_no") int ms_no, @RequestParam("type") String type) {
        dao.deleteDao(ms_no, type);
        return "redirect:/Message/RecvMessageList";
    }
    @RequestMapping("/Message/UnreadCount")
    @ResponseBody // ✅ 페이지 이동이 아니라 '숫자 데이터'만 보낸다는 선언!
    public int getUnreadCount(Principal principal) {
        int m_no = getLoginMno(principal); // 기존에 만들어두신 공통 로직 활용
        if (m_no == -1) return 0;
        
        // Mapper(DAO)에 추가했던 그 메서드 호출
        return dao.getUnreadCount(m_no);
    }
}