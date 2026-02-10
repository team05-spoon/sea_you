package com.sea_you.dto;

import lombok.Data;

@Data
public class BeachRankDTO {
	
	    private int bc_no;          // 바다 번호
	    private String bc_name;     // 바다 이름
	    private String bc_image;    // 바다 이미지 파일명
	    private int bookmark_count; // 찜 횟수 (SQL의 COUNT 결과)
	}

