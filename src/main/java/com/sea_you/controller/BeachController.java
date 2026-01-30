package com.sea_you.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sea_you.dao.BeachDAO;
import com.sea_you.dto.BeachDTO;
import com.sea_you.service.BookMarkService;
import com.sea_you.service.MainService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class BeachController {

    @Autowired
    private MainService mainService;

    @Autowired
    private BeachDAO dao;

    @Autowired
    private BookMarkService bookmarkService;

    // =========================================
    // 1) 검색 결과 페이지 (Elasticsearch)
    // URL: /search?keyword=광안리
    // =========================================
    @RequestMapping("/search")
    public String search(@RequestParam("keyword") String keyword, Principal principal, Model model) {
        try {
            List<BeachDTO> searchList = mainService.searchBeaches(keyword);

            if (principal != null) {
                String m_id = principal.getName();
                model.addAttribute("m_id", m_id);

                List<Integer> myBookmarkIds = bookmarkService.getMyBookmarkIds(m_id);
                model.addAttribute("myBookmarkIds", myBookmarkIds);
            }

            model.addAttribute("keyword", keyword);
            model.addAttribute("searchList", searchList);
            model.addAttribute("count", searchList.size());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "SearchList";
    }

    // =========================================
    // 2) 검색 자동완성
    // URL: /autocomplete?keyword=광
    // =========================================
    @ResponseBody
    @RequestMapping("/autocomplete")
    public List<Map<String, String>> autocomplete(@RequestParam("keyword") String keyword) throws Exception {
        return mainService.autocomplete(keyword);
    }

    // =========================================
    // 3) 해수욕장 상세
    // URL: /Beach/BeachDetail?bc_no=123
    // =========================================
    @GetMapping("/Beach/BeachDetail")
    public String beachDetail(@RequestParam("bc_no") int bc_no, Principal principal, Model model) {

        BeachDTO beach = mainService.getBeachDetail(bc_no);
        model.addAttribute("beach", beach);

        int isBookMarked = 0;
        if (principal != null) {
            String m_id = principal.getName();
            isBookMarked = bookmarkService.checkUserBookmark(m_id, bc_no);
        }
        model.addAttribute("isBookMarked", isBookMarked);

        return "Beach/BeachDetail";
    }

    // =========================================
    // 4) 내 북마크
    // URL: /myBookMark
    // =========================================
    @RequestMapping("/myBookMark")
    public String myBookMark(Principal principal, Model model) {

        String m_id = principal.getName();
        List<BeachDTO> bookmarkList = bookmarkService.getMyBookmarkList(m_id);

        model.addAttribute("bookmarkList", bookmarkList);
        model.addAttribute("m_id", m_id);

        return "BookMark/MyBookMarkList";
    }

    // =========================================
    // ✅ 5) 지역별(PLACE) 목록 - 방탄 통합
    // URL:
    //   /Beach/list?place=강원도
    //   /Beach/BeachList?place=강원도   (예전 링크도 커버)
    // place 없이 들어오면 400 대신 메인으로 redirect
    // =========================================
    @GetMapping({"/Beach/list", "/Beach/BeachList"})
    public String listByPlace(
            @RequestParam(value = "place", required = false) String place,
            Model model) {

        if (place == null || place.isBlank()) {
            return "redirect:/"; // ✅ place 없으면 메인으로
        }

        List<BeachDTO> list = dao.selectByPlace(place);

        model.addAttribute("place", place);
        model.addAttribute("list", list);

        return "Beach/BeachList"; // /WEB-INF/views/Beach/BeachList.jsp
    }
    // 다 올리고 이 밑으로 삭제
    @RequestMapping("/Beach/updatePhoto")
    public String updatePhoto(@RequestParam("bc_file") MultipartFile bc_file, BeachDTO dto) throws Exception {
        
        // 1. 파일이 비어있지 않은지 확인
        if(!bc_file.isEmpty()) {
            String bc_image = bc_file.getOriginalFilename();
            
            // 2. 저장 경로 (MemberController 방식 유지)
            // 주의: 폴더 경로가 실제로 존재해야 에러가 안 납니다!
            File savePath = new File("C:\\Springboot\\sea_you\\src\\main\\resources\\static\\images\\bc_images\\" + bc_image);
            
            // 3. 파일 물리 저장
            bc_file.transferTo(savePath);
            
            // 4. DTO에 파일명 세팅 (DB 저장용)
            dto.setBc_image(bc_image);
        }
        
        // 5. DAO 호출 (앞서 만든 bc_no와 bc_image만 업데이트하는 쿼리 실행)
        dao.updateDao(dto);
        
        // 업데이트 후 상세 페이지로 리다이렉트 (bc_no 유지)
        return "redirect:/Beach/BeachDetail?bc_no=" + dto.getBc_no();
    }
    @GetMapping("/admin/sync")
    @ResponseBody
    public String syncBeachData() {
        try {
            // MainService에 있는 syncBeachData() 호출
            mainService.syncBeachData();
            return "<h1>동기화 완료!</h1><p>이제 검색 결과에서 사진이 보일 거예요.</p><br><a href='/'>메인으로</a>";
        } catch (Exception e) {
            e.printStackTrace();
            return "동기화 실패: " + e.getMessage();
        }
    }
}
