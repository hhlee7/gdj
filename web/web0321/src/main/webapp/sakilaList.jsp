<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sakilaList</title>
</head>
<body>
<!-- Controller -->
<%
	String searchWord = request.getParameter("searchWord");
	String searchCountry = request.getParameter("searchCountry");
	// 전달된 searchWord 값 확인
	System.out.println("searchWord: " + searchWord);
	
	if(searchWord == null) {
		searchWord = "";
	}
	if(searchCountry == null) {
		searchCountry = "";
	}
	
	// 페이징 설정
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10; // 페이지 당 출력할 행 개수
	int startRow = (currentPage - 1) * rowPerPage;
%>

<!-- Model -->
<%
	// 드라이버 로딩
	Class.forName("com.mysql.cj.jdbc.Driver");
	System.out.println("드라이버 로딩 성공");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql;
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	String sql2 = "select count(*) cnt"
				+ " FROM customer cs INNER JOIN address ad ON cs.address_id = ad.address_id"
				+ " INNER JOIN city ct ON ad.city_id = ct.city_id"
				+ "	INNER JOIN country cn ON ct.country_id = cn.country_id";
	
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");
	// 검색 없을 시
		if(searchWord.equals("") && searchCountry.equals("")) {
			sql = "select cs.customer_id customerId"
				+ ", CONCAT(cs.first_name, ' ', cs.last_name) customerName"
				+ ", cs.email email"
				+ ", cs.address_id addressId"
				+ ", ad.address address"
				+ ", ad.district district"
				+ ", ad.city_id cityId"
				+ ", ct.city city"
				+ ", cn.country_id countryId"
				+ ", cn.country country"
				+ " FROM customer cs INNER JOIN address ad ON cs.address_id = ad.address_id"
				+ " INNER JOIN city ct ON ad.city_id = ct.city_id"
				+ "	INNER JOIN country cn ON ct.country_id = cn.country_id"
				+ " ORDER BY cs.customer_id ASC"
				+ " limit ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
			stmt2 = conn.prepareStatement(sql2);
	// 이름만 검색 시
		} else if(!searchWord.equals("") && searchCountry.equals("")) {
			sql = "select cs.customer_id customerId"
				+ ", CONCAT(cs.first_name, ' ', cs.last_name) customerName"
				+ ", cs.email email"
				+ ", cs.address_id addressId"
				+ ", ad.address address"
				+ ", ad.district district"
				+ ", ad.city_id cityId"
				+ ", ct.city city"
				+ ", cn.country_id countryId"
				+ ", cn.country country"
				+ " FROM customer cs INNER JOIN address ad ON cs.address_id = ad.address_id"
				+ " INNER JOIN city ct ON ad.city_id = ct.city_id"
				+ "	INNER JOIN country cn ON ct.country_id = cn.country_id"
				+ " where CONCAT(cs.first_name, ' ', cs.last_name) LIKE ?"
				+ " ORDER BY cs.customer_id ASC"
				+ " limit ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + searchWord + "%");
			stmt.setInt(2, startRow);
			stmt.setInt(3, rowPerPage);
			sql2 = "select count(*) cnt"
				+ " FROM customer cs INNER JOIN address ad ON cs.address_id = ad.address_id"
				+ " INNER JOIN city ct ON ad.city_id = ct.city_id"
				+ "	INNER JOIN country cn ON ct.country_id = cn.country_id"
				+ " where CONCAT(cs.first_name, ' ', cs.last_name) LIKE ?";
			stmt2 = conn.prepareStatement(sql2);
			stmt2.setString(1, "%" + searchWord + "%");
	// 국가만 검색 시
		} else if(searchWord.equals("") && !searchCountry.equals("")) {
			sql = "select cs.customer_id customerId"
				+ ", CONCAT(cs.first_name, ' ', cs.last_name) customerName"
				+ ", cs.email email"
				+ ", cs.address_id addressId"
				+ ", ad.address address"
				+ ", ad.district district"
				+ ", ad.city_id cityId"
				+ ", ct.city city"
				+ ", cn.country_id countryId"
				+ ", cn.country country"
				+ " FROM customer cs INNER JOIN address ad ON cs.address_id = ad.address_id"
				+ " INNER JOIN city ct ON ad.city_id = ct.city_id"
				+ "	INNER JOIN country cn ON ct.country_id = cn.country_id"
				+ " where country LIKE ?"
				+ " ORDER BY cs.customer_id ASC"
				+ " limit ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + searchCountry + "%");
			stmt.setInt(2, startRow);
			stmt.setInt(3, rowPerPage);
			sql2 = "select count(*) cnt"
				+ " FROM customer cs INNER JOIN address ad ON cs.address_id = ad.address_id"
				+ " INNER JOIN city ct ON ad.city_id = ct.city_id"
				+ "	INNER JOIN country cn ON ct.country_id = cn.country_id"
				+ " where country LIKE ?";
			stmt2 = conn.prepareStatement(sql2);
			stmt2.setString(1, "%" + searchCountry + "%");
	// 이름과 국가 모두 검색 시
		} else {
			sql = "select cs.customer_id customerId"
				+ ", CONCAT(cs.first_name, ' ', cs.last_name) customerName"
				+ ", cs.email email"
				+ ", cs.address_id addressId"
				+ ", ad.address address"
				+ ", ad.district district"
				+ ", ad.city_id cityId"
				+ ", ct.city city"
				+ ", cn.country_id countryId"
				+ ", cn.country country"
				+ " FROM customer cs INNER JOIN address ad ON cs.address_id = ad.address_id"
				+ " INNER JOIN city ct ON ad.city_id = ct.city_id"
				+ "	INNER JOIN country cn ON ct.country_id = cn.country_id"
				+ " where CONCAT(cs.first_name, ' ', cs.last_name) LIKE ? and country LIKE ?"
				+ " ORDER BY cs.customer_id ASC"
				+ " limit ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + searchWord + "%");
			stmt.setString(2, "%" + searchCountry + "%");
			stmt.setInt(3, startRow);
			stmt.setInt(4, rowPerPage);
			sql2 = "select count(*) cnt"
				+ " FROM customer cs INNER JOIN address ad ON cs.address_id = ad.address_id"
				+ " INNER JOIN city ct ON ad.city_id = ct.city_id"
				+ "	INNER JOIN country cn ON ct.country_id = cn.country_id"
				+ " where CONCAT(cs.first_name, ' ', cs.last_name) LIKE ? and country LIKE ?";
			stmt2 = conn.prepareStatement(sql2);
			stmt2.setString(1, "%" + searchWord + "%");
			stmt2.setString(2, "%" + searchCountry + "%");
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
	
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	while(rs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("customerId", rs.getInt("customerId"));
		map.put("customerName", rs.getString("customerName"));
		map.put("email", rs.getString("email"));
		map.put("addressId", rs.getInt("addressId"));
		map.put("address", rs.getString("address"));
		map.put("district", rs.getString("district"));
		map.put("cityId", rs.getInt("cityId"));
		map.put("city", rs.getString("city"));
		map.put("countryId", rs.getInt("countryId"));
		map.put("country", rs.getString("country"));
		list.add(map);
	}
	
%>
	<!-- View -->
	<h1>sakilaList</h1>
	<table border="1">
		<tr>
			<th>customerId</th>
			<th>customerName</th>
			<th>email</th>
			<th>addressId</th>
			<th>address</th>
			<th>district</th>
			<th>cityId</th>
			<th>city</th>
			<th>countryId</th>
			<th>country</th>
		</tr>
		<%
			for(HashMap<String, Object> map : list) {
		%>
				<tr>
					<td><%=map.get("customerId")%></td>
					<td><%=map.get("customerName")%></td>
					<td><%=map.get("email")%></td>
					<td><%=map.get("addressId")%></td>
					<td><%=map.get("address")%></td>
					<td><%=map.get("district")%></td>
					<td><%=map.get("cityId")%></td>
					<td><%=map.get("city")%></td>
					<td><%=map.get("countryId")%></td>
					<td><%=map.get("country")%></td>
				</tr>
		<%
			}
		%>
	</table>
	<!-- 페이징 -->
	<a href="/web0321/sakilaList.jsp?searchWord=<%=searchWord%>&searchCountry=<%=searchCountry%>&currentPage=1">[처음]</a>	
	<%
		if(currentPage > 1) {
	%>
			<a href="/web0321/sakilaList.jsp?searchWord=<%=searchWord%>&searchCountry=<%=searchCountry%>&currentPage=<%=currentPage - 1%>">[이전]</a>
	<%
		}
	%>
	
	<%=currentPage%>
	
	<%
		if(currentPage < lastPage) {
	%>
			<a href="/web0321/sakilaList.jsp?&searchWord=<%=searchWord%>&searchCountry=<%=searchCountry%>&currentPage=<%=currentPage + 1%>">[다음]</a>			
	<%
		}
	%>
	<a href="/web0321/sakilaList.jsp?&searchWord=<%=searchWord%>&searchCountry=<%=searchCountry%>&currentPage=<%=lastPage%>">[마지막]</a>
	<form action="/web0321/sakilaList.jsp">
		<div>이름 검색
		<input type="text" name="searchWord">
		<button type="submit">검색</button>
		</div>
		<div>국가 검색
		<input type="text" name="searchCountry">
		<button type="submit">검색</button>
		</div>
	</form>
</body>
</html>