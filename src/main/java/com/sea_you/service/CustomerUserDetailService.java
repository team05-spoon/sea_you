package com.sea_you.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.sea_you.dao.MemberDAO;
import com.sea_you.dto.MemberDTO;

@Service
public class CustomerUserDetailService implements UserDetailsService {

	@Autowired
	private MemberDAO dao;
	
	@Autowired
	private PasswordEncoder passwordRncoder;
	
	@Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        MemberDTO dto = dao.findByMnick(username);
        if (dto == null) {
            throw new UsernameNotFoundException("사용자 없음");
        }
		
		return User.builder()
				.username(dto.getM_nick())
				.password(dto.getM_pw())
				.roles(dto.getM_temp())
				.build();
	}
}
