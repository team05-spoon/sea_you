package com.sea_you.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ChatDTO {

	private int c_no;
	private String m_nick;
	private String c_content;
	private Date c_date;
	private int m_no;
	private String m_image;

}
