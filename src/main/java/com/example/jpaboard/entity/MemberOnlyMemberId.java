package com.example.jpaboard.entity;

// Member Entity의 맵핑 타입 : getter를 통해서 맵핑
public interface MemberOnlyMemberId {
	int getMemberNo();
	String getMemberId();
	String getMemberRole();
}
