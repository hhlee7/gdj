<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!-- Controller -->
<%
	Integer inventoryId = Integer.parseInt(request.getParameter("inventoryId"));
	Integer customerId = Integer.parseInt(request.getParameter("customerId"));
	Integer staffId = (Integer)session.getAttribute("loginStaff");
	// 전달된 inventoryId, customerId, staffId 값 확인
	System.out.println("insertRentalAction.jsp inventoryId:" + inventoryId);
	System.out.println("insertRentalAction.jsp customerId:" + customerId);
	System.out.println("insertRentalAction.jsp staffId:" + staffId);
	
%>

<!-- Model -->
<%
	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = "insert into rental(rental_date, inventory_id, customer_id, return_date, staff_id) values(now(), ?, ?, ?, ?)";
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, inventoryId);
	stmt.setInt(2, customerId);
	stmt.setString(3, null);
	stmt.setInt(4, staffId);
	// 완성된 쿼리 디버깅
	System.out.println("insertRentalAction.jsp stmt: " + stmt);
	
	int row = stmt.executeUpdate();
	if(row == 0) {
		System.out.println("insertRentalAction.jsp : insert 실패");
		response.sendRedirect("/sakila/d0327/insertRentalForm.jsp");
	} else if(row == 1) {
		System.out.println("insertRentalAction.jsp : insert 성공");
		response.sendRedirect("/sakila/d0325/rentalList.jsp");
	} else {
		System.out.println("insert error");
	}
%>