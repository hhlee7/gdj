package com.example.ss.service;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.ss.domain.UserDomain;
import com.example.ss.dto.UserDto;
import com.example.ss.mapper.UserMapper;

@Service
public class UserService {
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	private UserMapper userMapper;
	
	public UserService(BCryptPasswordEncoder bCryptPasswordEncoder, UserMapper userMapper) {
		this.bCryptPasswordEncoder = bCryptPasswordEncoder;
		this.userMapper = userMapper;
	}
	
	// 회원 가입
	public void addUser(UserDto userDto) {
		if(userMapper.selectByUsername(userDto.getUsername()) != null) {
			System.out.println(userDto.getUsername() + " 사용자 이름이 존재합니다.");
			// throw new RuntimeException("사용자 이름이 존재합니다.");
			return;
		}
		
		// dto -> domain
		UserDomain userDomain = new UserDomain();
		userDomain.setUsername(userDto.getUsername());
		userDomain.setRole("ROLE_USER"); // ROLE_ADMIN, ROLE_USER
		userDomain.setPassword(bCryptPasswordEncoder.encode(userDto.getPassword()));
		userMapper.insert(userDomain);
	}
	
	// 회원 수정
	public int editUser(String currentPassword, String newPassword) {
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		UserDomain userDomain = userMapper.selectByUsername(username);
		
		if(!bCryptPasswordEncoder.matches(currentPassword, userDomain.getPassword())) {
			System.out.println("현재 비밀번호가 일치하지 않습니다.");
			return 0;
		}
		
		String encodedNewPassword = bCryptPasswordEncoder.encode(newPassword);
		userDomain.setPassword(encodedNewPassword);
		return userMapper.update(userDomain);
	}
	
	// 회원 탈퇴
	public void deleteUser(String username) {
		userMapper.deleteByUsername(username);
	}
}
