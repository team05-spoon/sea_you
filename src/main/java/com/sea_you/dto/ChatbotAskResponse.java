package com.sea_you.dto;

public class ChatbotAskResponse {
    private String reply;
    public ChatbotAskResponse() {}
    public ChatbotAskResponse(String reply) { this.reply = reply; }
    public String getReply() { return reply; }
    public void setReply(String reply) { this.reply = reply; }
}
