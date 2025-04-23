<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%
	String category = request.getParameter("category");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String writer = request.getParameter("writer");
	int age = Integer.parseInt(request.getParameter("age"));
	String pw = request.getParameter("pw");
	
	System.out.println("category: " + category);
	System.out.println("title: " + title);
	System.out.println("content: " + content);
	System.out.println("writer: " + writer);
	System.out.println("age: " + age);
	System.out.println("pw: " + pw);
	
	// DB 데이터 입력
	Class.forName("com.mysql.cj.jdbc.Driver");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	int row = 0; // insert 결과의 영향을 받은 행의 수 - 디버깅용
	String sql = "insert into qna(category, title, content, writer, age, pw) values (?, ?, ?, ?, ?, ?)";
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0313", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, category);
	stmt.setString(2, title);
	stmt.setString(3, content);
	stmt.setString(4, writer);
	stmt.setInt(5, age);
	stmt.setString(6, pw);
	System.out.println(stmt);
	row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("정상 입력");
	} else {
		System.out.println("입력 이상");		
	}
	
	response.sendRedirect("/web0313/qnaList.jsp");
%>