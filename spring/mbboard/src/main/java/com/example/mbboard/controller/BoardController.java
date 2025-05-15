package com.example.mbboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.mbboard.dto.Board;
import com.example.mbboard.dto.Page;
import com.example.mbboard.mapper.BoardMapper;
import com.example.mbboard.service.BoardService;
import com.example.mbboard.service.IBoardService;

@Controller
public class BoardController {
	@Autowired IBoardService boardService; // 인터페이스 형태로 의존성 주입 -> 디커플
	
	// 게시글 목록 조회
	@GetMapping({"/boardList"})
	public String boardList(Model model, @RequestParam(defaultValue = "1") int currentPage
										, @RequestParam(defaultValue = "") String searchWord) {
		int rowPerPage = 10;
		int totalCount = boardService.countBoard(searchWord);
		Page page = new Page(rowPerPage, currentPage, totalCount, searchWord);
		
		model.addAttribute("boardList", boardService.selectBoardListByPage(page));
		model.addAttribute("page", page);
		return "boardList";
	}
	
	// 게시글 상세 조회
	@GetMapping("/boardOne")
	public String boardOne(Model model, @RequestParam int boardNo) {
		Board board = boardService.selectBoardOne(boardNo);
		model.addAttribute("board", board);
		return "boardOne";
	}
	
	// 게시글 등록 폼
	@GetMapping("/insertBoard")
	public String insertBoardForm() {
		return "insertBoard";
	}
	
	// 게시글 등록 처리
	@PostMapping("/insertBoard")
	public String insertBoard(Board board) {
		boardService.insertBoard(board);
		return "redirect:/boardList";
	}
	
	// 게시글 수정 폼
	@GetMapping("/updateBoard")
	public String updateBoardForm(Model model, @RequestParam int boardNo) {
		Board board = boardService.selectBoardOne(boardNo);
		model.addAttribute("board", board);
		return "updateBoard";
	}
	
	// 게시글 수정 처리
	@PostMapping("updateBoard")
	public String updateBoard(Board board) {
		boardService.updateBoard(board);
		return "redirect:/boardList";
	}
	
	// 게시글 삭제
	@GetMapping("deleteBoard")
	public String deleteBoard(@RequestParam int boardNo) {
		boardService.deleteBoardByKey(boardNo);
		return "redirect:/boardList";
	}
}
