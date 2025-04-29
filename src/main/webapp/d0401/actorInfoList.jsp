<%@page import="java.util.ArrayList"%>
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
	int rowPerPage = 5; // 페이지 당 보여줄 행 개수
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
	String sql = "SELECT t.actor_id actorId, t.first_name firstName, t.last_name lastName, GROUP_CONCAT(t.film_info SEPARATOR '; ') filmInfo"
				+ " FROM (SELECT fa.actor_id, a.first_name, a.last_name, CONCAT(c.name, ': ', group_concat(f.title ORDER BY f.title SEPARATOR ', ')) film_info"
				+ " FROM film_category fc INNER JOIN film f ON fc.film_id = f.film_id"
				+ " INNER JOIN category c ON fc.category_id = c.category_id"
				+ " INNER JOIN film_actor fa ON fc.film_id = fa.film_id"
				+ " INNER JOIN actor a ON fa.actor_id = a.actor_id"
				+ " GROUP BY fa.actor_id, c.name) t"
				+ " GROUP BY t.actor_id, t.first_name, t.last_name"
				+ " ORDER BY t.actor_id asc"
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
				+ " from (SELECT t.actor_id actorId, t.first_name firstName, t.last_name lastName, GROUP_CONCAT(t.film_info SEPARATOR '; ') filmInfo"
				+ " from (SELECT fa.actor_id, a.first_name, a.last_name, CONCAT(c.name, ': ', group_concat(f.title ORDER BY f.title SEPARATOR ', ')) film_info"
				+ " FROM film_category fc INNER JOIN film f ON fc.film_id = f.film_id"
				+ " INNER JOIN category c ON fc.category_id = c.category_id"
				+ " INNER JOIN film_actor fa ON fc.film_id = fa.film_id"
				+ " INNER JOIN actor a ON fa.actor_id = a.actor_id"
				+ " GROUP BY fa.actor_id, c.name) t"
				+ " GROUP BY t.actor_id, t.first_name, t.last_name"
				+ " ORDER BY t.actor_id ASC) t2";
	stmt2 = conn.prepareStatement(sql2);
	
	// 완성된 쿼리 확인용 출력
	System.out.println("actorInfoList.jsp stmt: " + stmt);
	System.out.println("actorInfoList.jsp stmt2: " + stmt2);
	
	rs = stmt.executeQuery();
	rs2 = stmt2.executeQuery();
	rs2.next();
	// 조회된 전체 행 수 확인용 출력
	System.out.println("actorInfoList.jsp cnt: " + rs2.getInt("cnt"));
	
	// ResultSet에서 각 행의 데이터를 꺼내어 Map에 저장하고, 이를 list에 추가
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	while(rs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("actorId", rs.getInt("actorId"));
		map.put("firstName", rs.getString("firstName"));
		map.put("lastName", rs.getString("lastName"));
		map.put("filmInfo", rs.getString("filmInfo"));
		list.add(map);
	}
	
	// 페이징 - 마지막 페이지 설정
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
	<div>
		<%=staffId%>님, 반갑습니다.
		<a href="/sakila/index.jsp">[대시보드로 이동]</a>
	</div>
	<hr>
	<h1>Actor Info</h1>
	
	<!-- actorInfoList 각 행 데이터 출력 -->
	<table border="1">
				<tr>
					<th>actorId</th>
					<th>firstName</th>
					<th>lastName</th>
					<th>filmInfo</th>
				</tr>
		<%
			for(HashMap<String, Object> map : list) {
		%>
				<tr>
					<td><%=map.get("actorId")%></td>
					<td><%=map.get("firstName")%></td>
					<td><%=map.get("lastName")%></td>
					<td><%=map.get("filmInfo")%></td>
				</tr>
		<%
			}
		%>
	</table>
	
	<!-- 페이징 -->
	<a href="/sakila/d0401/actorInfoList.jsp?currentPage=1">[처음]</a>
	<%
		if(startPage > 1) {
	%>
			<a href="/sakila/d0401/actorInfoList.jsp?currentPage=<%=startPage - 10%>">[이전 10페이지]</a>
	<%
		}
	%>
	
	<%
		if(currentPage > 1) {
	%>
			<a href="/sakila/d0401/actorInfoList.jsp?currentPage=<%=currentPage - 1%>">[이전]</a>
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
				<a href="/sakila/d0401/actorInfoList.jsp?currentPage=<%=i%>">[<%=i%>]</a>
	<%
			}
		}
	%>
	
	<%
		if(currentPage < lastPage) {
	%>
			<a href="/sakila/d0401/actorInfoList.jsp?currentPage=<%=currentPage + 1%>">[다음]</a>
	<%
		}
	%>
	
	<%
		if(endPage < lastPage) {
	%>
			<a href="/sakila/d0401/actorInfoList.jsp?currentPage=<%=startPage + 10%>">[다음 10페이지]</a>
	<%
		}
	%>
	<a href="/sakila/d0401/actorInfoList.jsp?currentPage=<%=lastPage%>">[마지막]</a>
</body>
</html>