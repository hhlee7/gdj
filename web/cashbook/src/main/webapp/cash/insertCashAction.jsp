<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String cashDate = request.getParameter("cashDate");
	int amount = Integer.parseInt(request.getParameter("amount"));
	String memo = request.getParameter("memo");
	String color = request.getParameter("color");
	// 전달된 파라미터 값 확인용 출력
	System.out.println("insertCashAction.jsp categoryNo: " + categoryNo);
	System.out.println("insertCashAction.jsp cashDate: " + cashDate);
	System.out.println("insertCashAction.jsp amount: " + amount);
	System.out.println("insertCashAction.jsp memo: " + memo);
	System.out.println("insertCashAction.jsp color: " + color);
	
	// Cash 모델 호출
	CashDao cashDao = new CashDao();
	
	// insert 메서드 호출
	cashDao.insertCash(categoryNo, cashDate, amount, memo, color);
	
	// dateList.jsp로 보낼 cashDate 값 형식 변환
	String dateParts[] = cashDate.split("-");
	int y = Integer.parseInt(dateParts[0]);
	int m = Integer.parseInt(dateParts[1]);
	int d = Integer.parseInt(dateParts[2]);
	
	// 뷰 없으므로, 해당 dateList.jsp로 이동
	response.sendRedirect("/cashbook/dateList.jsp?y=" + y + "&m=" + m + "&d=" + d);
%>