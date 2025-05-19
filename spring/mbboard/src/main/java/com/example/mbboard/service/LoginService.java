package com.example.mbboard.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.mbboard.dto.Member;
import com.example.mbboard.mapper.LoginMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class LoginService implements IloginService {
	@Autowired JavaMailSender javaMailSender;
	@Autowired LoginMapper loginMapper;
	
	@Override
	public void ChangeMemberPwByAdmin(Member member) {
		// 새로운 패스워드를 생성
		String randomPw = UUID.randomUUID().toString().replace("-", "").substring(0, 8);
		member.setMemberPw(randomPw);
		int row = loginMapper.updateMemberPwByAdmin(member);
		if(row == 1) {
			// 메일로 변경된 비밀번호를 보냄
			log.info("변경된 비밀번호 : " + randomPw);
			
			SimpleMailMessage msg = new SimpleMailMessage();
			msg.setFrom("admin@localhost.com");
			msg.setTo(member.getEmail());
			msg.setSubject("변경된 비밀번호입니다.");
			msg.setText("변경된 비밀번호는 " + member.getMemberPw() + " 입니다. 10분안에 로그인하여 수정하셔야 합니다.");
			
			javaMailSender.send(msg);
		}
	}
	
	@Override
	public void rechangeMemberPw(Member member) {
		int row = loginMapper.rechangeMemberPw(member);
		if(row == 1) {
			log.info("비밀번호 변경 성공");
		} else {
			log.info("비밀번호 변경 실패");
		}
	}
	
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