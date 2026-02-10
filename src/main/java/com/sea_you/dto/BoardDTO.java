package com.sea_you.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardDTO {
    private int b_no;
    private String b_title;
    private String b_write;
    private String b_memo;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date b_date;
    private int m_no;
    private String m_image; 
    
    private MultipartFile b_file; // 실제 파일을 받는 용도
    private String b_image;       // DB에 파일 이름(문자열)을 저장하는 용도
    private int b_like_count;
}

