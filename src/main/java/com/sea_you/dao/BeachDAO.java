package com.sea_you.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.sea_you.dto.BeachDTO;

@Mapper
public interface BeachDAO {

    // 지역별 바다 목록 조회
    List<BeachDTO> selectByPlace(String place);

    // 바다 정보 수정
    int updateDao(BeachDTO dto);

    // ✅ 인기 바다 TOP 5 조회 (찜 횟수 기준)
    List<BeachDTO> getTop5Beaches();
}