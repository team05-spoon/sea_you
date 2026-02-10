package com.sea_you.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sea_you.dto.BoardDTO;

@Mapper
public interface BoardDAO {
    public List<BoardDTO> boardlistDao();

    // @Param을 붙여서 XML의 #{b_no}와 이름을 강제로 맞춥니다.
    public BoardDTO boardviewDao(@Param("b_no") int b_no);

    public int insert(BoardDTO dto);
    public int update(BoardDTO dto);
    public int delete(@Param("b_no") int b_no);
    public int updateImage(BoardDTO dto);
    public List<BoardDTO> boardListByMemberDao(@Param("m_no") int m_no);
    
 // --- 💡 좋아요 기능 추가 (음수 targetId 활용) ---

 // 1. 좋아요 여부 확인
    public int checkBoardLike(@Param("targetId") int targetId, @Param("m_nick") String m_nick);

    // 2. 좋아요 추가
    public int insertBoardLike(@Param("targetId") int targetId, @Param("m_nick") String m_nick);

    // 3. 좋아요 삭제 (취소)
    public int deleteBoardLike(@Param("targetId") int targetId, @Param("m_nick") String m_nick);

    // 4. 총 좋아요 수 조회 (이건 닉네임 필요 없음)
    public int getBoardLikeCount(@Param("targetId") int targetId);
}

