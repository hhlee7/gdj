<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	int y = Integer.parseInt(request.getParameter("y"));
	int m = Integer.parseInt(request.getParameter("m"));
	int d = Integer.parseInt(request.getParameter("d"));
	// y, m, d 값 넘어오는지 확인
	System.out.println("deleteDiaryAction.jsp y: " + y);
	System.out.println("deleteDiaryAction.jsp m: " + m);
	System.out.println("deleteDiaryAction.jsp d: " + d);
	
	int diaryNo = Integer.parseInt(request.getParameter("diaryNo"));
	System.out.println("deleteDiaryAction.jsp diaryNo:" + diaryNo);
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;	
	String sql = "delete from diary where diary_no = ?";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0318", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, diaryNo);
	// stmt 확인
	System.out.println("deleteDiaryAction.jsp stmt:" + stmt);
	
	int row = stmt.executeUpdate();
	if(row == 0) {
		response.sendRedirect("/web0318/dateList.jsp?y=" + y + "&m=" + m + "&d=" + d);
	} else if(row == 1) {
		response.sendRedirect("/web0318/dateList.jsp?y=" + y + "&m=" + m + "&d=" + d);
	} else {
		System.out.println("delete error");
	}
%>