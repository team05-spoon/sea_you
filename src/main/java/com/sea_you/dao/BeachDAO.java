package com.sea_you.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.sea_you.dto.BeachDTO;

@Repository
public class BeachDAO {

    private final SqlSession sqlSession;

    public BeachDAO(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    public List<BeachDTO> selectByPlace(String place) {
        return sqlSession.selectList("beach.selectByPlace", place);
    }
    public int updateDao(BeachDTO dto) {
        return sqlSession.update("beach.updateDao", dto);
    }
}

