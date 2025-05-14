package com.example.mbboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.mbboard.dto.Board;
import com.example.mbboard.dto.Page;

@Mapper
public interface BoardMapper {
	
	List<Board> selectBoardListByPage(Page p);
	Board selectBoardOne(Board b);
	
	int insertBoard(Board b);
	int updateBoard(Board b);
	int deleteBoardByKey(Board b);
}
