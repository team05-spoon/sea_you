package com.sea_you.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ReportDTO {
	private int r_no;
	private int m_no;
	private String r_type;
	private String r_nick;
	private String r_ctg;
	private String r_title;
	private String r_content;
	private Date r_date;
	private String r_am;
}
