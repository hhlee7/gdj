<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String category = request.getParameter("category");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	int age = Integer.parseInt(request.getParameter("age"));
	String pw = request.getParameter("pw");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = "update qna set category=?, title=?, content=?, age=? where num=? and pw=?";
	
	// 1) mysql api 메모리에 로딩
	Class.forName("com.mysql.cj.jdbc.Driver");
	
	// 2) db에 연결
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0313", "root", "java1234");

	// 3) 연결된 db에 쿼리 생성(추가 완성)
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, category);
	stmt.setString(2, title);
	stmt.setString(3, content);
	stmt.setInt(4, age);
	stmt.setInt(5, num);
	stmt.setString(6, pw);

	// 4) 쿼리 실행(결과가 있으면:select 결과를 출력)
	int row = stmt.executeUpdate(); // row 디버깅 코드 생략	
	// 데이터베이스에서 데이터를 수정 후 qnaOne.jsp(수정을 확인)로 이동하게 한다.
	if(row == 0) { // 수정 실패
		response.sendRedirect("/web0313/updateQnaForm.jsp?num=" + num);
	} else if(row == 1) { // 수정 성공
		response.sendRedirect("/web0313/qnaOne.jsp?num=" + num);
	} else { // 
		System.out.println("1행 이상이 수정 -> 오류");
	}
	
%>