package com.example.login_history.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.login_history.dto.Member;

@Mapper
public interface LoginMapper {
	Member selectMemberByIdAndPw(Member member);

	List<Member> selectDormantMembers();

	int updateMemberActiveStatus(@Param("id") String id,@Param("active") String active);
}
