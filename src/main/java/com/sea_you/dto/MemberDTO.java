package com.sea_you.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberDTO {

	private int m_no;
    private String m_nick;
    private String m_image;
    private MultipartFile m_file;
    private String m_pw;
    private String m_sex;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date m_birth;
    private String m_name;
    private String m_addr;
    private String m_tel;
    private String m_email;
    private String m_temp; // ← ADMIN / USER 구분용
    
}
