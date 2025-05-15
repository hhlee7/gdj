package com.example.mbboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.mbboard.dto.Member;

@Mapper
public interface LoginMapper {
	Member login(Member paramMember);
	
	// ID 중복 검사
	int countMemberId(String memberId);
	
	// 회원 가입
	int insertMember(Member member);

	List<Member> selectMemberList();

	void updateMemberRole(@Param("memberId") String memberId,@Param("newRole") String newRole);
}
