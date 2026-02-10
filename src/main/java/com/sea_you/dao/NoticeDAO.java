package com.sea_you.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sea_you.dto.NoticeDTO;

@Mapper
public interface NoticeDAO {
	// 공지사항 목록
    public List<NoticeDTO> noticelistDao();

    // 공지사항 상세
    public NoticeDTO noticeviewDao(int n_no);

    // 공지사항 등록
    public int insert(NoticeDTO dto);

    // 공지사항 삭제
    public int delete(int n_no);
    
    // 공지사항 수정
    public int update(NoticeDTO dto);
}
