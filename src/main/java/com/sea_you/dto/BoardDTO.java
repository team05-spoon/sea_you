package com.sea_you.dto;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDTO {
	private int b_no;
	private String b_title;
	private String b_write;
	private String b_memo;
	private Date b_date;
	private int m_no;
	private String m_image; //1-28 게시판 아이콘나오게
}
