package com.sea_you.dto;

import java.util.Date;
import lombok.Data;

@Data
public class MessageDTO {

	private int ms_no;
	private int send_m_no;
	private int recv_m_no;
	private String ms_content;
	private Date ms_date;
	private String ms_read;
	private String send_del;
	private String recv_del;
	private String send_nick;
	private String recv_nick;
	private String send_image;
	private String recv_image;
	private String m_image;
}