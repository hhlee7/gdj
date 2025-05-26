package com.example.signapp.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.signapp.dto.Member;

@Mapper
public interface LoginMapper {

	Member selectMemberByIdAndPw(Member member);
	
}
