<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	String commentPw = request.getParameter("commentPw");
	System.out.println(boardNo);
	System.out.println(commentNo);
	System.out.println(commentPw);
	
	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = "delete from comment where comment_no = ? and comment_pw = ?";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0317", "root", "java1234");
	
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, commentNo);
	stmt.setString(2, commentPw);
	System.out.println(stmt);
	
	int row = stmt.executeUpdate();
	
	if(row == 0) {
		response.sendRedirect("/web0317/deleteCommentForm.jsp?boardNo=" + boardNo + "&commentNo=" + commentNo);
	} else if(row == 1) {
		response.sendRedirect("/web0317/boardOne.jsp?boardNo=" + boardNo);
	} else {
		System.out.println("삭제 error");
	}
%>