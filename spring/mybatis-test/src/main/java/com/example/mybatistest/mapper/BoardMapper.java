package com.example.mybatistest.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.mybatistest.dto.Board;

@Mapper
public interface BoardMapper {
	public List<Board> selectAll();
	int deleteByBoardNo(int boardNo);
}
