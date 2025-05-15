package com.example.mbboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.mbboard.dto.Board;
import com.example.mbboard.dto.Page;

@Mapper // -> 구현 (component 구현 클래스를 자동으로 생성 -> ex) @Component BoardMapper_class -> 객체생성 been 등록
public interface BoardMapper {
	List<Board> selectBoardListByPage(Page page);
	int countBoard(String searchWord);
	Board selectBoardOne(int boardNo);
	
	int insertBoard(Board board);
	int updateBoard(Board board);
	int deleteBoardByKey(int boardNo);
}
