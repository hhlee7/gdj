<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%@page import="java.net.URLEncoder"%>
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
		String msg = URLEncoder.encode("아이디 또는 비밀번호가 잘못 되었습니다. 아이디와 비밀번호를 정확히 입력해 주세요.", "UTF-8");
		response.sendRedirect("/cashbook/loginForm.jsp?msg=" + msg);
	}
	
%>