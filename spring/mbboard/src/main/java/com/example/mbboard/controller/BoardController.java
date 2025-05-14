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

    private final BoardService boardService_1;
	@Autowired IBoardService boardService; // 인터페이스 형태로 의존성 주입 -> 디커플
	@Autowired BoardMapper boardMapper;

    BoardController(BoardService boardService_1) {
        this.boardService_1 = boardService_1;
    }

	@GetMapping({"/", "/boardList"})
	public String boardList(Model model, @RequestParam(defaultValue = "1") int currentPage
										, @RequestParam(defaultValue = "") String searchWord) {
		int rowPerPage = 10;
		int totalCount = boardMapper.countBoard(searchWord);
		Page page = new Page(rowPerPage, currentPage, totalCount, searchWord);
		
		model.addAttribute("boardList", boardMapper.selectBoardListByPage(page));
		model.addAttribute("page", page);
		return "boardList";
	}
	
	@GetMapping("/boardOne")
	public String boardOne(Model model, @RequestParam int boardNo) {
		Board board = boardMapper.selectBoardOne(boardNo);
		model.addAttribute("board", board);
		return "boardOne";
	}
	
	@GetMapping("/insertBoard")
	public String insertBoardForm() {
		return "insertBoard";
	}
	
	@PostMapping("/insertBoard")
	public String insertBoard(Board board) {
		boardMapper.insertBoard(board);
		return "redirect:/boardList";
	}
	
	@GetMapping("/updateBoard")
	public String updateBoardForm(Model model, @RequestParam int boardNo) {
		Board board = boardMapper.selectBoardOne(boardNo);
		model.addAttribute("board", board);
		return "updateBoard";
	}
	
	@PostMapping("updateBoard")
	public String updateBoard(Board board) {
		boardMapper.updateBoard(board);
		return "redirect:/boardList";
	}
	
	@GetMapping("deleteBoard")
	public String deleteBoard(@RequestParam int boardNo) {
		boardMapper.deleteBoardByKey(boardNo);
		return "redirect:/boardList";
	}
}
