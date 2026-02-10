package com.sea_you.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ReportBoardDTO {
    private int rb_no;     
    private int m_no;       
    private int rb_bno;     
    private String rb_ctg;
    private String rb_title;
    private String rb_content;
    private Date rb_date;
}
