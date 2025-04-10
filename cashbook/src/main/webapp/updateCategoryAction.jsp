<%@page import="model.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String kind = request.getParameter("kind");
	String title = request.getParameter("title");
	// 전달된 파라미터 값 확인용 출력
	System.out.println("updateCategoryAction.jsp categoryNo: " + categoryNo);
	System.out.println("updateCategoryAction.jsp kind: " + kind);
	System.out.println("updateCategoryAction.jsp title: " + title);
	
	// Category 모델 호출
%>