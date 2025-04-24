package com.example.fileupload.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.fileupload.dto.BoardForm;
import com.example.fileupload.entity.Board;
import com.example.fileupload.entity.BoardMapping;
import com.example.fileupload.entity.Boardfile;
import com.example.fileupload.repository.BoardRepository;
import com.example.fileupload.repository.BoardfileRepository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardController {
	@Autowired BoardRepository boardRepository;
	@Autowired BoardfileRepository boardfileRepository;
	
	@GetMapping("/boardOne")
	public String boardOne(Model model, @RequestParam(value = "bno") int bno) {
		BoardMapping boardMapping = boardRepository.findByBno(bno);
		
		List<Boardfile> fileList = boardfileRepository.findByBno(bno);
		log.debug("size: " + fileList.size());
		
		model.addAttribute("boardMapping", boardMapping);
		model.addAttribute("fileList", fileList);
		return "boardOne";
	}
	
	@GetMapping({"/", "/boardList"})
	public String boardList(Model model, @RequestParam(value = "currentPage", defaultValue = "0") int currentPage
										, @RequestParam(value = "rowPerPage", defaultValue = "10") int rowPerPage) {
		
		Sort sort = Sort.by("bno").descending();
		
		PageRequest pageable = PageRequest.of(currentPage, rowPerPage, sort);

		Page<BoardMapping> list = boardRepository.findAllBy(pageable);
		model.addAttribute("list", list);
		model.addAttribute("prePage", list.getNumber() - 1);
		model.addAttribute("nextPage", list.getNumber() + 1);
		return "boardList";
	}
	
	// 입력폼
	@GetMapping("/addBoard")
	public String addBoard() {
		return "addBoard";
	}
	
	// 입력액션
	@PostMapping("/addBoard")
	public String addBoard(BoardForm boardForm, RedirectAttributes rda) {
		log.debug(boardForm.toString());
		// ISSUE : 파일을 첨부하지 않아도 fileSize는 1이다.
		log.debug("MultipartFile Size: " + boardForm.getFileList().size());
		
		Board board = new Board();
		board.setTitle(boardForm.getTitle());
		board.setPw(boardForm.getPw());
		boardRepository.save(board); // board 저장
		int bno = board.getBno(); // board insert 후 bno 변경되었는지 확인
		log.debug("bno: " + bno);
		
		// 파일 분리
		List<MultipartFile> fileList = boardForm.getFileList();
		long firstFileSize = fileList.get(0).getSize();
		log.debug("firstFileSize: "  + firstFileSize);
		
		// ISSUE : 파일을 첨부하지 않아도 fileSize는 1이다.
		if(firstFileSize > 0) { // 첫 번째 파일 사이즈가 0 이상이다 -> 첨부된 파일이 있다.
			// 업로드 파일 유효성 검증 코드 구현
			for(MultipartFile f : fileList) {							// 1Kbyte = 1024byte, 1Mbyte = 1024Kbyte
				if(f.getContentType().equals("application/octet-stream") || f.getSize() > 10 * 1024 * 1024) {
					log.debug("실행 파일 또는 10MB 이상의 파일 첨부 불가");
					rda.addFlashAttribute("msg", "실행 파일 또는 10MB 이상의 파일은 첨부할 수 없습니다.");
					return "redirect:/addBoard";
				}
			}
			
			// 파일 업로드 진행 코드
			for(MultipartFile f : fileList) {
				log.debug("파일 타입: " + f.getContentType());
				log.debug("파일 이름: " + f.getName());
				log.debug("원본 이름: " + f.getOriginalFilename());
				log.debug("파일 크기: " + f.getSize());
				// 확장자만 추출
				String ext = f.getOriginalFilename().substring(f.getOriginalFilename().lastIndexOf(".") + 1);
				log.debug("확장자: " + ext);
				String fname = UUID.randomUUID().toString().replace("-", "");
				log.debug("저장 파일 이름: " + fname);
				
				File emptyFile = new File("c:/project/upload/" + fname + "." + ext);
				// f의 byte -> emptyFile 복사
				try {
					f.transferTo(emptyFile);
				} catch (Exception e) {
					log.error("파일 저장 실패");
					e.printStackTrace();
				}
				
				// boardfile 테이블에도 파일 정보 저장
				Boardfile boardfile = new Boardfile();
				boardfile.setBno(board.getBno());
				boardfile.setFext(ext);
				boardfile.setFname(fname);
				boardfile.setForiginname(f.getOriginalFilename());
				boardfile.setFsize(f.getSize());
				boardfile.setFtype(f.getContentType());
				boardfileRepository.save(boardfile);
			}
		}
		return "redirect:/";
	}
	
	// Board 수정
	@GetMapping("/modifyBoard")
	public String modifyBoard(Model model, @RequestParam int bno) {
		Board board = boardRepository.findById(bno).orElse(null);
		model.addAttribute("board", board);
		return "modifyBoard";
	}
	
	@PostMapping("/update")
	public String modifyBoard(BoardForm boardForm, RedirectAttributes rda) {
		Board board = boardRepository.findById(boardForm.getBno()).orElse(null);
		
		// 비밀번호 일치 여부 확인
		if(!board.getPw().equals(boardForm.getPw())) {
			rda.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "redirect:/modifyBoard?bno=" + boardForm.getBno();
		}
		
		board.setTitle(boardForm.getTitle());
		boardRepository.save(board);
		return "redirect:/boardOne?bno=" + board.getBno();
	}
	
	@GetMapping("/removeBoard")
	public String removeBoard(Model model, @RequestParam int bno, RedirectAttributes rda) {
		Board board = boardRepository.findById(bno).orElse(null);
		model.addAttribute("board", board);
		return "removeBoard";
	}
	
	// Board 삭제
	@PostMapping("/delete")
	public String removeBoard(BoardForm boardForm, RedirectAttributes rda) {
		Board board = boardRepository.findById(boardForm.getBno()).orElse(null);
		
		// 비밀번호 일치 여부 확인
		if(!board.getPw().equals(boardForm.getPw())) {
			rda.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "redirect:/removeBoard?bno=" + boardForm.getBno();
		}
		
		// 첨부 파일 존재 여부 확인
		List<Boardfile> files = boardfileRepository.findByBno(boardForm.getBno());
		if(files != null && !files.isEmpty()) {
			rda.addFlashAttribute("msg", "첨부 파일이 있어 게시글을 삭제할 수 없습니다.");
			return "redirect:/removeBoard?bno=" + boardForm.getBno();
		}
		
		boardRepository.delete(board);
		return "redirect:/boardList";
	}
}
