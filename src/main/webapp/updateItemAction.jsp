<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String[] inumArr = request.getParameterValues("inum");
	// inumArr 개수만큼 count++ 하는 메서드를 호출
	ItemDao itemDao = new ItemDao();
	for(String inum : inumArr) {
		itemDao.updateItemCountPlus(num, Integer.parseInt(inum));
	}
	
	// View 존재하지 않는 프로세스 : JSP(Java Server Page)일 필요 X
	// -> 다른 요청이 필요 -> Backend(Server)에서 요청 불가 -> 브라우저에 요청 강제화(<a> 강제화)
	response.sendRedirect("/poll/pollList.jsp");
%>
