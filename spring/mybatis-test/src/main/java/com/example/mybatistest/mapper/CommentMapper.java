package com.example.mybatistest.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentMapper {
	int deleteByBoardNo(int boardNo); // mybatis는 update, delete, insert 는 자동으로 Integer를 반환
}
