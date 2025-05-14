package com.example.ajax.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.ajax.dto.MemberDto;
import com.example.ajax.mapper.MemberMapper;

@Controller
public class MemberController {
	@Autowired MemberMapper memberMapper;
	
	@GetMapping("/joinMember")
	public String joinMember() {
		return "joinMember";
	}
	
	@PostMapping("/joinMember")
	public String joinMember(MemberDto memberDto) {
		memberMapper.insertMember(memberDto);
		return "redirect:/joinMember";
	}
}
