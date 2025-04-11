<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%@page import="java.net.URLEncoder"%>
<%
	String kind = request.getParameter("kind");
	String title = request.getParameter("title");
	// 전달된 파라미터 값 확인용 출력
	System.out.println("insertCategoryAction.jsp kind: " + kind);
	System.out.println("insertCategoryAction.jsp title: " + title);
	
	// category model 호출
	CategoryDao categoryDao = new CategoryDao();
	
	// 입력값이 없을 시
	if(title.equals("")) {
		String msg = URLEncoder.encode("제목을 입력하세요.", "UTF-8");
		response.sendRedirect("/cashbook/category/insertCategoryForm.jsp?msg=" + msg);
		return;
	}
	
	// 카테고리에 중복된 값이 있는지 먼저 조회
	int result = categoryDao.checkDuplicateCategory(kind, title);

	// 중복값이 없으면 insertCategory 메서드 호출
	if(result == 0) {
		categoryDao.insertCategory(kind, title);
		response.sendRedirect("/cashbook/category/categoryList.jsp");
	// 중복값이 존재하면 error msg 출력
	} else {
		System.out.println("insertCategoryAction.jsp 중복된 제목의 카테고리입니다.");
		String msg = URLEncoder.encode("중복된 제목의 카테고리입니다.", "UTF-8");
		response.sendRedirect("/cashbook/category/insertCategoryForm.jsp?msg=" + msg);
	}
%>