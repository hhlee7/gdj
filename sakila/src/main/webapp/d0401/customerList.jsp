<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!-- Controller -->
<%
	// 로그인 상태 확인
	Integer staffId = (Integer)(session.getAttribute("loginStaff"));
			
	if(staffId == null) { // 로그아웃 상태라면 로그인 페이지로 이동
		response.sendRedirect("/sakila/loginForm.jsp");
		return;
	}	

	// 페이징 설정
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10; // 페이지 당 보여줄 행 개수
	int startRow = (currentPage - 1) * rowPerPage;
	int pageBlock = 10; // 한 번에 표기할 페이지 번호 개수
	int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
	int endPage = startPage + pageBlock - 1;
%>

<!-- Model -->
<%
	// 조건에 맞는 데이터를 구하는 쿼리 작성
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "SELECT c.customer_id customerId, CONCAT(first_name, ' ', last_name) name"
				+ ", a.address address, a.postal_code zipCode, a.phone phone, ct.city city, ct2.country country"
				+ ", case when c.active = 1 then 'active' when c.active = 0 then '' ELSE c.active END notes"
				+ ", c.store_id storeId"
				+ " FROM customer c INNER JOIN address a ON c.address_id = a.address_id"
				+ " INNER JOIN city ct ON a.city_id = ct.city_id"
				+ " INNER JOIN country ct2 ON ct.country_id = ct2.country_id"
				+ " ORDER BY customerId asc"
				+ " limit ?, ?";
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, startRow);
	stmt.setInt(2, rowPerPage);
	
	// 조건에 맞는 데이터의 전체 행 수를 구하는 쿼리 작성
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	String sql2 = "SELECT COUNT(*) cnt"
				+ " FROM customer c INNER JOIN address a ON c.address_id = a.address_id"
				+ " INNER JOIN city ct ON a.city_id = ct.city_id"
				+ " INNER JOIN country ct2 ON ct.country_id = ct2.country_id";
	stmt2 = conn.prepareStatement(sql2);
	
	// 완성된 쿼리 확인용 출력
	System.out.println("customerList.jsp stmt: " + stmt);
	System.out.println("customerList.jsp stmt2: " + stmt2);
	
	rs = stmt.executeQuery();
	rs2 = stmt2.executeQuery();
	rs2.next();
	// 조회된 전체 행 수 확인용 출력
	System.out.println("customerList.jsp cnt: " + rs2.getInt("cnt"));
	
	// ResultSet에서 각 행의 데이터를 꺼내어 Map에 저장하고, 이를 list에 추가
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	while(rs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("customerId", rs.getInt("customerId"));
		map.put("name", rs.getString("name"));
		map.put("address", rs.getString("address"));
		map.put("zipCode", rs.getString("zipCode"));
		map.put("phone", rs.getString("phone"));
		map.put("city", rs.getString("city"));
		map.put("country", rs.getString("country"));
		map.put("notes", rs.getString("notes"));
		map.put("storeId", rs.getInt("storeId"));
		list.add(map);
	}
	
	// 마지막 페이지 설정
	int totalCnt = rs2.getInt("cnt");
	int lastPage = totalCnt / rowPerPage;
	if(totalCnt % rowPerPage != 0) {
		lastPage += 1;
	}
	
	// endPage가 실제 마지막 페이지를 초과하지 않게 설정
	if(endPage > lastPage) {
		endPage = lastPage;
	}
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>Customer List</h1>
	
	<!-- customerList 각 행 데이터 출력 -->
	<table border="1">
		<tr>
			<th>customerId</th>
			<th>name</th>
			<th>address</th>
			<th>zipCode</th>
			<th>phone</th>
			<th>city</th>
			<th>country</th>
			<th>notes</th>
			<th>storeId</th>
		</tr>
		<%
			for(HashMap<String, Object> map : list) {
		%>
		<tr>
			<td><%=map.get("customerId")%></td>
			<td><%=map.get("name")%></td>
			<td><%=map.get("address")%></td>
			<td><%=map.get("zipCode")%></td>
			<td><%=map.get("phone")%></td>
			<td><%=map.get("city")%></td>
			<td><%=map.get("country")%></td>
			<td><%=map.get("notes")%></td>
			<td><%=map.get("storeId")%></td>
		</tr>
		<%
			}
		%>
	</table>
	
	<!-- 페이징 -->
	<a href="/sakila/d0401/customerList.jsp?currentPage=1">[처음]</a>
	<%
		if(startPage > 1) {
	%>
			<a href="/sakila/d0401/customerList.jsp?currentPage=<%=startPage - 10%>">[이전 10페이지]</a>
	<%
		}
	%>
	
	<%
		if(currentPage > 1) {
	%>
			<a href="/sakila/d0401/customerList.jsp?currentPage=<%=currentPage - 1%>">[이전]</a>
	<%
		}
	%>
	
	<%
		for(int i = startPage; i <= endPage; i++) {
			if(currentPage == i) {
	%>
				[<%=i%>]
	<%
			} else {
	%>
				<a href="/sakila/d0401/customerList.jsp?currentPage=<%=i%>">[<%=i%>]</a>
	<%
			}
		}
	%>
	
	<%
		if(currentPage < lastPage) {
	%>
			<a href="/sakila/d0401/customerList.jsp?currentPage=<%=currentPage + 1%>">[다음]</a>
	<%
		}
	%>
	
	<%
		if(endPage < lastPage) {
	%>
			<a href="/sakila/d0401/customerList.jsp?currentPage=<%=startPage + 10%>">[다음 10페이지]</a>
	<%
		}
	%>
	<a href="/sakila/d0401/customerList.jsp?currentPage=<%=lastPage%>">[끝으로]</a>
</body>
</html>