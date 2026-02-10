package com.sea_you.dto;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BeachDTO {
    private int bc_no;
    private String bc_name;
    private String bc_location;
    private String bc_office;
    private String bc_length;
    private String bc_width;
    private String bc_area;
    private MultipartFile bc_file;
    private String bc_image;
    private String es_id; // 엘라스틱서치 인덱싱용 ID
    private int bookmark_count;

    /**
     * Elasticsearch 저장을 위해 DTO를 Map 구조로 변환하는 메서드
     */
    public Map<String, Object> toESMap() {
        Map<String, Object> map = new HashMap<>();
        
        // 검색에 필요한 필드들을 Map에 담습니다.
        map.put("bc_no", this.bc_no);
        map.put("bc_name", this.bc_name); // 검색 결과 표시를 위해 title이라는 이름으로 매핑
        map.put("bc_location", this.bc_location);
        map.put("bc_office", this.bc_office);
        map.put("bc_image", this.bc_image);
        map.put("es_id", this.es_id);
        
        return map;
    }
}