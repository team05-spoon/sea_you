package com.sea_you.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sea_you.dto.ReportDTO;

@Mapper
public interface ReportDAO {

    // 신고 등록
    public int insert(ReportDTO dto);

    // 신고 목록(관리자용)
    public List<ReportDTO> reportlist();

    // 타입별 목록 
    public List<ReportDTO> reporttype(@Param("r_type") String r_type);

    // 멤버랑 게시물중 어떤 신고인지 확인
    public List<ReportDTO> reportwhat(@Param("r_type") String r_type, @Param("r_nick") long r_nick);

    // 신고 상세보기
    public ReportDTO reportview(@Param("r_no") long r_no);
}