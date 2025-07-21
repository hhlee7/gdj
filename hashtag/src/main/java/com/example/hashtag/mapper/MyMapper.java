package com.example.hashtag.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.hashtag.dto.Hashtag;

@Mapper
public interface MyMapper { // BoardMapper + HashtagMapper
	// 전체 게시글과 해시태그 같이 조회
	List<Map<String, Object>> selectBoardListAndTags(); // 조인
	
	// 해당 게시글에 등록된 해시태그 조회
	List<String> selectTagsByBoard(int boardNo);
	
	// 해당 게시글의 해시태그 추가
	void insertHashtag(Hashtag hashtag);
}
