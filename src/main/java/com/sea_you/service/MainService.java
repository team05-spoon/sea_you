package com.sea_you.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sea_you.dao.MainDAO;
import com.sea_you.dto.BeachDTO; // 이 부분이 반드시 있어야 오류가 안 납니다!
import com.sea_you.dto.BoardDTO;
import com.sea_you.dto.NoticeDTO;

@Service
public class MainService {
    
    @Autowired
    private MainDAO dao; 
    
    @Autowired
    private BeachESService esService; 

    public List<BeachDTO> searchBeaches(String keyword) throws Exception {
        // return esService.searchByKeyword(keyword); // <--- ES 대신
        return dao.searchBeaches(keyword);            // <--- 아까 수정한 매퍼(Oracle)를 호출하게 변경
    }

    public List<NoticeDTO> getNoticeList() {
        return dao.selectRecentNotices();
    }

    public List<BoardDTO> getBoardList() {
        return dao.selectRecentBoards();
    }

    public List<Map<String, String>> autocomplete(String keyword) throws Exception {
        return esService.autocompleteHighlight(keyword);
    }
    
    public BeachDTO getBeachDetail(int bc_no) {
        return dao.getBeachDetail(bc_no);
    }

    /**
     * Oracle DB 데이터를 Elasticsearch로 동기화하는 메서드
     */
    public void syncBeachData() throws Exception {
        // 1. DB에서 모든 해수욕장 정보를 가져옴
        List<BeachDTO> list = dao.selectAllBeaches(); 

        // 2. 루프를 돌며 ES에 하나씩 인덱싱(저장)
        for (BeachDTO beach : list) {
            // BeachESService에 구현된 save() 메서드 호출
            esService.save(beach); 
        }
        System.out.println(">>> 동기화 완료: " + list.size() + "건의 해수욕장 데이터가 ES에 저장되었습니다.");
    }
    
}