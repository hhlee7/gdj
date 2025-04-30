<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 현재 세션을 초기화
	session.invalidate();
	// 로그아웃 후 로그인 페이지로 이동
	response.sendRedirect("/cashbook/loginForm.jsp");
%>
