package com.example.mbboard.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.mbboard.dto.Member;

@Mapper
public interface LoginMapper {
	Member login(Member paramMember);
	
	// ID 중복 검사
	String selectMemberId(String memberId);
	
	// 회원 가입
	int insertMember(Member member);
}
