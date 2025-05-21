package com.example.login_history.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.login_history.dto.LoginHistory;
import com.example.login_history.dto.Member;
import com.example.login_history.service.IloginService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {
	@Autowired IloginService loginService;
	
	@GetMapping({"/", "/login"})
	public String login() {
		return "login";
	}
	
	@PostMapping("/login")
	public String login(Member member, Model model, HttpSession session) {
		Member result = loginService.login(member);
		if(result != null) {
			// 휴면 계정 로그인 시
			log.info("result.getActive() : " + result.getActive());
			if("OFF".equals(result.getActive())) {
				return "dormantPage";
			}
			
			// 로그인 성공 시
			// 세션에 사용자 ID 저장
			session.setAttribute("userId", result.getId());
			List<LoginHistory> historyList = loginService.getLoginHistory();
			model.addAttribute("historyList", historyList);
			return "loginPage";
		} else {
			return "login";
		}
	}
	
	@GetMapping("/changePw")
	public String changePw() {
		return "changePw";
	}
	
	@PostMapping("/changePw")
	@ResponseBody
	public String changePw(@RequestParam String nowPw
						, @RequestParam String pw1, HttpSession session) {
		String id = (String)session.getAttribute("userId");
		Member member = new Member();
		member.setId(id);
		member.setPw(nowPw);
		Member result = loginService.login(member);
		if(result == null) {
			return "fail";
		}
		
		loginService.changePw(id, nowPw, pw1);
		return "success";
	}
}
