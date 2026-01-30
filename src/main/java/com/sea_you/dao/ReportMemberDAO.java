package com.sea_you.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sea_you.dto.ReportMemberDTO;

@Mapper
public interface ReportMemberDAO {

    // 신고 등록
    public int insert(ReportMemberDTO dto);

    // 신고 목록(관리자용)
    public List<ReportMemberDTO> reportadminlist();
    
    // 신고 목록(사용자 확인용)
    public List<ReportMemberDTO> reportmemberlist();

    // 신고 상세보기(관리자만)
    public ReportMemberDTO reportviewDao(int rm_no);

    public int reportDeleteDao(int rm_no);
}