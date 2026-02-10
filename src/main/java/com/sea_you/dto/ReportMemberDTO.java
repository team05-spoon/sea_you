package com.sea_you.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ReportMemberDTO {
	private int rm_no;
	private int m_no;
	private String rm_nick;
	private String rm_ctg;
	private String rm_title;
	private String rm_content;
	private Date rm_date;
}
