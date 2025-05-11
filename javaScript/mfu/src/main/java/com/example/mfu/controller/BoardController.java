package com.example.mfu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.mfu.dto.Board;
import com.example.mfu.dto.BoardForm;
import com.example.mfu.dto.Boardfile;
import com.example.mfu.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardController {
	@Autowired BoardService boardService;
	
	@GetMapping({"/", "/addBoard"})
	public String addBoard() {
		return "addBoard";
	}
	
	@PostMapping({"/addBoard"})
	public String addBoard(BoardForm boardForm) {
		log.info(boardForm.toString());
		// log.info("boardfile size: " + boardForm.getBoardfile().size());
		boardService.addBoard(boardForm);
		return "redirect:/boardList";
	}
	
	@GetMapping("/boardList")
	public String boardList(Model model) {
		List<Board> list = boardService.getBoardList();
		model.addAttribute("list", list);
		return "boardList";
	}
	
	@GetMapping("/boardOne")
	public String boardOne(@RequestParam("boardNo") int boardNo, Model model) {
		Board board = boardService.getBoardOne(boardNo);
		List<Boardfile> fileList = boardService.getBoardfileList(boardNo);
		model.addAttribute("board", board);
		model.addAttribute("fileList", fileList);
		return "boardOne";
	}
	
	@GetMapping("/modifyBoard")
	public String modifyBoard(@RequestParam("boardNo") int boardNo, Model model) {
		Board board = boardService.getBoardOne(boardNo);
		model.addAttribute("board", board);
		return "modifyBoard";
	}
	
	@PostMapping("/modifyBoard")
	public String modifyBoard(Board board) {
		boardService.modifyBoard(board);
		return "redirect:/boardOne?boardNo=" + board.getBoardNo();
	}
	
	@GetMapping("/removeBoard")
	public String removeBoard(@RequestParam("boardNo") int boardNo) {
		boardService.removeBoard(boardNo);
		return "redirect:/boardList";
	}
	
	
}
