package com.sea_you.controller;

import java.io.File;
import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.sea_you.dao.BoardDAO;
import com.sea_you.dao.MemberDAO;
import com.sea_you.dto.BoardDTO;
import com.sea_you.dto.CommentDTO;
import com.sea_you.dto.MemberDTO;
import com.sea_you.service.CommentService;

@Controller
@RequestMapping("/Board")
public class BoardController {

    @Autowired
    private BoardDAO boardDAO;

    @Autowired
    private MemberDAO memberDAO;

    @Autowired
    private CommentService commentService;

    // 이미지 저장 물리 경로
    private final String UPLOAD_PATH = "C:/Springboot/sea_you/src/main/resources/static/images/b_images/";

    // 게시판 목록
    @GetMapping("/BoardList")
    public String list(Model model) {
        List<BoardDTO> list = boardDAO.boardlistDao();
        model.addAttribute("list", list);
        return "Board/BoardList";
    }

    // 게시글 상세
    @GetMapping("/BoardDetail")
    public String boardDetail(@RequestParam("b_no") int b_no, Model model, Principal principal) {
        // 1. 게시글 정보
        BoardDTO board = boardDAO.boardviewDao(b_no);
        model.addAttribute("dto", board);

        // 2. 좋아요 정보 (음수 트릭 적용)
        int targetId = b_no * -1;
        int likeCount = boardDAO.getBoardLikeCount(targetId);
        model.addAttribute("likeCount", likeCount);

        // 3. 내가 눌렀는지 확인
        boolean iLiked = false;
        if (principal != null) {
            String loginNick = principal.getName();
            int check = boardDAO.checkBoardLike(targetId, loginNick);
            iLiked = (check > 0);
        }
        model.addAttribute("iLiked", iLiked);

        // 4. 댓글 리스트
        List<CommentDTO> commentList = commentService.getCommentList(b_no);
        model.addAttribute("commentList", commentList);

        return "Board/BoardDetail"; 
    }
    @PostMapping("/BoardLikeAction")
    @ResponseBody
    public String boardLikeAction(@RequestParam("b_no") int b_no, Principal principal) {
        if (principal == null) return "login_required";

        String loginNick = principal.getName(); // m_nick 데이터를 가져옴
        int targetId = b_no * -1; // 게시글 좋아요는 음수로 저장

        // 이미 좋아요를 눌렀는지 확인
        int check = boardDAO.checkBoardLike(targetId, loginNick);

        if (check == 0) {
            boardDAO.insertBoardLike(targetId, loginNick);
            return "liked";
        } else {
            boardDAO.deleteBoardLike(targetId, loginNick);
            return "unliked";
        }
    }

    // 게시글 작성 폼
    @GetMapping("/BoardWrite")
    public String writeForm(Principal principal) {
        if (principal == null) return "redirect:/Member/MemberLoginForm";
        return "Board/BoardWriteForm";
    }
    

    // 게시글 작성 처리
    @PostMapping("/BoardWrite")
    public String write(@RequestParam("b_title") String b_title,
                        @RequestParam("b_memo") String b_memo,
                        @RequestParam(value = "b_image", required = false) MultipartFile b_image, 
                        Principal principal) {
        if (principal == null) return "redirect:/Member/MemberLoginForm";

        MemberDTO loginMember = memberDAO.findByMnick(principal.getName());
        BoardDTO dto = new BoardDTO();
        dto.setB_title(b_title);
        dto.setB_memo(b_memo);
        dto.setB_write(loginMember.getM_nick());
        dto.setM_no(loginMember.getM_no());

        if (b_image != null && !b_image.isEmpty()) {
            try {
                String fileName = System.currentTimeMillis() + "_" + b_image.getOriginalFilename();
                b_image.transferTo(new File(UPLOAD_PATH + fileName));
                dto.setB_image(fileName);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        boardDAO.insert(dto);
        return "redirect:/Board/BoardList";
    }

    // 게시글 수정 폼
    @GetMapping("/BoardEdit")
    public String editForm(@RequestParam("b_no") int b_no, Model model, Principal principal) {
        if (principal == null) return "redirect:/Member/MemberLoginForm";
        BoardDTO dto = boardDAO.boardviewDao(b_no);
        model.addAttribute("dto", dto);
        return "Board/BoardEdit";
    }

    /**
     * 핵심 수정 부분: 
     * @ModelAttribute BoardDTO 대신 @RequestParam으로 개별 값을 받습니다.
     * 이렇게 해야 HTML의 'b_image'(파일)가 DTO의 'b_image'(문자열)에 자동으로 꽂혀서 에러나는 현상을 막습니다.
     */
    @PostMapping("/BoardEdit")
    public String editUpdate(@RequestParam("b_no") int b_no,
                             @RequestParam("b_title") String b_title,
                             @RequestParam("b_memo") String b_memo,
                             @RequestParam(value = "b_image", required = false) MultipartFile b_image, 
                             Principal principal) {
        
        if (principal == null) return "redirect:/Member/MemberLoginForm";

        // 1. 기존 게시글 정보와 로그인 유저 확인
        BoardDTO existingDto = boardDAO.boardviewDao(b_no);
        MemberDTO loginMember = memberDAO.findByMnick(principal.getName());

        if (existingDto != null && loginMember != null && existingDto.getM_no() == loginMember.getM_no()) {
            
            BoardDTO updateDto = new BoardDTO();
            updateDto.setB_no(b_no);
            updateDto.setB_title(b_title);
            updateDto.setB_memo(b_memo);
            
            // 2. 이미지 처리
            if (b_image != null && !b_image.isEmpty()) {
                try {
                    // 기존 이미지가 있다면 파일 시스템에서 삭제
                    if (existingDto.getB_image() != null) {
                        File oldFile = new File(UPLOAD_PATH + existingDto.getB_image());
                        if (oldFile.exists()) oldFile.delete();
                    }
                    // 새로운 이미지 파일 저장
                    String fileName = System.currentTimeMillis() + "_" + b_image.getOriginalFilename();
                    b_image.transferTo(new File(UPLOAD_PATH + fileName));
                    updateDto.setB_image(fileName); // 새 파일명 설정
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                // 3. 새 이미지가 안 올라왔다면 기존 파일명 유지 (이미지가 삭제되지 않게)
                updateDto.setB_image(existingDto.getB_image());
            }

            // 4. DB 업데이트
            boardDAO.update(updateDto);
        }

        return "redirect:/Board/BoardDetail?b_no=" + b_no;
    }

    // 게시글 삭제
    @GetMapping("/BoardDelete")
    public String delete(@RequestParam("b_no") int b_no, Principal principal) {
        if (principal == null) return "redirect:/Member/MemberLoginForm";
        BoardDTO dto = boardDAO.boardviewDao(b_no);
        if (dto != null) {
            // 파일 삭제 후 DB 데이터 삭제
            if (dto.getB_image() != null) {
                File file = new File(UPLOAD_PATH + dto.getB_image());
                if (file.exists()) file.delete();
            }
            boardDAO.delete(b_no);
        }
        return "redirect:/Board/BoardList";
    }
}