package com.sea_you.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sea_you.dto.ReportBoardDTO;

@Mapper
public interface ReportBoardDAO {

    // 신고 등록
    public int insert(ReportBoardDTO dto);

    // 신고 목록(관리자용)
    public List<ReportBoardDTO> reportadminlist();
    
    // 신고 목록(사용자 확인용)
    public List<ReportBoardDTO> reportmemberlist();

    // 신고 상세보기(관리자만)
    public ReportBoardDTO reportviewDao(int rb_no);
    
    public int reportDeleteDao(int rb_no);
}