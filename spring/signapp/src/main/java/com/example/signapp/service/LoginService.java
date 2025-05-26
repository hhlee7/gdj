package com.example.signapp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.signapp.dto.Member;
import com.example.signapp.mapper.LoginMapper;

@Service
public class LoginService {
	@Autowired LoginMapper loginMapper;
	
	public Member login(Member member) {
		Member result = loginMapper.selectMemberByIdAndPw(member);
		return result;
	}
}
