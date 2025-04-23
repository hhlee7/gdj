<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String name = request.getParameter("name");
	int birth = Integer.parseInt(request.getParameter("birth"));
	String memo = request.getParameter("memo");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = "update person set name = ?, birth = ?, memo = ? where num = ?";
	
	// 1) mysql api 로딩
	Class.forName("com.mysql.cj.jdbc.Driver");

	// 2) db 연결
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0313", "root", "java1234");
	
	// 3) 쿼리 생성 및 미완성 된 ? 값 완성
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, name);
	stmt.setInt(2, birth);
	stmt.setString(3, memo);
	stmt.setInt(4, num);

	// 4) 쿼리 실행 / row 디버깅
	int row = 0;
	row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("정상 입력");
	} else {
		System.out.println("입력 이상");
	}

	// 수정 완료 후 personOne.jsp로 이동
	response.sendRedirect("/web0313/personOne.jsp?num=" + num);
%>