package com.sea_you.controller; // 본인의 패키지 경로에 맞게 수정

import java.security.Principal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import com.sea_you.dao.MemberDAO;
import com.sea_you.dto.MemberDTO;

@ControllerAdvice // 모든 컨트롤러에 이 로직을 적용하겠다는 뜻!
public class GlobalControllerAdvice {

    @Autowired
    private MemberDAO memberdao;

    @ModelAttribute("member") // 모든 JSP에서 ${member}라는 이름으로 사용 가능하게 함
    public MemberDTO addMemberToModel(Principal principal) {
        if (principal != null) {
            // 로그인 상태라면 시큐리티가 가진 ID(name)로 DB에서 회원 정보를 가져옴
            return memberdao.findByMnick(principal.getName());
        }
        return null; // 비로그인 시에는 null
    }
}