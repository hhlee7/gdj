<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.*"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String enddate = request.getParameter("enddate");
	// 전달된 파라미터 값 확인용 출력
	System.out.println("updateQuestionEnddateAction.jsp num: " + num);
	System.out.println("updateQuestionEnddateAction.jsp enddate: " + enddate);
	
	// 오늘 날짜 가져오기
	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String todayStr = sdf.format(date);
	Date today = sdf.parse(todayStr);
	// enddate 객체 타입 변환
	Date endDate = sdf.parse(enddate);
	
	// 이미 종료된 설문 -> 종료 일자 수정 불가 -> 다시 수정 페이지로 이동
	if(today.after(endDate)) {
		response.sendRedirect("/poll/updateQuestionEnddateForm.jsp?num=" + num);
		return;
	}
	
	// Dao 객체 및 enddate 수정 메서드 호출
	QuestionDao questionDao = new QuestionDao();
	questionDao.updateQuestionEnddate(num, enddate);
	
	// View 없으므로, pollList.jsp로 이동
	response.sendRedirect("/poll/pollList.jsp");
%>