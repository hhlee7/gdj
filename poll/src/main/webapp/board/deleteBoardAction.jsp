<%@page import="model.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pass = request.getParameter("pass");
	// 전달된 num 값 확인
	System.out.println("deleteBoardAction.jsp num: " + num);
	System.out.println("deleteBoardAction.jsp pass: " + pass);
	
	BoardDao boardDao = new BoardDao();
	
	int result = boardDao.deleteBoard(num, pass);
	
	if(result == 1) {
		// View 없으므로, boardList.jsp 로 이동
		response.sendRedirect("/poll/board/boardList.jsp");
	} else {
		// 삭제 실패로 인해, 다시 비밀번호 입력 페이지(deleteBoardForm.jsp)로 이동
		response.sendRedirect("/poll/board/deleteBoardForm.jsp?num=" + num);
	}
%>
