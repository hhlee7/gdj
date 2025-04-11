<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%@page import="java.net.URLEncoder"%>
<%
	String adminId = request.getParameter("adminId");
	String beforePw = request.getParameter("beforePw");
	String newPw = request.getParameter("newPw");
	String confirmPw = request.getParameter("confirmPw");
	// 전달된 파라미터 값 확인용 출력
	System.out.println("updateAdminPwAction.jsp adminId: " + adminId);
	System.out.println("updateAdminPwAction.jsp beforePw: " + beforePw);
	System.out.println("updateAdminPwAction.jsp newPw: " + newPw);
	System.out.println("updateAdminPwAction.jsp confirmPw: " + confirmPw);
	
	// 비밀번호 확인 불일치 시, 다시 비밀번호 수정 페이지로 이동
	if(!newPw.equals(confirmPw)) {
		System.out.println("updateAdminPwAction.jsp 비밀번호 확인 불일치");
		String msg = URLEncoder.encode("비밀번호가 일치하지 않습니다.", "UTF-8");
		response.sendRedirect("/cashbook/updateAdminPwForm.jsp?msg=" + msg);
		return;
	}
	
	// Admin 모델(dao) 호출
	AdminDao adminDao = new AdminDao();
	
	// 비밀번호 변경 메서드 호출
	int result = adminDao.updateAdminPw(newPw, adminId, beforePw);
	
	if(result == 1) {
		// 비밀번호 변경 성공 시, 세션 초기화
		session.invalidate();
		response.sendRedirect("/cashbook/loginForm.jsp");
	} else {
		// 비밀번호 변경 실패 시, 다시 비밀번호 수정 페이지로 이동
		String msg = URLEncoder.encode("비밀번호를 다시 확인해주세요.", "UTF-8");
		response.sendRedirect("/cashbook/updateAdminPwForm.jsp?msg=" + msg);
	}
%>
