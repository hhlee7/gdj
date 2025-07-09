package com.example.ss.controller;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	@GetMapping("/")
	public String home(Model model) {
		
		String loginUsername = SecurityContextHolder.getContext().getAuthentication().getName();
		model.addAttribute("loginUsername", loginUsername);
		
		return "home";
	}
}
