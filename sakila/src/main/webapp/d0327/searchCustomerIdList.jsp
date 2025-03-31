<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!-- Controller -->
<%
	// staff 로그인 상태 확인
	Integer staffId = (Integer)(session.getAttribute("loginStaff"));
	// 로그아웃 상태라면 로그인 페이지로 이동
	if(staffId == null) {
		response.sendRedirect("/sakila/d0328/loginForm.jsp");
		return;
	}

	Integer inventoryId = Integer.parseInt(request.getParameter("inventoryId"));
	String searchName = request.getParameter("searchName");
%>

<!-- Model -->
<%
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select customer_id customerId, first_name firstName, last_name lastName, email, active from customer where concat(first_name, last_name) like ?";
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, "%" + searchName + "%");
	// 완성된 쿼리 디버깅
	System.out.println(stmt);
	rs = stmt.executeQuery();
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>Search CustomerId List</h1>
	<table border="1">
		<tr>
			<th>customerId</th>
			<th>firstName</th>
			<th>lastName</th>
			<th>email</th>
			<th>active</th>
			<th>선택</th>
		</tr>
		<%
			while(rs.next()) {
		%>
				<tr>
					<td><%=rs.getInt("customerId")%></td>
					<td><%=rs.getString("firstName")%></td>
					<td><%=rs.getString("lastName")%></td>
					<td><%=rs.getString("email")%></td>
					<td><%=rs.getInt("active")%></td>
					<td>
						<%
							if(rs.getInt("active") == 0) {
						%>
								<a href='/sakila/d0327/updateCustomerActive.jsp?customerId=<%=rs.getInt("customerId")%>&active=<%=rs.getInt("active")%>'>
									휴면 상태 해지하기 <!-- 해당 customer의 active 값 0을 1로 변경 -->
								</a>
						<%
							} else {
						%>
								<a href='/sakila/d0327/insertRentalForm.jsp?customerId=<%=rs.getInt("customerId")%>&inventoryId=<%=inventoryId%>'>
									선택
								</a>
						<%
							}
						%>
					</td>
				</tr>
		<%
			}
		%>
	</table>
</body>
</html>