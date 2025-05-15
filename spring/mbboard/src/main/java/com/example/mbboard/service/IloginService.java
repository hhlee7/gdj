package com.example.mbboard.service;

import com.example.mbboard.dto.Member;

public interface IloginService {
	Member login(Member paramMember);
	
	boolean isIdExist(String memberId);
	
	int insertMember(Member member);
}
