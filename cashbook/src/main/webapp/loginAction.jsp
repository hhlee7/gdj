<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%
	String adminId = request.getParameter("adminId");
	String adminPw = request.getParameter("adminPw");
	// 전달된 파라미터 값 확인용 출력
	System.out.println("loginAction.jsp adminId " + adminId);
	System.out.println("loginAction.jsp adminPw " + adminPw);
	
	// Admin 모델(dao) 호출
	AdminDao adminDao = new AdminDao();
	
	// 로그인 메서드 호출
	int result = adminDao.loginCheck(adminId, adminPw);
	
	if(result == 1) {
		// 로그인 성공
		// 현재 세션 영역에 loginAdmin 변수 생성
		session.setAttribute("loginAdmin", adminId);
		response.sendRedirect("/cashbook/index.jsp");
	} else {
		// 로그인 실패
		response.sendRedirect("/cashbook/loginForm.jsp?msg=loginFailed");
	}
	
%>