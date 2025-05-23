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

import com.example.mbboard.dto.ConnectCount;
import com.example.mbboard.dto.Member;
import com.example.mbboard.service.IRootService;
import com.example.mbboard.service.IloginService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {
	@Autowired IloginService loginService;
	@Autowired IRootService rootService;

	@GetMapping("/findMemberPw")
	public String findMemberPw() {
		return "findMemberPw";
	}
	
	@PostMapping("/findMemberPw")
	public String findMemberPw(Member member) {
		// 비밀번호를 변경
		loginService.ChangeMemberPwByAdmin(member);
		// 분실 비밀번호 변경 페이지로 redirect
		return "rechangeMemberPw";
	}
	
	@GetMapping("/rechangeMemberPw")
	public String rechangeMemberPw() {
		return "rechangeMemberPw";
	}
	
	@PostMapping("/rechangeMemberPw")
	public String rechangeMemberPw(Member member) {
		loginService.rechangeMemberPw(member);
		return "redirect:/login";
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
	public String login(HttpSession session, Member paramMember, HttpServletResponse response) {
		Member loginMember = loginService.login(paramMember);
		if(loginMember != null) {
			
			log.info(paramMember.toString());
			
			// 클라이언트 쿠키에도 로그인에 성공한 ID만 저장
			
			if(paramMember.getSaveIdCk() != null) {
				Cookie c = new Cookie("saveId", paramMember.getMemberId());
				response.addCookie(c);
			} else {
				Cookie c = new Cookie("saveId", "");
				response.addCookie(c);
			}
			
			// 로그인 성공 시 세션에 정보 저장
			session.setAttribute("loginMember", loginMember);
			// 멤버(ADMIN, MEMBER) count + 1
			ConnectCount cc = new ConnectCount();
			cc.setMemberRole(loginMember.getMemberRole());
			if(rootService.getConnectDateByKey(cc) == null) {
				rootService.addConnectCount(cc); // 오늘 날짜 loginMember.getMemberRole()로 1행을 추가, 카운트 = 1
			} else {
				rootService.modifyConnectCount(cc); // 오늘 날짜 loginMember.getMemberRole()을 수정, 카운트 + 1
			}
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
