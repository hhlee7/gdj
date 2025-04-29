package com.example.jpaboard.entity;

// Member Entity의 맵핑 타입 : getter를 통해서 맵핑
public interface MemberOnlyMemberId {
	int getMemberNo();
	String getMemberId();
	String getMemberRole();
	
	// 구현 메서드로 만들어 사용
	default String getRoleOnly() {
		return getMemberRole().split("_")[1]; // ex) "ROLE_USER" -> "USER"
	}
}