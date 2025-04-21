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

import com.example.jpaboard.dto.BoardForm;
import com.example.jpaboard.entity.Board;
import com.example.jpaboard.repository.BoardRepository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardController {
	@Autowired
	private BoardRepository boardRepository;
	
	@GetMapping("/board/addBoard")
	public String addBoardForm() {
		return "board/addBoard";
	}
	
	@PostMapping("/board/create")
	public String createBoard(BoardForm boardForm) {
		Board entity =  boardForm.toEntity();
		boardRepository.save(entity);
		return "redirect:/board/boardList";
	}
	
	@GetMapping("/board/boardList")
	public String boardList(Model model
							, @RequestParam(value = "currentPage", defaultValue = "0") int currentPage
							, @RequestParam(value = "rowPerPage", defaultValue = "10") int rowPerPage
							, @RequestParam(value = "word", defaultValue = "") String word) {
		
		Sort sort = Sort.by("boardNo").descending();
		
		PageRequest pageable = PageRequest.of(currentPage, rowPerPage, sort);
		
		Page<Board> list = boardRepository.findByboardTitleContaining(pageable, word);
		
		// Page의 추가 속성들 로그 확인
		log.debug("list.getTotalElements(): " + list.getTotalElements()); // 전체 행의 수
		log.debug("list.getTotalPages(): " + list.getTotalPages()); // 전체 페이지 사이즈 lastPage
		log.debug("list.getNumber(): " + list.getNumber()); // 현재 페이지
		log.debug("list.getSize(): " + list.getSize()); // rowPerPage
		log.debug("list.isFirst()): " + list.isFirst()); // 현재 페이지가 1페이지인지 : 이전 링크 유무 확인을 위해
		log.debug("list.hasNext()): " + list.hasNext()); // 다음 페이지가 있는지 : 다음 링크 유무 확인을 위해
		
		model.addAttribute("list", list);
		model.addAttribute("prePage", list.getNumber() - 1);
		model.addAttribute("nextPage", list.getNumber() + 1);
		model.addAttribute("word", word);
		
		return "board/boardList";
	}
	
	@GetMapping("/board/boardOne")
	public String boardOne(Model model, @RequestParam int boardNo) {
		Board board = boardRepository.findById(boardNo).orElse(null);
		model.addAttribute("board", board);
		return "board/boardOne";
	}
	
	@GetMapping("/board/modifyBoard")
	public String modifyBoard(Model model, @RequestParam int boardNo) {
		Board board = boardRepository.findById(boardNo).orElse(null);
		model.addAttribute("board", board);
		return "board/modifyBoard";
	}
	
	@PostMapping("/board/update")
	public String update(BoardForm boardForm) {
		Board board = boardForm.toEntity();
		boardRepository.save(board);
		return "redirect:/board/boardOne?boardNo=" + board.getBoardNo();
	}
	
	@GetMapping("/board/delete")
	public String delete(@RequestParam int boardNo, RedirectAttributes rda) {
		Board board = boardRepository.findById(boardNo).orElse(null);
		
		if(board == null) {
			rda.addFlashAttribute("msg", "삭제실패");
			return "redirect:/board/boardOne?boardNo=" + boardNo;
		}
		
		boardRepository.delete(board);
		rda.addFlashAttribute("msg", "삭제성공");
		return "redirect:/board/boardList";
	}
	
}
