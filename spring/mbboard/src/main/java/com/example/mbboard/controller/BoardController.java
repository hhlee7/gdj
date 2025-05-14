package com.example.mbboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.mbboard.dto.Page;
import com.example.mbboard.mapper.BoardMapper;
import com.example.mbboard.service.IBoardService;

@Controller
public class BoardController {
	@Autowired IBoardService boardService; // 인터페이스 형태로 의존성 주입 -> 디커플
	@Autowired BoardMapper boardMapper;

	@GetMapping({"/", "/boardList"})
	public String boardList(Model model) {
		// model.addAttribute("boardList", boardMapper.selectBoardListByPage());
		return "boardList";
	}
}
