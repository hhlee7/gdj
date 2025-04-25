package com.example.mybatistest.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.mybatistest.dto.Board;
import com.example.mybatistest.mapper.BoardMapper;
import com.example.mybatistest.mapper.CommentMapper;

@Service
@Transactional
public class BoardService implements IBoardService {
	@Autowired BoardMapper boardMapper;
	@Autowired CommentMapper commentMapper;
	
	public List<Board> getAll() {
		// getAll()은 중계 역할
		return boardMapper.selectAll();
	}
	
	public void remove(int boardNo) {
		commentMapper.deleteByBoardNo(boardNo); // 실패하면? -> 예외 발생 - Transactional 어노테이션에 의해 현재 메서드 실행이 rollback
		boardMapper.deleteByBoardNo(boardNo); // 실패하면? -> 예외 발생 - Transactional 어노테이션에 의해 현재 메서드 실행이 rollback
	}
}
