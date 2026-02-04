package com.sea_you.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.sea_you.dto.CommentDTO;

@Mapper
public interface CommentDAO {
    List<CommentDTO> getCommentList(int board_id);
    void insertComment(CommentDTO dto);
    
    // MyBatis에서 다중 파라미터를 식별하기 위해 @Param 사용
    int checkLikeExists(@Param("comment_id") int comment_id, @Param("m_id") String m_id);
    void insertLike(@Param("comment_id") int comment_id, @Param("m_id") String m_id);
    void plusLikeCount(int comment_id);
    
    void deleteComment(int comment_id);
}