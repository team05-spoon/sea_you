package com.sea_you.dto;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeDTO {
	private int n_no;
	private String n_title;
	private String n_write;
	private Date n_date;
}
