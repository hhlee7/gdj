<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pw = request.getParameter("pw");
	
	// 1
	Class.forName("com.mysql.cj.jdbc.Driver");
	
	// 2
	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = "delete from qna where num = ? and pw = ?";
	
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0313", "root", "java1234");
	
	// 3
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, num);
	stmt.setString(2, pw);
	
	// 4
	int row = stmt.executeUpdate();
	
	// 5. 실행 결과에 따른 페이지 분기
	if(row == 0) {
		response.sendRedirect("/web0313/qnaOne.jsp?num=" + num);
	} else if(row == 1) {
		response.sendRedirect("/web0313/qnaList.jsp");
	} else {
		System.out.println("삭제 error");
	}
%>