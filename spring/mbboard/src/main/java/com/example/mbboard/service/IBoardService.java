package com.example.mbboard.service;

import java.util.List;

import com.example.mbboard.dto.Board;
import com.example.mbboard.dto.Page;

public interface IBoardService {
	// 게시글 목록 조회 + 페이징 처리
	List<Board> selectBoardListByPage(Page page);
	
	// 게시글 개수(검색어 포함)
	int countBoard(String searchWord);
	
	// 게시글 상세 조회
	Board selectBoardOne(int boardNo);
	
	// 게시글 등록
	int insertBoard(Board board);
	
	// 게시글 수정
	int updateBoard(Board board);
	
	// 게시글 삭제
	int deleteBoardByKey(int boardNo);
}
