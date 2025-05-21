package com.example.login_history.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.example.login_history.dto.LoginHistory;
import com.example.login_history.dto.Member;
import com.example.login_history.mapper.LoginHistoryMapper;
import com.example.login_history.mapper.LoginMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LoginService implements IloginService {
	@Autowired LoginMapper loginMapper;
	@Autowired LoginHistoryMapper loginHistoryMapper;
	@Autowired JavaMailSender mailSender;
	
	@Override
	public Member login(Member member) {
		Member result = loginMapper.selectMemberByIdAndPw(member);
		if(result != null) {
			LoginHistory history = new LoginHistory();
			history.setId(result.getId());
			loginHistoryMapper.insertLoginHistory(history);
		}
		return result;
	}

	@Override
	public List<LoginHistory> getLoginHistory() {
		return loginHistoryMapper.selectLoginHistory();
	}

	@Override
	public List<Member> getDormantMembers() {
		return loginMapper.selectDormantMembers();
	}

	@Override
	public void deactivateMember(String id) {
		loginMapper.updateMemberActiveStatus(id, "OFF");
	}

	@Override
	public void sendDormantEmail(Member member) {
		SimpleMailMessage msg = new SimpleMailMessage();
		msg.setTo(member.getEmail());
		msg.setSubject("휴면 계정 전환 안내");
		msg.setText(member.getId() + "님, 1년 이상 로그인 기록이 없어 계정이 휴면 처리되었습니다.");
		mailSender.send(msg);
	}

	@Override
	public String changePw(String id, String nowPw, String pw1) {
		String currentPw = loginMapper.getPwById(id);
		
		if(!nowPw.equals(currentPw)) {
			log.info("비밀번호 불일치");
			return "incorrectNowPw";
		}
		
		// 기존 비밀번호 이력 확인
		List<String> pwHistoryList = loginMapper.getPwHistory(id);
		if(pwHistoryList.contains(pw1)) {
			log.info("기존에 사용된 비밀번호");
			return "reusedPw";
		}
		
		loginMapper.updatePw(id, pw1);
		loginMapper.insertPwHistory(id, pw1);
		return "success";
	}

	@Override
	public void deletePwHistory() {
		loginMapper.deletePwHistory();
	}
}
