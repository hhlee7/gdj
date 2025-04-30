<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	String cashDate = request.getParameter("cashDate");
	int amount = Integer.parseInt(request.getParameter("amount"));
	String memo = request.getParameter("memo");
	String color = request.getParameter("color");
	// 전달된 파라미터 값 확인용 출력
	System.out.println("updateCashAction.jsp cashNo: " + cashNo);
	System.out.println("updateCashAction.jsp cashDate: " + cashDate);
	System.out.println("updateCashAction.jsp amount: " + amount);
	System.out.println("updateCashAction.jsp memo: " + memo);
	System.out.println("updateCashAction.jsp color: " + color);
	
	// Cash 모델 호출
	CashDao cashDao = new CashDao();
	
	// 해당 cashNo 값을 가지는 데이터의 정보를 update하는 메서드 호출
	cashDao.updateCash(cashNo, cashDate, amount, memo, color);
	
	// 수정 완료 후, 해당 cashOne.jsp로 이동
	response.sendRedirect("/cashbook//cash/cashOne.jsp?cashNo=" + cashNo);
%>