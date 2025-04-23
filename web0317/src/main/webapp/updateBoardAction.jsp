<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardWriter = request.getParameter("boardWriter");
	String boardPw = request.getParameter("boardPw");
	// updateBoardForm.jsp 에서 값 넘어오는지 디버깅
	System.out.println("boardTitle: " + boardTitle);
	System.out.println("boardContent: " + boardContent);
	System.out.println("boardWriter: " + boardWriter);
	System.out.println("boardPw: " + boardPw);
	
	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = "update board set board_title=?, board_content=?, board_writer=? where board_no=? and board_pw=?";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0317", "root", "java1234");
	
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, boardTitle);
	stmt.setString(2, boardContent);
	stmt.setString(3, boardWriter);
	stmt.setInt(4, boardNo);
	stmt.setString(5, boardPw);
	
	int row = stmt.executeUpdate();
	if(row == 0) { // update 실패
		response.sendRedirect("/web0317/updateBoardForm.jsp?boardNo=" + boardNo);
	} else if(row == 1) {
		response.sendRedirect("/web0317/boardOne.jsp?boardNo=" + boardNo);
	} else {
		System.out.println("update 오류");
	}
%>