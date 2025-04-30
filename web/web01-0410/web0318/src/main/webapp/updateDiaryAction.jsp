<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	int y = Integer.parseInt(request.getParameter("y"));
	int m = Integer.parseInt(request.getParameter("m"));
	int d = Integer.parseInt(request.getParameter("d"));
	// y, m, d 값 넘어오는지 확인
	System.out.println("updateDiaryAction.jsp y: " + y);
	System.out.println("updateDiaryAction.jsp m: " + m);
	System.out.println("updateDiaryAction.jsp d: " + d);
	
	int diaryNo = Integer.parseInt(request.getParameter("diaryNo"));
	String diaryTitle = request.getParameter("diaryTitle");
	String diaryColor = request.getParameter("diaryColor");
	String diaryMemo = request.getParameter("diaryMemo");
	// 값 넘어오는지 확인
	System.out.println("updateDiaryAction.jsp diaryNo:" + diaryNo);
	System.out.println("updateDiaryAction.jsp diaryTitle:" + diaryTitle);
	System.out.println("updateDiaryAction.jsp diaryColor:" + diaryColor);
	System.out.println("updateDiaryAction.jsp diaryMemo:" + diaryMemo);
	
	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = "update diary set diary_title = ?, diary_color = ?, diary_memo = ? where diary_no = ?";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0318", "root", "java1234");
	
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, diaryTitle);
	stmt.setString(2, diaryColor);
	stmt.setString(3, diaryMemo);
	stmt.setInt(4, diaryNo);
	System.out.println("updateDiaryAction.jsp stmt: " + stmt);
	
	int row = stmt.executeUpdate();
	if(row == 0) {
		response.sendRedirect("/web0318/dateList.jsp?y=" + y + "&m=" + m + "&d=" + d);
	} else if(row == 1) {
		response.sendRedirect("/web0318/dateList.jsp?y=" + y + "&m=" + m + "&d=" + d);
	} else {
		System.out.println("update error");
	}
%>