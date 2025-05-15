package com.example.mbboard.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.mbboard.dto.Member;
import com.example.mbboard.service.IloginService;
import com.example.mbboard.service.LoginService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {

    private final LoginService loginService_1;
	@Autowired IloginService loginService;

    LoginController(LoginService loginService_1) {
        this.loginService_1 = loginService_1;
    }
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
	
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	@PostMapping("/login")
	public String login(HttpSession session, Member paramMember) {
		Member loginMember = loginService.login(paramMember);
		if(loginMember != null) {
			// 로그인 성공 시 세션에 정보 저장
			session.setAttribute("loginMember", loginMember);
		}
		// 로그인 실패 시 다시 로그인 페이지로
		return "login";
	}
	
	@GetMapping("/joinMember")
	public String joinMember() {
		return "joinMember";
	}
	
	@GetMapping("/isId/{memberId}")
	@ResponseBody
	public boolean isId(@PathVariable String memberId) {
		return loginService.isIdExist(memberId);
	}
	
	@PostMapping("/joinMember")
	public String joinMember(Member member) {
		loginService.insertMember(member);
		return "redirect:/login";
	}
	
	@GetMapping("/member/memberHome")
	public String memberHome() {
		return "/member/memberHome";
	}
	
	// 세션안의 상세정보를 보여주는 요청 -> 로그인 상태에서 요청가능 -> 필터1)
	@GetMapping("/member/info") 
	public String info() {
		return "/member/info";
	}
	// 관리자 페이지 요청 -> 로그인 상태이고 role이 'ADMIN'요청가능 -> 필터2)
	@GetMapping("/admin/adminHome") 
	public String adminHome() {
		return "/admin/adminHome";
	}
	
	@GetMapping("/admin/memberList")
	public String memberList(Model model) {	
		List<Member> memberList = loginService.selectMemberList();
		model.addAttribute("memberList", memberList);
		return "/admin/memberList";
	}
	
	@PostMapping("/admin/changeRole")
	@ResponseBody
	public String changeRole(@RequestParam String memberId
							,@RequestParam String newRole) {
		loginService.updateMemberRole(memberId, newRole);
		return "success";
	}
}
