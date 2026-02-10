package com.sea_you.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.sea_you.dto.BoardDTO;
import com.sea_you.dto.NoticeDTO;
import com.sea_you.dto.BeachDTO; // 이 줄이 반드시 추가되어야 합니다!

@Mapper
public interface MainDAO {
    // 1. 모든 해수욕장 정보를 가져오는 메서드
    List<BeachDTO> selectAllBeaches();

    // 2. 최근 공지사항/게시글 가져오기
    List<NoticeDTO> selectRecentNotices();
    List<BoardDTO> selectRecentBoards();
   
        
        // 특정 번호의 해수욕장 정보 딱 하나만 가져오기
        BeachDTO getBeachDetail(int bc_no);
        
        List<BeachDTO> searchBeaches(String keyword);
    }
