package com.example.ajax.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.ajax.dto.MemberDto;

@Mapper
public interface MemberMapper {
	// ID 중복 검사
	String selectMemberId(String id);
	// 회원가입
	int insertMember(MemberDto memberDto);
}
