package com.example.jpaboard.repository;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.example.jpaboard.entity.Member;
import com.example.jpaboard.entity.MemberOnlyMemberId;

public interface MemberRepository extends JpaRepository<Member, Integer>{
	// member_id 중복 검사
	boolean existsByMemberId(String memberId);
	
	// 로그인 하는 추상 메서드 : findBy엔티티컬럼필드 ... And엔티티컬럼필드
	MemberOnlyMemberId findByMemberIdAndMemberPw(String memberId, String memberPw);
	
	// 멤버 목록
	Page<MemberOnlyMemberId> findByMemberIdContaining(Pageable pageable, String word); // pw 노출 X
}