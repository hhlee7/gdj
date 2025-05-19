package com.example.mbboard.controller.cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.mbboard.dto.Member;
import com.example.mbboard.service.IRootService;
import com.example.mbboard.service.IloginService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class CookieLoginController {
	@Autowired IloginService loginService;
	@Autowired IRootService rootService;
	
	@GetMapping("/cookieLogin")
	public String cookieLogin() {
		return "/cookie/cookieLogin";
	}
	
	@GetMapping("/cookieLogout")
	public String logout(HttpServletResponse response) {
		Cookie loginMemberId = new Cookie("loginMemberId", null);
		response.addCookie(loginMemberId);
		return "/cookie/cookieLogin";
	}
	
	@PostMapping("/cookieLogin")
	public String login(HttpSession session, Member paramMember, HttpServletResponse response) {
		Member loginMember = loginService.login(paramMember);
		if(loginMember != null) {
				Cookie loginMemberId = new Cookie("loginMemberId", paramMember.getMemberId());
				response.addCookie(loginMemberId);
				return "redirect:/cookieSuccess";
			}
			return "redirect:/cookieLogin";
		}
	
	@GetMapping("/cookieSuccess")
	public String cookieSuccess(@CookieValue(value = "loginMemberId", required = false) String loginMemberId) {
		// 로그인 전이라면 redirect:/cookieLogin
		if(loginMemberId == null || loginMemberId.equals("")) {
			return "redirect:/cookieLogin";
		}
		// 로그인 되어 있다면
		return "cookie/cookieSuccess";
	}
}
