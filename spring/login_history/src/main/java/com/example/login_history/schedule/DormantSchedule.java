package com.example.login_history.schedule;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.example.login_history.dto.Member;
import com.example.login_history.service.IloginService;

@Component
public class DormantSchedule {
	@Autowired IloginService loginService;
	
	@Scheduled(cron = "59 59 23 25 * *")
	public void changeDormantMember() {
		List<Member> dormantList = loginService.getDormantMembers();
		for(Member m : dormantList) {
			loginService.deactivateMember(m.getId());
			loginService.sendDormantEmail(m);
		}
	}
}
