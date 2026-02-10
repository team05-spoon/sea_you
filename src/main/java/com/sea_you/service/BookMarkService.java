package com.sea_you.service;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sea_you.dao.BookMarkDAO;
import com.sea_you.dao.MemberDAO;
import com.sea_you.dto.BeachDTO;
import com.sea_you.dto.MemberDTO;

@Service
public class BookMarkService {

    @Autowired
    private BookMarkDAO bookmarkDao;

    @Autowired
    private MemberDAO memberDao;

    // 공통 로직: 닉네임으로 회원 번호(m_no) 찾기
    private int getMNoByNick(String m_nick) {
        List<MemberDTO> memberList = memberDao.listDao();
        return memberList.stream()
                .filter(m -> m.getM_nick() != null && m.getM_nick().equals(m_nick))
                .map(MemberDTO::getM_no)
                .findFirst()
                .orElse(-1);
    }

    // 1. 검색 결과 페이지용: 사용자가 찜한 모든 bc_no 목록 가져오기
    public List<Integer> getMyBookmarkIds(String m_nick) {
        int m_no = getMNoByNick(m_nick);
        if (m_no != -1) {
            return bookmarkDao.getMyBookmarkIds(m_no);
        }
        return Collections.emptyList();
    }

    // 2. 찜 토글 기능 (추가/삭제)
    @Transactional
    public String toggleWithMemberId(String m_id, int bc_no) {
        int m_no = getMNoByNick(m_id);
        if (m_no != -1) {
            return toggleBookMark(m_no, bc_no);
        }
        return "LOGIN_REQUIRED";
    }

    // 3. 실제 DB 처리 (토글 상세)
    public String toggleBookMark(int m_no, int bc_no) {
        int count = bookmarkDao.checkBookMark(m_no, bc_no);
        if (count > 0) {
            bookmarkDao.deleteBookMark(m_no, bc_no);
            return "removed";
        } else {
            bookmarkDao.insertBookMark(m_no, bc_no);
            return "added";
        }
    }

    // 4. 상세 페이지용: 특정 해수욕장 찜 여부 확인
    public int checkUserBookmark(String m_id, int bc_no) {
        int m_no = getMNoByNick(m_id);
        if (m_no != -1) {
            return bookmarkDao.checkBookMark(m_no, bc_no);
        }
        return 0;
    }
    
    // 5. [내 찜 목록 페이지용]: 찜한 해수욕장의 전체 정보 리스트 가져오기
    public List<BeachDTO> getMyBookmarkList(String m_nick) {
        int m_no = getMNoByNick(m_nick);
        if (m_no != -1) {
            return bookmarkDao.selectMyBookMarks(m_no);
        }
        return Collections.emptyList();
    }
    @Transactional
    public void removeBookmark(String m_nick, int bc_no) {
        // 1. 닉네임(또는 ID)으로 m_no(회원번호)를 먼저 찾습니다.
        int m_no = getMNoByNick(m_nick);
        
        // 2. 회원을 찾았을 경우에만 삭제를 진행합니다.
        if (m_no != -1) {
            bookmarkDao.deleteBookMark(m_no, bc_no);
        }
    }
}