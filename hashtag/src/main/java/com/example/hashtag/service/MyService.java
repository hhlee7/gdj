package com.example.hashtag.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.hashtag.dto.Hashtag;
import com.example.hashtag.mapper.MyMapper;

@Service
@Transactional
public class MyService {
	private MyMapper myMapper;
	public MyService(MyMapper myMapper) {
		this.myMapper = myMapper;
	}
	
	public List<Map<String, Object>> getBoardListAndTags() {
		return myMapper.selectBoardListAndTags();
	}
	
	// {"a","b","c"} -> "a,b,c"
	public String getTagsByBoard(int boardNo) {
		List<String> list = myMapper.selectTagsByBoard(boardNo);
		// Streams를 사용한 함수형 프로그래밍 권고
		
		// 객체 지향 방식은 지양 - 리스트의 크기가 크면, Streams 방식보다 효율이 많이 떨어짐
		String result = String.join(",", list);
		return result;
	}

	public void addTags(int boardNo, String tags) {
		// tags -> 배열 -> newList
		List<String> newList = new ArrayList<String>(Arrays.asList(tags.split(","))); // Arrays 메서드로 만든 배열(정적) / ArrayList는 동적 특징을 가짐
		System.out.println("newList" + newList);
		List<String> oldList = myMapper.selectTagsByBoard(boardNo);
		System.out.println("oldList" + oldList);
		
		// newList와 oldList의 차집합 결과
		newList.removeAll(oldList); // newList - oldList (차집합)
		
		// Set으로 변경 후
		Set<String> set = new HashSet<String>(newList);
		
		// insert
		for(String t : set) { // set은 index(순서)가 없는 데이터라 반복 불가. 이터레이터 패턴으로 반복 필요. forEach 문법은 반복 가능.
			System.out.println("t: " + t);
			Hashtag hashtag = new Hashtag();
			hashtag.setBoardNo(boardNo);
			hashtag.setTag(t);
			myMapper.insertHashtag(hashtag);
		}
	}
}
