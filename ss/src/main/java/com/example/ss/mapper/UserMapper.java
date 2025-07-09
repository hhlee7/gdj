package com.example.ss.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.ss.domain.UserDomain;

@Mapper
public interface UserMapper {
	// 회원 조회(회원 가입, 로그인)
	UserDomain selectByUsername(String username);
	
	// 회원 가입
	int insert(UserDomain userDomain);
	
	// 회원 수정
	int update(UserDomain userDomain);
	
	// 회원 탈퇴
	void deleteByUsername(String username);
}
