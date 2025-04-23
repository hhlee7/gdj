<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	int y = Integer.parseInt(request.getParameter("y"));
	int m = Integer.parseInt(request.getParameter("m"));
	int d = Integer.parseInt(request.getParameter("d"));
	// y, m, d 값 넘어오는지 확인
	System.out.println("insertDiaryAction.jsp y: " + y);
	System.out.println("insertDiaryAction.jsp m: " + m);
	System.out.println("insertDiaryAction.jsp d: " + d);
	
	String diaryTitle = request.getParameter("diaryTitle");
	String diaryColor = request.getParameter("diaryColor");
	String diaryMemo = request.getParameter("diaryMemo");
	System.out.println("insertDiaryAction.jsp diaryTitle: " + diaryTitle);
	System.out.println("insertDiaryAction.jsp diaryColor: " + diaryColor);
	System.out.println("insertDiaryAction.jsp diaryMemo: " + diaryMemo);
	
	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = "insert into diary(diary_date, diary_title, diary_color, diary_memo) values(?, ?, ?, ?)";
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0318", "root", "java1234");
	
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, y + "-" + m + "-" + d);
	stmt.setString(2, diaryTitle);
	stmt.setString(3, diaryColor);
	stmt.setString(4, diaryMemo);
	// stmt 확인
	System.out.println("insertDiaryAction.jsp stmt: " + stmt);
	
	int row = 0;
	row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("정상 입력");
	} else {
		System.out.println("입력 오류");
	}
	response.sendRedirect("/web0318/dateList.jsp?y=" + y + "&m=" + m + "&d=" + d);
%>