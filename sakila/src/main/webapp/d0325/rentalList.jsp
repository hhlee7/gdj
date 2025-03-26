<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!-- Controller -->
<%
	String searchWord = request.getParameter("searchWord");
	int storeId = 0;
	if(request.getParameter("storeId") != null && !request.getParameter("storeId").isEmpty()) {
		storeId = Integer.parseInt(request.getParameter("storeId"));
	}
	// 전달된 searchWord & storeId 값 확인
	System.out.println("rentalList.jsp searchWord: " + searchWord);
	System.out.println("rentalList.jsp storeId: " + storeId);
	
	if(searchWord == null) {
		searchWord = "";
	}
	
	// 페이징 설정
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
	System.out.println("드라이버 로딩 성공");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql;

	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	String sql2;
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");

	// 1. 전체 지점 검색 시
	if(storeId == 0) {
		
	// 1-1. 검색어가 없을 시 기본 쿼리 실행
		if(searchWord.equals("")) {
			sql = "SELECT t.rental_id rentalId, t.inventory_id inventoryId"
				+ ", t.rental_date rentalDate, ifnull(t.return_date, '반납 예정') returnDate"
				+ ", t.customer_id customerId, t.store_id storeId"
				+ ", CONCAT(t.first_name, ' ', t.last_name) name, f.title filmTitle"
				+ " FROM (SELECT t.rental_id, t.inventory_id, t.rental_date, t.return_date, t.customer_id, t.film_id, c.first_name, c.last_name, c.store_id"
				+ " FROM (SELECT r.rental_id, r.inventory_id, r.rental_date, r.return_date, r.customer_id, i.film_id"
				+ " FROM rental r INNER JOIN inventory i ON r.inventory_id = i.inventory_id) t"
				+ " INNER JOIN customer c ON t.customer_id = c.customer_id) t"
				+ " INNER JOIN film f ON t.film_id = f.film_id"
				+ " order by rentalId"
				+ " limit ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
			sql2 = "SELECT count(*) cnt"
				+ " FROM (SELECT t.rental_id, t.inventory_id, t.rental_date, t.return_date, t.customer_id, t.film_id, c.first_name, c.last_name, c.store_id"
				+ " FROM (SELECT r.rental_id, r.inventory_id, r.rental_date, r.return_date, r.customer_id, i.film_id"
				+ " FROM rental r INNER JOIN inventory i ON r.inventory_id = i.inventory_id) t"
				+ " INNER JOIN customer c ON t.customer_id = c.customer_id) t"
				+ " INNER JOIN film f ON t.film_id = f.film_id";
			stmt2 = conn.prepareStatement(sql2);
			
	// 1-2. 검색어 있을 시 필터링 쿼리 실행
		} else {
			sql = "SELECT t.rental_id rentalId, t.inventory_id inventoryId"
					+ ", t.rental_date rentalDate, ifnull(t.return_date, '반납 예정') returnDate"
					+ ", t.customer_id customerId, t.store_id storeId"
					+ ", CONCAT(t.first_name, ' ', t.last_name) name, f.title filmTitle"
					+ " FROM (SELECT t.rental_id, t.inventory_id, t.rental_date, t.return_date, t.customer_id, t.film_id, c.first_name, c.last_name, c.store_id"
					+ " FROM (SELECT r.rental_id, r.inventory_id, r.rental_date, r.return_date, r.customer_id, i.film_id"
					+ " FROM rental r INNER JOIN inventory i ON r.inventory_id = i.inventory_id) t"
					+ " INNER JOIN customer c ON t.customer_id = c.customer_id) t"
					+ " INNER JOIN film f ON t.film_id = f.film_id"
					+ " WHERE f.title like ?"
					+ " order by rentalId"
					+ " limit ?, ?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, "%" + searchWord + "%");
				stmt.setInt(2, startRow);
				stmt.setInt(3, rowPerPage);
				sql2 = "SELECT count(*) cnt"
					+ " FROM (SELECT t.rental_id, t.inventory_id, t.rental_date, t.return_date, t.customer_id, t.film_id, c.first_name, c.last_name, c.store_id"
					+ " FROM (SELECT r.rental_id, r.inventory_id, r.rental_date, r.return_date, r.customer_id, i.film_id"
					+ " FROM rental r INNER JOIN inventory i ON r.inventory_id = i.inventory_id) t"
					+ " INNER JOIN customer c ON t.customer_id = c.customer_id) t"
					+ " INNER JOIN film f ON t.film_id = f.film_id"
					+ " WHERE f.title like ?";
				stmt2 = conn.prepareStatement(sql2);
				stmt2.setString(1, "%" + searchWord + "%");
		}
	
	// 2. 1 or 2 지점 검색 시
	} else {
		
	// 2-1. 검색어 없을 시 기본 쿼리 실행
		if(searchWord.equals("")) {
			sql = "SELECT t.rental_id rentalId, t.inventory_id inventoryId"
					+ ", t.rental_date rentalDate, t.return_date returnDate"
					+ ", t.customer_id customerId, t.store_id storeId"
					+ ", CONCAT(t.first_name, ' ', t.last_name) name, f.title filmTitle"
					+ " FROM (SELECT t.rental_id, t.inventory_id, t.rental_date, t.return_date, t.customer_id, t.film_id, c.first_name, c.last_name, c.store_id"
					+ " FROM (SELECT r.rental_id, r.inventory_id, r.rental_date, r.return_date, r.customer_id, i.film_id"
					+ " FROM rental r INNER JOIN inventory i ON r.inventory_id = i.inventory_id) t"
					+ " INNER JOIN customer c ON t.customer_id = c.customer_id) t"
					+ " INNER JOIN film f ON t.film_id = f.film_id"
					+ " WHERE t.store_id = ?"
					+ " order by rentalId"
					+ " limit ?, ?";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, storeId);
				stmt.setInt(2, startRow);
				stmt.setInt(3, rowPerPage);
				sql2 = "SELECT count(*) cnt"
					+ " FROM (SELECT t.rental_id, t.inventory_id, t.rental_date, t.return_date, t.customer_id, t.film_id, c.first_name, c.last_name, c.store_id"
					+ " FROM (SELECT r.rental_id, r.inventory_id, r.rental_date, r.return_date, r.customer_id, i.film_id"
					+ " FROM rental r INNER JOIN inventory i ON r.inventory_id = i.inventory_id) t"
					+ " INNER JOIN customer c ON t.customer_id = c.customer_id) t"
					+ " INNER JOIN film f ON t.film_id = f.film_id"
					+ " WHERE t.store_id = ?";
				stmt2 = conn.prepareStatement(sql2);
				stmt2.setInt(1, storeId);
	// 2-2. 검색어 있을 시 필터링 쿼리 실행
		} else {
			sql = "SELECT t.rental_id rentalId, t.inventory_id inventoryId"
					+ ", t.rental_date rentalDate, t.return_date returnDate"
					+ ", t.customer_id customerId, t.store_id storeId"
					+ ", CONCAT(t.first_name, ' ', t.last_name) name, f.title filmTitle"
					+ " FROM (SELECT t.rental_id, t.inventory_id, t.rental_date, t.return_date, t.customer_id, t.film_id, c.first_name, c.last_name, c.store_id"
					+ " FROM (SELECT r.rental_id, r.inventory_id, r.rental_date, r.return_date, r.customer_id, i.film_id"
					+ " FROM rental r INNER JOIN inventory i ON r.inventory_id = i.inventory_id) t"
					+ " INNER JOIN customer c ON t.customer_id = c.customer_id) t"
					+ " INNER JOIN film f ON t.film_id = f.film_id"
					+ " WHERE t.store_id = ? and f.title like ?"
					+ " order by rentalId"
					+ " limit ?, ?";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, storeId);
				stmt.setString(2, "%" + searchWord + "%");
				stmt.setInt(3, startRow);
				stmt.setInt(4, rowPerPage);
				sql2 = "SELECT count(*) cnt"
					+ " FROM (SELECT t.rental_id, t.inventory_id, t.rental_date, t.return_date, t.customer_id, t.film_id, c.first_name, c.last_name, c.store_id"
					+ " FROM (SELECT r.rental_id, r.inventory_id, r.rental_date, r.return_date, r.customer_id, i.film_id"
					+ " FROM rental r INNER JOIN inventory i ON r.inventory_id = i.inventory_id) t"
					+ " INNER JOIN customer c ON t.customer_id = c.customer_id) t"
					+ " INNER JOIN film f ON t.film_id = f.film_id"
					+ " WHERE t.store_id = ? and f.title like ?";
				stmt2 = conn.prepareStatement(sql2);
				stmt2.setInt(1, storeId);
				stmt2.setString(2, "%" + searchWord + "%");
		}
	}
	
	rs = stmt.executeQuery();
	rs2 = stmt2.executeQuery();
	rs2.next();
	// 조회된 전체 행 수 출력 확인
	System.out.println("전체 행의 수: " + rs2.getInt("cnt"));
			
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	while(rs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("rentalId", rs.getInt("rentalId"));
		map.put("inventoryId", rs.getInt("inventoryId"));
		map.put("rentalDate", rs.getString("rentalDate"));
		map.put("returnDate", rs.getString("returnDate"));
		map.put("customerId", rs.getInt("customerId"));
		map.put("name", rs.getString("name"));
		map.put("filmTitle", rs.getString("filmTitle"));
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
	<h1>Rental List</h1>
	<form action="/sakila/d0325/rentalList.jsp">
		Store
		<select name="storeId">
			<%
				if(storeId == 0) {
			%>
					<option value="0" selected>전체</option>
			<%
				} else {
			%>
					<option value="0">전체</option>
			<%
				}
			%>
			
			<%
				if(storeId == 1) {
			%>
					<option value="1" selected>1지점</option>
			<%
				} else {
			%>
					<option value="1">1지점</option>
			<%
				}
			%>
			
			<%
				if(storeId == 2) {
			%>
					<option value="2" selected>2지점</option>
			<%
				} else {
			%>
					<option value="2">2지점</option>
			<%
				}
			%>
		</select>
		 <!-- 검색어 유지 (hidden input) -->
    	<input type="hidden" name="searchWord" value="<%=searchWord%>">
		<button type="submit">검색</button>
	</form>
	
	<table border="1">
		<tr>
			<th>rentalId</th>
			<th>filmTitle</th>
			<th>inventoryId</th>
			<th>name(customerId)</th>
			<th>rentalDate</th>
			<th>returnDate</th>
		</tr>
		<%
			for(HashMap<String, Object> map : list) {
		%>
		<tr>
			<td><%=map.get("rentalId")%></td>
			<td><%=map.get("filmTitle")%></td>
			<td><%=map.get("inventoryId")%></td>
			<td><%=map.get("name")%>(<%=map.get("customerId")%>)</td>
			<td><%=map.get("rentalDate")%></td>
			<td><%=map.get("returnDate")%></td>
		</tr>
		<%
			}
		%>
	</table>
	
	<!-- filmTitle Search -->
	<form action="/sakila/d0325/rentalList.jsp">
		filmTitle SearchWord :
		<input type="text" name="searchWord" value="<%=searchWord%>">
		<button type="submit">검색</button>
		<!-- storeId 유지 (hidden input) -->
    	<input type="hidden" name="storeId" value="<%=storeId%>">
	</form>
	
	<!-- 페이징 -->
	<a href="/sakila/d0325/rentalList.jsp?searchWord=<%=searchWord%>&storeId=<%=storeId%>&currentPage=1">[처음]</a>
	<%
		if(startPage > 1) {
	%>
		<a href="/sakila/d0325/rentalList.jsp?searchWord=<%=searchWord%>&storeId=<%=storeId%>&currentPage=<%=startPage - 10%>">[이전 10페이지]</a>
	<%
		}
	%>
	
	<%
		if(currentPage > 1) {
	%>
		<a href="/sakila/d0325/rentalList.jsp?searchWord=<%=searchWord%>&storeId=<%=storeId%>&currentPage=<%=currentPage - 1%>">[이전]</a>
	<%
		}
	%>
	<!-- 페이지 번호 리스트 -->
	<%
		for(int i = startPage; i <= endPage; i++) {
			if(i == currentPage) {
	%>
				[<%=i%>]
	<%
			} else {
	%>
				<a href="/sakila/d0325/rentalList.jsp?searchWord=<%=searchWord%>&storeId=<%=storeId%>&currentPage=<%=i%>">[<%=i%>]</a>
	<%
			}
		}
	%>
	
	<%
		if(currentPage < lastPage) {
	%>
		<a href="/sakila/d0325/rentalList.jsp?searchWord=<%=searchWord%>&storeId=<%=storeId%>&currentPage=<%=currentPage + 1%>">[다음]</a>
	<%
		}
	%>
	
	<%
		if(endPage < lastPage) {
	%>
		<a href="/sakila/d0325/rentalList.jsp?searchWord=<%=searchWord%>&storeId=<%=storeId%>&currentPage=<%=startPage + 10%>">[다음 10페이지]</a>
	<%
		}
	%>
	<a href="/sakila/d0325/rentalList.jsp?searchWord=<%=searchWord%>&storeId=<%=storeId%>&currentPage=<%=lastPage%>">[끝으로]</a>
</body>
</html>