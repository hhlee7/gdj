package com.example.hashtag.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.hashtag.service.MyService;

@Controller
public class MyController {
	private MyService myService;
	public MyController(MyService myService) {
		this.myService = myService;
	}
	
	@GetMapping("/")
	public String boardList(Model model) {
		model.addAttribute("boardList", myService.getBoardListAndTags());
		return "boardList";
	}
	
	@GetMapping("/addTag")
	public String addTag(Model model, @RequestParam int boardNo) {
		String tags = myService.getTagsByBoard(boardNo);
		model.addAttribute("tags", tags);
		model.addAttribute("boardNo", boardNo);
		return "addTag";
	}
	
	@PostMapping("/addTagAction")
	public String addTagAction(@RequestParam int boardNo, @RequestParam String tags) {
		myService.addTags(boardNo, tags);
		return "redirect:/";
	}
}
