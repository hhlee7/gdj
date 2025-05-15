package com.example.mbboard.service;

import java.util.List;

import com.example.mbboard.dto.Member;

public interface IloginService {
	Member login(Member paramMember);
	
	boolean isIdExist(String memberId);
	
	int insertMember(Member member);
	
	List<Member> selectMemberList();

	void updateMemberRole(String memberId, String newRole);
}
