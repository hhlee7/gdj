<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%
	String name = request.getParameter("name");
	int birth = Integer.parseInt(request.getParameter("birth"));
	String memo = request.getParameter("memo");
	
	// name, birth, memo 디버깅
	System.out.println("name: " + name);
	System.out.println("birth: " + birth);
	System.out.println("memo: " + memo);
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = "insert into person(name, birth, memo) values (?, ?, ?)";
	
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0313", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, name);
	stmt.setInt(2, birth);
	stmt.setString(3, memo);
	//stmt 디버깅
	System.out.println(stmt);
	
	// insert 결과 행 개수 디버깅
	int row = 0;
	row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("입력 정상");
	} else {
		System.out.println("입력 이상");		
	}
	
	response.sendRedirect("/web0313/personList.jsp");
%>