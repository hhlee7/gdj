package com.example.mbboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.mbboard.dto.Board;
import com.example.mbboard.dto.Page;
import com.example.mbboard.mapper.BoardMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class BoardService implements IBoardService {
	@Autowired BoardMapper boardMapper; // 인터페이스 형태로 의존성 주입 -> 디커플링
	
	@Override
	public List<Board> selectBoardListByPage(Page page) {
		return boardMapper.selectBoardListByPage(page);
	}
	
	@Override
	public int countBoard(String searchWord) {
		return boardMapper.countBoard(searchWord);
	}
	
	@Override
	public Board selectBoardOne(int boardNo) {
		return boardMapper.selectBoardOne(boardNo);
	}
	
	@Override
	public int insertBoard(Board board) {
		return boardMapper.insertBoard(board);
	}
	
	@Override
	public int updateBoard(Board board) {
		return boardMapper.updateBoard(board);
	}
	
	@Override
	public int deleteBoardByKey(int boardNo) {
		return boardMapper.deleteBoardByKey(boardNo);
	}
}