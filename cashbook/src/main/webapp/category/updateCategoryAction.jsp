<%@page import="dto.Category"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%@page import="java.net.URLEncoder"%>
<%
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String kind = request.getParameter("kind");
	String title = request.getParameter("title");
	// 전달된 파라미터 값 확인용 출력
	System.out.println("updateCategoryAction.jsp categoryNo: " + categoryNo);
	System.out.println("updateCategoryAction.jsp kind: " + kind);
	System.out.println("updateCategoryAction.jsp title: " + title);
	
	// Category 모델 호출
	CategoryDao categoryDao = new CategoryDao();
	
	// 입력값이 없을 시
	if(title.equals("")) {
		String msg = URLEncoder.encode("제목을 입력하세요.", "UTF-8");
		response.sendRedirect("/cashbook/category/updateCategoryForm.jsp?categoryNo=" + categoryNo + "&msg=" + msg);
		return;
	}
	
	// 동일한 카테고리 제목으로 수정 시, msg 출력
	Category c = categoryDao.selectCategory(categoryNo);
	if(c.getTitle().equals(title)) {
		String msg = URLEncoder.encode("기존과 동일한 카테고리 제목입니다.", "UTF-8");
		response.sendRedirect("/cashbook/category/updateCategoryForm.jsp?categoryNo=" + categoryNo + "&msg=" + msg);
		return;
	}
	
	// 카테고리에 중복된 값이 있는지 먼저 조회
	int result = categoryDao.checkDuplicateCategory(kind, title);
	
	// 중복값이 없다면 categoryNo값을 가지는 데이터를 수정하는 메서드 호출
	if(result == 0) {
		categoryDao.updateCategory(kind, title, categoryNo);
		response.sendRedirect("/cashbook/category/categoryList.jsp");
	// 중복값이 존재하면 error msg 출력
	} else {
		System.out.println("updateCategoryAction.jsp 중복된 카테고리 제목입니다.");
		String msg = URLEncoder.encode("중복된 카테고리 제목입니다.", "UTF-8");
		response.sendRedirect("/cashbook/category/updateCategoryForm.jsp?categoryNo=" + categoryNo + "&msg=" + msg);
	}
%>