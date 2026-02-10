package com.sea_you.dto;

import lombok.Data;

@Data
public class CommentDTO {
    private int comment_id;    // 댓글 번호
    private int board_id;      // 게시글 번호
    private int parent_id;     // 부모 댓글 번호 (대댓글용)
    private String content;    // 내용
    private String writer;     // 작성자
    private String reg_date;   // 작성일
    private int like_count;    // 좋아요 수
    private String is_deleted; // 삭제 여부 ('Y', 'N')
    private int level;         // 계층 깊이 (오라클 LEVEL)
    private int m_no;
    private String m_image;
}