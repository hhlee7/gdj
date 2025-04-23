<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String commentContent = request.getParameter("commentContent");
	String commentWriter = request.getParameter("commentWriter");
	String commentPw = request.getParameter("commentPw");
	// boardOne.jsp 브라우저에서 입력한 Comment List 값 넘어오는지 디버깅
	System.out.println("commentContent: " + commentContent);
	System.out.println("commentWriter: " + commentWriter);
	System.out.println("commentPw: " + commentPw);
	
	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = "insert into comment(board_no, comment_content, comment_writer, comment_pw) values(?, ?, ?, ?)";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0317", "root", "java1234");
	
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, boardNo);
	stmt.setString(2, commentContent);
	stmt.setString(3, commentWriter);
	stmt.setString(4, commentPw);
	// stmt / 쿼리 완성됨을 확인
	System.out.println(stmt);
	
	int row = 0;
	row = stmt.executeUpdate();
	// row 값 디버깅
	if(row == 1) {
		System.out.println("comment 정상 입력");
	} else {
		System.out.println("comment 입력 이상");
	}
	
	// comment 입력 완료 후 해당 boardOne.jsp 페이지로 돌아가기
	response.sendRedirect("/web0317/boardOne.jsp?boardNo=" + boardNo);	
%>