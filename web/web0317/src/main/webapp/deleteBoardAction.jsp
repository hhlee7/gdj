<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardPw = request.getParameter("boardPw");
	Connection conn = null;
	// select
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	String sql1 = "select count(*) cnt from comment where board_no = ?";
	
	// delete
	PreparedStatement stmt2 = null;
	int row = 0;
	String sql2 = "delete from board where board_no = ? and board_pw = ?";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0317", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setInt(1, boardNo);
	rs1 = stmt1.executeQuery();
	rs1.next();
	int	result = rs1.getInt("cnt"); // 댓글 없으면 0, 있으면 0 보다 큰 수
		
	if(result != 0) {
		System.out.println("댓글이 존재하여 삭제 불가");
		response.sendRedirect("/web0317/boardOne.jsp?boardNo=" + boardNo);
		return; // 메서드 or JSP 강제 종료 키워드
	}
	// if문에 들어가지 않았다면, 댓글이 없다는 것, return문을 만나지 않기 때문에 코드는 진행됨
	// 게시글 삭제 코드 진행
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, boardNo);
	stmt2.setString(2, boardPw);
	row = stmt2.executeUpdate();
	if(row == 0) {
		System.out.println("비밀번호 확인 요망");
		response.sendRedirect("/web0317/deleteBoardForm.jsp?boardNo=" + boardNo);
		return;
	}
	response.sendRedirect("/web0317/boardList.jsp");	
%>