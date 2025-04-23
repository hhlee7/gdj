<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardWriter = request.getParameter("boardWriter");
	String boardPw = request.getParameter("boardPw");
	// insertBoardForm.jsp 브라우저에서 입력한 값 넘어오는지 디버깅
	System.out.println("boardTitle: " + boardTitle);
	System.out.println("boardContent: " + boardContent);
	System.out.println("boardWriter: " + boardWriter);
	System.out.println("boardPw: " + boardPw);

	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = "insert into board(board_title, board_content, board_writer, board_pw) values(?, ?, ?, ?)";
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0317", "root", "java1234");
	
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, boardTitle);
	stmt.setString(2, boardContent);
	stmt.setString(3, boardWriter);
	stmt.setString(4, boardPw);
	// stmt / 쿼리 완성됨을 확인
	System.out.println(stmt);
	
	int row = 0;
	row = stmt.executeUpdate();
	// row 값 디버깅
	if(row == 1) {
		System.out.println("정상 입력");
	} else {
		System.out.println("입력 이상");
	}
	
	response.sendRedirect("/web0317/boardList.jsp");
%>