<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	int staffId = Integer.parseInt(request.getParameter("staffId"));
	String beforePassword = request.getParameter("beforePassword");
	String newPassword = request.getParameter("newPassword");
	String confirmPassword = request.getParameter("confirmPassword");
	// 전달받은 staffId, beforePassword, newPassword 값 확인
	System.out.println("updatePasswordAction.jsp staffId: " + staffId);
	System.out.println("updatePasswordAction.jsp beforePassword: " + beforePassword);
	System.out.println("updatePasswordAction.jsp newPassword: " + newPassword);
	System.out.println("updatePasswordAction.jsp confirmPassword: " + confirmPassword);

	if(!newPassword.equals(confirmPassword)) {
		System.out.println("updatePasswordAction.jsp: 비밀번호 확인 불일치");
		response.sendRedirect("/sakila/d0328/updatePasswordForm.jsp");
		return;
	}

	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "UPDATE staff SET PASSWORD = ? WHERE staff_id = ? AND PASSWORD = ?";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, newPassword);
	stmt.setInt(2, staffId);
	stmt.setString(3, beforePassword);
	
	int row = stmt.executeUpdate();
	if(row == 0) { // 비밀번호 업데이트 실패
		System.out.println("updatePasswordAction.jsp: 비밀번호 업데이트 실패");
		response.sendRedirect("/sakila/d0328/updatePasswordForm.jsp");
	} else if(row == 1) { // 비밀번호 업데이트 성공
		System.out.println("updatePasswordAction.jsp: 비밀번호 업데이트 성공");
		// 현재 세션을 초기화
		session.invalidate();
		response.sendRedirect("/sakila/d0328/loginForm.jsp");
	} else {
		System.out.println("update error");
	}
%>