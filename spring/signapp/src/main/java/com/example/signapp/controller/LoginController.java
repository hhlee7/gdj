package com.example.signapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.signapp.dto.Member;
import com.example.signapp.service.LoginService;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {
	@Autowired LoginService loginService;
	
	@GetMapping({"/", "/login"})
	public String login() {
		return "login";
	}
	
	@PostMapping("/login")
	public String login(Member member, Model model, HttpSession session) {
		Member result = loginService.login(member);
		if(result != null) {
			// 로그인 성공 시
			session.setAttribute("userId", result.getId());
			return "documentList";
		} else {
			// 로그인 실패 시
			return "login";
		}
		
	}
}
