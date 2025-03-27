<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!-- Controller -->
<%
	//페이징 설정
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10; // 페이지 당 보여줄 행 개수
	int startRow = (currentPage - 1) * rowPerPage;
	
	int pageBlock = 10; // 페이지 번호 10개씩 표시
	int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
	int endPage = startPage + pageBlock - 1;
%>

<!-- Model -->
<%
	// mysql 드라이버 로딩
	Class.forName("com.mysql.cj.jdbc.Driver");
	System.out.println("inventoryList.jsp: 드라이버 로딩 성공");
	
	// inventory list를 조회하는 쿼리 작성
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "SELECT t.inventory_id inventoryId, f.title title, t.return_date returnDate, t.isRental isRental"
				+ " FROM (SELECT i.inventory_id, i.film_id, t.return_date"
				+ ", case when t.rental_date IS NULL then '대여가능'"
				+ " when t.return_date IS NULL then '대여불가'"
				+ " ELSE '대여가능' END isRental"
				+ " from inventory i LEFT JOIN (SELECT inventory_id, rental_date, return_date FROM rental"
				+ " WHERE (inventory_id, rental_date) IN (SELECT inventory_id, MAX(rental_date)"
				+ " FROM rental GROUP BY inventory_id) ORDER BY inventory_id ASC) t ON i.inventory_id = t.inventory_id) t"
				+ " INNER JOIN film f ON t.film_id = f.film_id"
				+ " limit ?, ?";
	
	// inventory list의 전체 행 수를 조회하는 쿼리 작성
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	String sql2 = "SELECT count(*) cnt"
				+ " FROM (SELECT i.inventory_id, i.film_id, t.return_date"
				+ ", case when t.rental_date IS NULL then '대여가능'"
				+ " when t.return_date IS NULL then '대여불가'"
				+ " ELSE '대여가능' END isRental"
				+ " from inventory i LEFT JOIN (SELECT inventory_id, rental_date, return_date FROM rental"
				+ " WHERE (inventory_id, rental_date) IN (SELECT inventory_id, MAX(rental_date)"
				+ " FROM rental GROUP BY inventory_id) ORDER BY inventory_id ASC) t ON i.inventory_id = t.inventory_id) t"
				+ " INNER JOIN film f ON t.film_id = f.film_id";
	
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");
	
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, startRow);
	stmt.setInt(2, rowPerPage);
	stmt2 = conn.prepareStatement(sql2);
	rs = stmt.executeQuery();
	rs2 = stmt2.executeQuery();
	rs2.next();
	// 조회된 전체 행 수 출력 확인
	System.out.println("inventoryList.jsp 전체 행의 수: " + rs2.getInt("cnt"));
	
	// 조회된 inventory list를 HashMap에 담고, ArrayList에 저장
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	while(rs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("inventoryId", rs.getInt("inventoryId"));
		map.put("title", rs.getString("title"));
		map.put("returnDate", rs.getString("returnDate"));
		map.put("isRental", rs.getString("isRental"));
		list.add(map);
	}
	
	// 페이징 - 마지막 페이지 설정
	int totalCnt = rs2.getInt("cnt");
	int lastPage = totalCnt / rowPerPage;
	if(totalCnt % rowPerPage != 0) {
		lastPage += 1;
	}
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
	<h1>Inventory List</h1>
	
	<!-- inventory list 출력 -->
	<table border="1">
		<tr>
			<th>inventoryId</th>
			<th>title</th>
			<th>returnDate</th>
			<th>isRental</th>
		</tr>
		<%
			for(HashMap<String, Object> map : list) {
		%>
				<tr>
					<td><%=map.get("inventoryId")%></td>
					<td><%=map.get("title")%></td>
					<td><%=map.get("returnDate")%></td>
					<%
						if((map.get("isRental")).equals("대여가능")) {
					%>
					<td><a href=""><%=map.get("isRental")%></a></td>
					<%
						} else {
					%>
							<td><%=map.get("isRental")%></td>
					<%
						}
					%>
				</tr>
		<%
			}
		%>
		</table>
		
		<!-- 페이징 -->
		<a href="/sakila/d0327/inventoryList.jsp?currentPage=1">[처음]</a>
		<%
			if(startPage > 1) {
		%>
			<a href="/sakila/d0327/inventoryList.jsp?currentPage=<%=startPage - 10%>">[이전 10페이지]</a>
		<%
			}
		%>
		
		<%
			if(currentPage > 1) {
		%>
			<a href="/sakila/d0327/inventoryList.jsp?currentPage=<%=currentPage - 1%>">[이전]</a>
		<%
			}
		%>
		
		<%	// 페이지 번호 리스트
			for(int i = startPage; i <= endPage; i++) {
				if(i == currentPage) {
		%>
					[<%=i%>]
		<%
				} else {
		%>
					<a href="/sakila/d0327/inventoryList.jsp?currentPage=<%=i%>">[<%=i%>]</a>
		<%
				}
			}
		%>
		
		<%
			if(currentPage < lastPage) {
		%>
			<a href="/sakila/d0327/inventoryList.jsp?currentPage=<%=currentPage + 1%>">[다음]</a>
		<%
			}
		%>
		
		<%
			if(endPage < lastPage) {
		%>
			<a href="/sakila/d0327/inventoryList.jsp?currentPage=<%=startPage + 10%>">[다음 10페이지]</a>
		<%
			}
		%>
		<a href="/sakila/d0327/inventoryList.jsp?currentPage=<%=lastPage%>">[끝으로]</a>	
</body>
</html>