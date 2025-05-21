package com.example.login_history.service;

import java.util.List;

import com.example.login_history.dto.LoginHistory;
import com.example.login_history.dto.Member;

public interface IloginService {
	Member login(Member member);
	List<LoginHistory> getLoginHistory();
	
	List<Member> getDormantMembers();
	void deactivateMember(String id);
	void sendDormantEmail(Member member);
	void changePw(String id, String nowPw, String pw1);
	void deletePwHistory();
}
