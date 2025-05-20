package com.example.login_history.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.login_history.dto.LoginHistory;

@Mapper
public interface LoginHistoryMapper {
	void insertLoginHistory(LoginHistory loginHistory);
	List<LoginHistory> selectLoginHistoryById(String id);
}
