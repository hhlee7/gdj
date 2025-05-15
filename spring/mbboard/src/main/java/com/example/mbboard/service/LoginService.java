package com.example.mbboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.mbboard.dto.Member;
import com.example.mbboard.mapper.LoginMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class LoginService implements IloginService {
	@Autowired LoginMapper loginMapper;
	
	@Override
	public Member login(Member paramMember) {
		return loginMapper.login(paramMember);
	}

	@Override
	public boolean isIdExist(String memberId) {
		return loginMapper.countMemberId(memberId) > 0;
	}
	
	@Override
	public int insertMember(Member member) {
		return loginMapper.insertMember(member);
	}
	
	@Override
	public List<Member> selectMemberList() {
		return loginMapper.selectMemberList();
	}
	
	@Override
	public void updateMemberRole(String memberId, String newRole) {
		loginMapper.updateMemberRole(memberId, newRole);
	}
}
