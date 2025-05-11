package com.example.mfu.service;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.example.mfu.dto.Board;
import com.example.mfu.dto.BoardForm;
import com.example.mfu.dto.Boardfile;
import com.example.mfu.exception.AddBoardException;
import com.example.mfu.mapper.BoardMapper;
import com.example.mfu.mapper.BoardfileMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class BoardService {
	@Autowired BoardMapper boardMapper;
	@Autowired BoardfileMapper boardfileMapper;
	
	public void addBoard(BoardForm boardForm) {
		// 1) board 추가
		Board board = new Board();
		board.setBoardTitle(boardForm.getBoardTitle()); // board.getBoardNo() => 0
		int addBoardRow = boardMapper.insertBoard(board); // After => board.setBoardNo(key);
		log.info("board.getBoardNo(): " + board.getBoardNo());
		if(addBoardRow != 1) {
			throw new AddBoardException("board 입력 실패");
		}
		
		// 2) boardfile 추가
		if(boardForm.getBoardfile() != null) {
			for(MultipartFile f : boardForm.getBoardfile()) {
				// getBoardfile size 만큼 입력
				Boardfile bf = new Boardfile();
				bf.setBoardNo(board.getBoardNo());
				bf.setFiletype(f.getContentType());
				String filename = UUID.randomUUID().toString().replace("-", "");
				filename += f.getOriginalFilename().substring(f.getOriginalFilename().lastIndexOf(".")); // UUID 문자열 + .확장자
				bf.setFilename(filename);
				int addBoardfileRow = boardfileMapper.insertBoardfile(bf);
				if(addBoardfileRow != 1) {
					throw new AddBoardException("boardfile 입력 실패");
				}
				// 3) 파일 저장
				File emptyFile = new File("c:/project/upload/" + filename);
				// f안에 파일스트림을 emptyFile로 이동
				try {
					f.transferTo(emptyFile);
				} catch (Exception e) {
					throw new AddBoardException("파일 저장 실패"); // try ... catch 강제하는 예외를 강제하지 않는 예외로 변경해서 예외 발생
				}
			}
		}
	}
	
	public List<Board> getBoardList() {
		return boardMapper.selectBoardList();
	}
	
}
