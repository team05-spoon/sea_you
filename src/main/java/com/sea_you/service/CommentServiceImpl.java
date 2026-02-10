package com.sea_you.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sea_you.dao.CommentDAO;
import com.sea_you.dao.MemberDAO;
import com.sea_you.dto.CommentDTO;
import com.sea_you.dto.MemberDTO;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentDAO commentDAO;
    
    @Autowired
    private MemberDAO memberDAO;

    // 상세 페이지에서 댓글 목록을 가져오는 메서드
    @Override
    public List<CommentDTO> getCommentList(int board_id) {
        return commentDAO.getCommentList(board_id);
    }

    // 댓글 작성
    @Override
    public void insertComment(CommentDTO dto) {
        // 1. dto.getWriter()(닉네임)를 이용해 회원 정보를 찾습니다.
        // 이미 MemberDAO에 만들어두신 findByMnick 메서드를 사용합니다.
        MemberDTO member = memberDAO.findByMnick(dto.getWriter());
        
        if (member != null) {
            // 2. 찾은 회원 객체에서 m_no를 꺼내 DTO에 세팅합니다.
            dto.setM_no(member.getM_no());
        }
        
        // 3. 이제 m_no가 채워진 상태로 DB에 저장됩니다.
        commentDAO.insertComment(dto);
    }
    // 중복 방지 좋아요 로직
    @Override
    public boolean plusLike(int comment_id, String m_id) {
        try {
            // 1. 바로 저장 시도 (중복이면 UNIQUE 제약조건 때문에 에러 발생)
            commentDAO.insertLike(comment_id, m_id);
            
            // 2. 저장 성공 시 카운트 증가
            commentDAO.plusLikeCount(comment_id);
            return true;
        } catch (Exception e) {
            // 3. 이미 눌렀거나 에러 발생 시 처리
            System.out.println("좋아요 처리 중단 (중복 또는 오류): " + e.getMessage());
            return false;
        }
    }

    // 댓글 삭제
    @Override
    public void deleteComment(int comment_id) {
        commentDAO.deleteComment(comment_id);
    }
}