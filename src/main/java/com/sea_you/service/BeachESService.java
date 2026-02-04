package com.sea_you.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sea_you.dto.BeachDTO;

@Service
public class BeachESService {

    @Autowired
    private RestHighLevelClient client;

    public void save(BeachDTO dto) throws Exception {
        IndexRequest request = new IndexRequest("beach")
                .id(String.valueOf(dto.getBc_no()))
                .source(dto.toESMap()); 

        client.index(request, RequestOptions.DEFAULT);
    }

    public List<Map<String, String>> autocompleteHighlight(String keyword) throws Exception {
        SearchRequest request = new SearchRequest("beach");
        SearchSourceBuilder source = new SearchSourceBuilder();
        source.size(10);

        source.query(QueryBuilders.matchQuery("bc_name.auto", keyword));

        HighlightBuilder highlight = new HighlightBuilder();
        highlight.field("bc_name"); 
        highlight.preTags("<em>");
        highlight.postTags("</em>");

        source.highlighter(highlight);
        request.source(source);

        SearchResponse response = client.search(request, RequestOptions.DEFAULT);
        List<Map<String, String>> result = new ArrayList<>();

        for (SearchHit hit : response.getHits()) {
            Map<String, Object> sourceMap = hit.getSourceAsMap();
            String bcName = sourceMap.get("bc_name") != null ? sourceMap.get("bc_name").toString() : "";
            String highlighted = bcName;

            if (hit.getHighlightFields().get("bc_name") != null) {
                highlighted = hit.getHighlightFields().get("bc_name").fragments()[0].string();
            }

            Map<String, String> map = new HashMap<>();
            map.put("title", bcName); 
            map.put("highlight", highlighted);
            result.add(map);
        }
        return result;
    }
    public List<BeachDTO> searchByKeyword(String keyword) throws Exception {
        SearchRequest request = new SearchRequest("beach");
        SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
        
        // 다중 필드 검색: 이름(bc_name) 또는 위치(bc_location)
        //sourceBuilder.query(QueryBuilders.multiMatchQuery(keyword, "bc_name", "bc_location"));
        sourceBuilder.query(
        	    QueryBuilders.boolQuery()
        	        .should(QueryBuilders.matchPhraseQuery("bc_name", keyword))
        	        .should(QueryBuilders.matchPhraseQuery("bc_location", keyword))
        	);
        sourceBuilder.size(100); 

        request.source(sourceBuilder);
        SearchResponse response = client.search(request, RequestOptions.DEFAULT);

        // 검색된 결과를 담을 BeachDTO 리스트 생성
        List<BeachDTO> beachList = new ArrayList<>();

        for (SearchHit hit : response.getHits()) {
            Map<String, Object> map = hit.getSourceAsMap();
            
            BeachDTO dto = new BeachDTO();
            // ES 맵 데이터를 BeachDTO 객체에 매핑
            dto.setBc_no(map.get("bc_no") != null ? (int) map.get("bc_no") : 0);
            dto.setBc_name(map.get("bc_name") != null ? map.get("bc_name").toString() : "");
            dto.setBc_location(map.get("bc_location") != null ? map.get("bc_location").toString() : "");
            dto.setBc_office(map.get("bc_office") != null ? map.get("bc_office").toString() : "");
            dto.setBc_image(map.get("bc_image") != null ? map.get("bc_image").toString() : "");
            
            beachList.add(dto); 
        }
        return beachList;
    }
    public void reindexAll(List<BeachDTO> allBeaches) throws Exception {
        for (BeachDTO dto : allBeaches) {
            save(dto); // 하나씩 ES에 저장 (기존 153번은 무시되고 새로 152번 등이 생성됨)
        }
    }
}