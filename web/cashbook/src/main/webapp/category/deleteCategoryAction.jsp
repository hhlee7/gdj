<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	// 전달된 파라미터 값 확인용 출력
	System.out.println("deleteCategoryAction.jsp categoryNo: " + categoryNo);
	
	// Category 모델 호출
	CategoryDao categoryDao = new CategoryDao();
	
	// categoryNo값을 가지는 데이터를 삭제하는 메서드 호출
	categoryDao.deleteCategory(categoryNo);
	
	// 뷰 없으므로, categoryList.jsp로 이동
	response.sendRedirect("/cashbook/category/categoryList.jsp");
%>