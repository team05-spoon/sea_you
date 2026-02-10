package com.sea_you.controller;

import java.io.File;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sea_you.dao.BoardDAO;
import com.sea_you.dao.FollowDAO;
import com.sea_you.dao.MemberDAO;
import com.sea_you.dto.BoardDTO;
import com.sea_you.dto.MemberDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MemberController {

	@Autowired
	MemberDAO dao;
	
	@Autowired
	FollowDAO followdao;
	
	@Autowired
	BoardDAO boarddao;
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@RequestMapping("/Member/MemberLoginForm")
	public String MemberLoginForm() {
		return "Member/MemberLoginForm";
	}
	@RequestMapping("/Member/MemberWriteForm")
	public String MemberWriteForm() {
		return "Member/MemberWriteForm";
	}
	@RequestMapping("/Member/MemberAllView")
	public String memberAllView(Model model) {
	    // DB에서 m_nick != 'admin'인 데이터만 가져옴
	    List<MemberDTO> memberList = dao.mlistDao();
	    
	    model.addAttribute("list", memberList);
	    return "Member/MemberAllView"; 
	}
	@RequestMapping("/Member/MemberWrite") 
	public String write( @RequestParam("m_file") MultipartFile m_file, MemberDTO dto) throws Exception {
		if(!m_file.isEmpty()) {
			String m_image = m_file.getOriginalFilename();
			m_file.transferTo(new File("C:\\Springboot\\sea_you\\src\\main\\resources\\static\\m_images\\"+m_image));
			
			dto.setM_image(m_image); } 
		
		String encodedPassword = passwordEncoder.encode(dto.getM_pw());
    	dto.setM_pw(encodedPassword);
		
		dao.writeDao(dto);
			
		return "redirect:/Member/MemberLoginForm";
		}
	@RequestMapping("/Member/MemberList")
	public String MemberList(Model model) {
		model.addAttribute("list",dao.listDao());
		return "Member/MemberList";
	}
	@RequestMapping("/Member/AdminDelete")
	public String AdminDelete(HttpServletRequest request) {
		int m_no = Integer.parseInt(request.getParameter("m_no"));
		dao.deleteDao(m_no);
		return "redirect:/Member/MemberList";
	}
	@RequestMapping("Member/MemberDeleteForm")
	public String MemberDeleteForm(@RequestParam("m_no") int m_no, Model model) {
		model.addAttribute("view", dao.viewDao(m_no));
		return "Member/MemberDeleteForm";
	}
	@RequestMapping("/Member/MemberDelete")
	public String MemberDelete(@RequestParam("m_no") int m_no, HttpServletRequest request) {
		
		dao.deleteDao(m_no);
		request.getSession().invalidate();
		return "redirect:/";
	}
	@RequestMapping("/Member/MemberUpdateForm")
	public String MemberUpdateForm(HttpServletRequest reqeust, Model model) {
		int m_no = Integer.parseInt(reqeust.getParameter("m_no"));
		model.addAttribute("update",dao.viewDao(m_no));
		return "Member/MemberUpdateForm";
	}
	@RequestMapping("/Member/MemberUpdate")
	public String MemberUpdate(@RequestParam("m_file") MultipartFile m_file,
			MemberDTO dto) throws Exception {
		if(!m_file.isEmpty()) {String m_image = m_file.getOriginalFilename();
		m_file.transferTo(new File("C:\\Springboot\\sea_you\\src\\main\\resources\\static\\m_images\\"+m_image));
		dto.setM_image(m_image);}
		
		MemberDTO existingMember = dao.viewDao(dto.getM_no());

	       
        if (dto.getM_pw() != null && !dto.getM_pw().trim().isEmpty()) {
            
            String encodedPassword = passwordEncoder.encode(dto.getM_pw());
            dto.setM_pw(encodedPassword);
        } else {
            
            dto.setM_pw(existingMember.getM_pw());
        }
		dao.updateDao(dto);
		return "redirect:/";
	}
	@RequestMapping("/Member/AdminMemberView")
	public String AdminMemberview(HttpServletRequest request, Model model,Principal principal) {
		int m_no = Integer.parseInt(request.getParameter("m_no"));
		model.addAttribute("view",dao.viewDao(m_no));
		model.addAttribute("followerCount", followdao.getFollowerCount(m_no));
	    model.addAttribute("followingCount", followdao.getFollowingCount(m_no));

	    if (principal != null) {
	        MemberDTO myInfo = dao.findByMnick(principal.getName()); 
	        model.addAttribute("member", myInfo);

	        // ✅ 내가 이 사람을 팔로우 중인지 확인 (0이면 false, 1이면 true)
	        int check = followdao.checkFollow(myInfo.getM_no(), m_no);
	        model.addAttribute("isFollowing", check > 0);
	    }
		
		return "Member/AdminMemberView";
	}
	@RequestMapping("/Member/MemberView")
	public String sellerview(HttpServletRequest request, Model model, Principal principal) {
	    // 1. 파라미터로 넘어온 대상 회원의 번호(m_no) 확인
	    int m_no = Integer.parseInt(request.getParameter("m_no"));
	    
	    // 2. 대상 회원 정보 조회
	    MemberDTO viewMember = dao.viewDao(m_no);
	    model.addAttribute("view", viewMember);

	    // 3. 팔로워/팔로잉 숫자 조회
	    model.addAttribute("followerCount", followdao.getFollowerCount(m_no));
	    model.addAttribute("followingCount", followdao.getFollowingCount(m_no));

	    // 4. ✅ [새로 추가] 대상 회원이 작성한 게시글 목록 조회
	    // boarddao는 상단에 Autowired 되어 있어야 합니다.
	    List<BoardDTO> myBoardList = boarddao.boardListByMemberDao(m_no);
	    model.addAttribute("myBoardList", myBoardList);

	    // 5. 로그인 정보 확인 및 팔로우 여부 체크
	    if (principal != null) {
	        MemberDTO myInfo = dao.findByMnick(principal.getName()); 
	        model.addAttribute("member", myInfo);

	        // 내가 이 사람을 팔로우 중인지 확인
	        int check = followdao.checkFollow(myInfo.getM_no(), m_no);
	        model.addAttribute("isFollowing", check > 0);
	    }
	    
	    return "Member/MemberView";
	}
	@RequestMapping("/Member/jusoPopup")
	public String jusoPopup() {
	   
	    return "Member/jusoPopup"; 
	}
	@RequestMapping("/Member/toggleFollow")
	@ResponseBody
	public Map<String, Object> toggleFollow(@RequestParam("target_m_no") int targetNo, Principal principal) {
	    Map<String, Object> response = new HashMap<>();
	    
	    if (principal == null) {
	        response.put("status", "error");
	        response.put("message", "로그인이 필요합니다.");
	        return response;
	    }

	    MemberDTO myInfo = dao.findByMnick(principal.getName());
	    int myNo = myInfo.getM_no();

	    // 본인 팔로우 방지
	    if (myNo == targetNo) {
	        response.put("status", "error");
	        return response;
	    }

	    int check = followdao.checkFollow(myNo, targetNo);

	    if (check > 0) {
	        // 이미 팔로우 중이면 -> 언팔로우
	        followdao.unfollow(myNo, targetNo);
	        response.put("status", "unfollowed");
	    } else {
	        // 팔로우 중이 아니면 -> 팔로우
	        followdao.follow(myNo, targetNo);
	        response.put("status", "followed");
	    }

	    return response;
	}
	@RequestMapping("/Member/MyFollowList")
	public String followList(@RequestParam("type") String type, 
	                         @RequestParam("m_no") int m_no, 
	                         Model model) {
	    List<MemberDTO> list;
	    String title = type.equals("follower") ? "팔로워 목록" : "팔로잉 목록";
	    
	    if (type.equals("follower")) {
	        list = followdao.getFollowerList(m_no);
	    } else {
	        list = followdao.getFollowingList(m_no);
	    }
	    
	    model.addAttribute("list", list);
	    model.addAttribute("title", title);
	    return "Member/MyFollowList"; 
	}
	@GetMapping("/Member/FollowerRank")
	@ResponseBody
	public List<Map<String, Object>> getFollowerRank() {
	    // DAO에서 실시간 순위 데이터를 가져와 JSON으로 리턴
	    return dao.getTopFollowers();
	}
	
	@GetMapping("/Member/IdCheck")
	@ResponseBody // 결과값만 그대로 반환
	public int idCheck(@RequestParam("m_nick") String m_nick) {
	    
	    return dao.checkNick(m_nick); 
	}
	
}
