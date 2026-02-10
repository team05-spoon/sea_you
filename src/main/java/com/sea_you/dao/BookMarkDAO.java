package com.sea_you.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import com.sea_you.dto.BeachDTO;

@Mapper
public interface BookMarkDAO {
    // 파라미터가 2개 이상일 때는 @Param을 붙여주는 것이 XML 매핑에 안전합니다.
    int checkBookMark(@Param("m_no") int m_no, @Param("bc_no") int bc_no);
    
    void insertBookMark(@Param("m_no") int m_no, @Param("bc_no") int bc_no);
    
    void deleteBookMark(@Param("m_no") int m_no, @Param("bc_no") int bc_no);
    
    List<BeachDTO> selectMyBookMarks(int m_no);
    
    List<Integer> getMyBookmarkIds(int m_no);
    
   public int deleteBookmark(@Param("m_no") String m_id, @Param("bc_no") int bc_no);
   
}