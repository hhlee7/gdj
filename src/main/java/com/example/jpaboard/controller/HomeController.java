package com.example.jpaboard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	@GetMapping("/home")
	public String home(Model model) {
		model.addAttribute("loginName", "구디");
		// System.out.println(model.getAttribute("loginName"));
		// log 프레임워크를 사용
		log.trace("loginName: " + model.getAttribute("loginName")); // 로그 레벨 debug 설정 시 미출력
		log.debug("loginName: " + model.getAttribute("loginName")); // 출력됨
		log.info("loginName: " + model.getAttribute("loginName")); // 출력됨
		return "home";
	}
}
