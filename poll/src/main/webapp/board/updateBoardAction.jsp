<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String pass = request.getParameter("pass");
	// 전달된 파라미터 값 확인용 출력
	System.out.println("updateBoardAction.jsp num: " + num);
	System.out.println("updateBoardAction.jsp name: " + name);
	System.out.println("updateBoardAction.jsp subject: " + subject);
	System.out.println("updateBoardAction.jsp content: " + content);
	System.out.println("updateBoardAction.jsp pass: " + pass);
	
	BoardDao boardDao = new BoardDao();
	int result = boardDao.updateBoard(num, name, subject, content, pass);
	
	if(result == 1) {
		// View 없으므로, boardOne.jsp 로 이동
		response.sendRedirect("/poll/board/boardOne.jsp?num=" + num);
	} else {
		// 수정 실패로 인해, 다시 수정 페이지로 이동
		response.sendRedirect("/poll/board/updateBoardForm.jsp?num=" + num);
	}
%>
