<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	// 전달된 num 값 확인
	System.out.println("deletePollAction.jsp num: " + num);

	// 모델(Dao) 객체 생성
	ItemDao itemDao = new ItemDao();
	QuestionDao questionDao = new QuestionDao();
	
	// item 테이블의 해당 데이터 먼저 삭제
	itemDao.deleteItem(num);
	// question 테이블의 해당 데이터 삭제
	questionDao.deleteQuestion(num);
	
	// 삭제 후 투표 리스트로 이동
	response.sendRedirect("/poll/pollList.jsp");
%>