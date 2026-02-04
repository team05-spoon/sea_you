package com.sea_you.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sea_you.dto.BoardDTO;

@Mapper
public interface BoardDAO {
	// 게시글 목록
    public List<BoardDTO> boardlistDao();

    // 게시글 상세
    public BoardDTO boardviewDao(int b_no);

    // 게시글 등록
    public int insert(BoardDTO dto);

    // 게시글 수정
    public int update(BoardDTO dto);

    // 게시글 삭제
    public int delete(int b_no);
    
    public int updateImage(BoardDTO dto);  // 파일 경로 업데이트용
    }

