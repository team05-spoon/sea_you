package com.sea_you.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sea_you.dao.ChatDAO;
import com.sea_you.dao.MemberDAO;
import com.sea_you.dto.ChatDTO;
import com.sea_you.dto.MemberDTO;

@Controller
public class ChatController {

  @Autowired
  private ChatDAO Dao;

  @Autowired
  private MemberDAO memberDAO;

  @RequestMapping(value = "/Chat/ChatRoom", method = RequestMethod.GET)
  public String chatPage() {
    return "Chat/ChatRoom";
  }

  @RequestMapping(value = "/Chat/Chatlist", method = RequestMethod.GET)
  @ResponseBody
  public List<ChatDTO> getChatList() {
    return Dao.listDao();
  }

  @RequestMapping(value = "/Chat/Chatsend", method = RequestMethod.POST)
  @ResponseBody
  public String sendChat(@RequestParam("content") String content, Principal principal) {

    if (principal == null) return "LOGIN_REQUIRED";

    String nick = principal.getName();

    MemberDTO mem = memberDAO.findByMnick(nick);
    if (mem == null) return "fail"; 

    ChatDTO dto = new ChatDTO();
    dto.setM_no(mem.getM_no());    
    dto.setM_nick(mem.getM_nick());  
    dto.setC_content(content);

    int result = Dao.writeDao(dto);
    return (result > 0) ? "ok" : "fail";
  }
}
