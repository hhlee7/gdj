<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!-- Controller -->
<%
	
	int searchNumber = 0;
	if(request.getParameter("searchNumber") != null && !request.getParameter("searchNumber").isEmpty()) {
		searchNumber = Integer.parseInt(request.getParameter("searchNumber"));
	}
	// 전달된 searchNumber 값 확인
	System.out.println("searchNumber: " + searchNumber);
	
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
	String sql2 = "SELECT count(*) cnt"
				+ " FROM (SELECT i.film_id, t.sumAmount"
				+ " FROM (SELECT r.inventory_id, sum(p.amount) sumAmount"
				+ " FROM rental r INNER JOIN payment p"
				+ " ON r.rental_id = p.rental_id"
				+ " GROUP BY r.inventory_id) t INNER JOIN inventory i"
				+ " ON t.inventory_id = i.inventory_id) t2 INNER JOIN film f"
				+ " ON t2.film_id = f.film_id";
	
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");
	System.out.println(conn);
	
	// 매출액 검색 없을 시
	if(searchNumber == 0) {
		sql = "SELECT f.title title, t2.sumAmount sumAmount"
			+ " FROM (SELECT i.film_id, t.sumAmount"
			+ " FROM (SELECT r.inventory_id, sum(p.amount) sumAmount"
			+ " FROM rental r INNER JOIN payment p"
			+ " ON r.rental_id = p.rental_id"
			+ " GROUP BY r.inventory_id) t INNER JOIN inventory i"
			+ " ON t.inventory_id = i.inventory_id) t2 INNER JOIN film f"
			+ " ON t2.film_id = f.film_id"
			+ " ORDER BY t2.sumAmount DESC"
			+ " limit ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		stmt2 = conn.prepareStatement(sql2);
	// 매출액 검색 있을 시
	} else {
		sql = "SELECT f.title title, t2.sumAmount sumAmount"
				+ " FROM (SELECT i.film_id, t.sumAmount"
				+ " FROM (SELECT r.inventory_id, sum(p.amount) sumAmount"
				+ " FROM rental r INNER JOIN payment p"
				+ " ON r.rental_id = p.rental_id"
				+ " GROUP BY r.inventory_id) t INNER JOIN inventory i"
				+ " ON t.inventory_id = i.inventory_id) t2 INNER JOIN film f"
				+ " ON t2.film_id = f.film_id"
				+ " where sumAmount >= ?"
				+ " ORDER BY t2.sumAmount DESC"
				+ " limit ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, searchNumber);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		sql2 = "SELECT count(*) cnt"
			+ " FROM (SELECT i.film_id, t.sumAmount"
			+ " FROM (SELECT r.inventory_id, sum(p.amount) sumAmount"
			+ " FROM rental r INNER JOIN payment p"
			+ " ON r.rental_id = p.rental_id"
			+ " GROUP BY r.inventory_id) t INNER JOIN inventory i"
			+ " ON t.inventory_id = i.inventory_id) t2 INNER JOIN film f"
			+ " ON t2.film_id = f.film_id"
			+ " where sumAmount >= ?";
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, searchNumber);
	}
	
	rs = stmt.executeQuery();
	
	rs2 = stmt2.executeQuery();
	rs2.next();
	// 조회된 전체 행 수 출력 확인
	System.out.println("전체 행의 수: " + rs2.getInt("cnt"));
	
	// 페이징 - 마지막 페이지 설정
		int totalCnt = rs2.getInt("cnt");
		int lastPage = totalCnt / rowPerPage;
		if(totalCnt % rowPerPage != 0) {
			lastPage += 1;
		}
		if(endPage > lastPage) {
			endPage = lastPage;
		}
	
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	while(rs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("title", rs.getString("title"));
		map.put("sumAmount", rs.getString("sumAmount"));
		list.add(map);
	}
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>amoutList</title>
</head>
<body>
	<h1>amoutList</h1>
	<table border="1">
		<tr>
			<th>title</th>
			<th>sumAmount</th>
		</tr>
		<%
			for(HashMap<String, Object> map : list) {
		%>
		<tr>
			<td><%=map.get("title")%></td>
			<td><%=map.get("sumAmount")%></td>
		</tr>
		<%
			}
		%>
	</table>
	<!-- 매출액 검색 -->
	<form action="/web0324/amountList.jsp">
		<%
			if(searchNumber != 0) {
		%>
		매출액 <input type="number" name="searchNumber" value="<%=searchNumber%>"> 이상
		<%
			} else {
		%>
		매출액 <input type="number" name="searchNumber"> 이상
		<%
			}
		%>
		<button type="submit">검색</button>
	</form>
	<!-- 페이징 -->
	<a href="/web0324/amountList.jsp?searchNumber=<%=searchNumber%>&currentPage=1">[처음]</a>
	<%
		if(currentPage > 1) {
	%>
	<a href="/web0324/amountList.jsp?searchNumber=<%=searchNumber%>&currentPage=<%=currentPage - 1%>">[이전]</a>
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
				<a href="/web0324/amountList.jsp?searchNumber=<%=searchNumber%>&currentPage=<%=i%>">[<%=i%>]</a>
	<%
			}
		}
	%>
	
	<%
		if(currentPage < lastPage) {
	%>
	<a href="/web0324/amountList.jsp?searchNumber=<%=searchNumber%>&currentPage=<%=currentPage + 1%>">[다음]</a>
	<%
		}
	%>
	<a href="/web0324/amountList.jsp?searchNumber=<%=searchNumber%>&currentPage=<%=lastPage%>">[끝으로]</a>
</body>
</html>