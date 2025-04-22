package com.example.jpaboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.jpaboard.dto.MemberForm;
import com.example.jpaboard.entity.Member;
import com.example.jpaboard.entity.MemberOnlyMemberId;
import com.example.jpaboard.repository.MemberRepository;
import com.example.jpaboard.util.SHA256Util;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	@Autowired
	MemberRepository memberRepository;

	// 회원 가입 + member_id 중복 확인
	@GetMapping("/member/joinMember")
	public String joinMember() {
		return "member/joinMember";
	}
	
	@PostMapping("/member/joinMember")
	public String joinMember(MemberForm memberForm, RedirectAttributes rda) {
		log.debug(memberForm.toString());
		log.debug("isMemberId : " + memberRepository.existsByMemberId(memberForm.getMemberId()));
		
		if(memberRepository.existsByMemberId(memberForm.getMemberId()) == true) {
			rda.addFlashAttribute("msg", memberForm.getMemberId() + " ID가 이미 존재합니다.");
			return "redirect:/member/joinMember";
		}
		// false -> 회원 가입 진행
		// memberForm.getMemberPw()값을 SHA-256 방식으로 암호화
		memberForm.setMemberPw(SHA256Util.encoding(memberForm.getMemberPw()));
		
		Member member = memberForm.toEntity();
		memberRepository.save(member); // entity 저장 -> 최종 커밋 시 -> 테이블에 행이 추가(insert)
		
		return "redirect:/member/login";
	}
	
	// 로그인 폼
	@GetMapping("/member/login")
	public String login() {
		return "member/login";
	}
	
	// 로그인 액션
	@PostMapping("/member/login")
	public String login(HttpSession session, MemberForm memberForm, RedirectAttributes rda) {
		// pw 암호화
		memberForm.setMemberPw(SHA256Util.encoding(memberForm.getMemberPw()));
		// 로그인 확인 메서드
		MemberOnlyMemberId loginMember = memberRepository.findByMemberIdAndMemberPw(memberForm.getMemberId(), memberForm.getMemberPw());
		
		if(loginMember == null) { // 로그인 실패
			rda.addFlashAttribute("msg", "로그인 실패");
			return "redirect:/member/login";
		}
		// 로그인 성공 코드 구현
		log.debug("로그인 성공");
		session.setAttribute("loginMember", loginMember);
		return "redirect:/member/memberList";
	}
	
	// 로그아웃
	@GetMapping("/member/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/member/login";
	}
	
	// 회원 목록
	@GetMapping("/member/memberList")
	public String memberList(HttpSession session, Model model
							, @RequestParam(value = "currentPage", defaultValue = "0") int currentPage
							, @RequestParam(value = "rowPerPage", defaultValue = "10") int rowPerPage
							, @RequestParam(value = "word", defaultValue = "") String word) {
		
		// session 인증/인가 검사
		if(session.getAttribute("loginMember") == null) {
			return "redirect:/member/login";
		}
		
		Sort sort = Sort.by("memberNo").descending();
		
		PageRequest pageable = PageRequest.of(currentPage, rowPerPage, sort);
		
		// 사용자 목록 + 페이징
		Page<MemberOnlyMemberId> list = memberRepository.findByMemberIdContaining(pageable, word);
		
		model.addAttribute("list", list);
		model.addAttribute("prePage", list.getNumber() - 1);
		model.addAttribute("nextPage", list.getNumber() + 1);
		model.addAttribute("word", word);
		
		return "member/memberList";
	}
	
	// 회원 정보 수정
	@GetMapping("/member/modifyMemberPw")
	public String modifyMemberPw(HttpSession session) {
		return "member/modifyMemberPw";
	}
	
	@PostMapping("/member/modifyMemberPw")
	public String modifyMemberPw(HttpSession session, RedirectAttributes rda
								, @RequestParam(value = "beforePw") String beforePw
								, @RequestParam(value = "newPw") String newPw
								, @RequestParam(value = "confirmPw") String confirmPw) {
		
		// 세션에서 로그인 사용자 정보 가져오기
		MemberOnlyMemberId loginMember = (MemberOnlyMemberId)session.getAttribute("loginMember");
		if(loginMember == null) {
			rda.addFlashAttribute("msg", "로그인 세션이 만료되었습니다.");
			return "redirect:/member/login";
		}
		
		// DB에서 회원의 전체 정보 가져오기
		Member member = memberRepository.findById(loginMember.getMemberNo()).orElse(null);
		
		// 기존 비밀번호와 비교
		if(!member.getMemberPw().equals(SHA256Util.encoding(beforePw))) {
			rda.addFlashAttribute("msg", "기존 비밀번호가 일치하지 않습니다.");
			return "redirect:/member/modifyMemberPw";
		}
		
		if(!newPw.equals(confirmPw)) {
			rda.addFlashAttribute("msg", "확인 비밀번호와 일치하지 않습니다.");
			return "redirect:/member/modifyMemberPw";
		}
		
		// 새로운 비밀번호 암호화 후 update
		member.setMemberPw(SHA256Util.encoding(newPw));
		memberRepository.save(member);
		rda.addFlashAttribute("msg", "비밀번호가 변경되었습니다. 다시 로그인해주세요.");
		session.invalidate();
		return "redirect:/member/login";
	}
	
	// 회원 탈퇴
	@GetMapping("/member/removeMember")
	public String removeMember(HttpSession session, RedirectAttributes rda) {
		MemberOnlyMemberId loginMember = (MemberOnlyMemberId)session.getAttribute("loginMember");
		if(loginMember == null) {
			rda.addFlashAttribute("msg", "로그인 세션이 만료되었습니다.");
			return "redirect:/member/login";
		}
		return "member/removeMember";
	}
	
	@PostMapping("/member/removeMember")
	public String removeMember(HttpSession session, RedirectAttributes rda
								, @RequestParam(value = "memberPw") String memberPw) {
		MemberOnlyMemberId loginMember = (MemberOnlyMemberId)session.getAttribute("loginMember");
		Member member = memberRepository.findById(loginMember.getMemberNo()).orElse(null);
		if(member.getMemberPw().equals(SHA256Util.encoding(memberPw))) {
			memberRepository.delete(member);
		} else {
			rda.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "redirect:/member/removeMember";
		}
		return "redirect:/member/login";
	}
}
