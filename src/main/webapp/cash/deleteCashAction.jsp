<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	int y = Integer.parseInt(request.getParameter("y"));
	int m = Integer.parseInt(request.getParameter("m"));
	int d = Integer.parseInt(request.getParameter("d"));
	// 전달된 파라미터 값 확인용 출력
	System.out.println("updateCashAction.jsp cashNo: " + cashNo);
	System.out.println("dateList.jsp y: " + y);
	System.out.println("dateList.jsp m: " + m);
	System.out.println("dateList.jsp d: " + d);
	
	// Cash 모델 호출
	CashDao cashDao = new CashDao();
	
	// 해당 cashNo 값을 가지는 데이터를 삭제하는 메서드 호출
	cashDao.deleteCash(cashNo);
	
	// 해당 일자 dateList.jsp로 이동
	response.sendRedirect("/cashbook/dateList.jsp?y=" + y + "&m=" + m + "&d=" + d);
%>