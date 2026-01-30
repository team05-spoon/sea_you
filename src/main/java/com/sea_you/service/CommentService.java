package com.sea_you.service;

import java.util.List;
import com.sea_you.dto.CommentDTO;

public interface CommentService {
    List<CommentDTO> getCommentList(int board_id); // 이 부분이 누락되지 않았는지 확인
    void insertComment(CommentDTO dto);
    boolean plusLike(int comment_id, String m_id); 
    void deleteComment(int comment_id);
}