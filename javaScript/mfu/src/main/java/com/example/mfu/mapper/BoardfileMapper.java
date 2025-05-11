package com.example.mfu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.mfu.dto.Boardfile;

@Mapper
public interface BoardfileMapper {
	Integer insertBoardfile(Boardfile boardfile);
	List<Boardfile> selectBoardfileList(int boardNo);
}
