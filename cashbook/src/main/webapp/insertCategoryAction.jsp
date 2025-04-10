<%@page import="model.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String kind = request.getParameter("kind");
	String title = request.getParameter("title");
	// 전달된 파라미터 값 확인용 출력
	System.out.println("insertCategoryAction.jsp kind: " + kind);
	System.out.println("insertCategoryAction.jsp title: " + title);
	
	// category model 호출
	CategoryDao categoryDao = new CategoryDao();
	
	// insertCategory 메서드 호출
	categoryDao.insertCategory(kind, title);
	
	// 뷰 없으므로, categoryList.jsp로 이동
	response.sendRedirect("/cashbook/categoryList.jsp");
	
/* 참고 사항
	// select count(*) from category where kind = ? and title = ?
			
	int ckCount = categoryDao.selectCountTitle(category);
	if(ckCount > 0) { // 동일한 kind and title이 존재
		response.sendRedirect("/insertCategoryForm.jsp?msg=duplicate_category_title");
		return;
	}
	
	// 입력코드
	
*/
%>