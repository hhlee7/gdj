package com.example.login_history.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.login_history.dto.LoginHistory;
import com.example.login_history.dto.Member;
import com.example.login_history.service.IloginService;

@Controller
public class LoginController {
	@Autowired IloginService loginService;
	
	@GetMapping({"/", "/login"})
	public String login() {
		return "login";
	}
	
	@PostMapping("/login")
	public String login(Member member, Model model) {
		Member result = loginService.login(member);
		if(result != null) {
			// 휴면 계정 로그인 시
			if("OFF".equals(result.getActive())) {
				return "dormantPage";
			}
			
			// 로그인 성공 시
			List<LoginHistory> historyList = loginService.getLoginHistoryById(result.getId());
			model.addAttribute("historyList", historyList);
			return "loginPage";
		} else {
			return "login";
		}
	}
}
