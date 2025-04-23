<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	System.out.println("num: " + num);
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select num, category, title, content, age from qna where num = ?";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0313", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, num);
	System.out.println(stmt);
	rs = stmt.executeQuery();
	// rs.next(); -> 무조건 커스 한 줄 이동
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>QnA 수정</h1>
	<%
		// 좀 더 안전하게 데이터가 있을때만 form 출력
		if(rs.next()) {
	%>
	<form action="/web0313/updateQnaAction.jsp">
		<table border="1">
			<tr>
				<th>NUM</th>
				<td><input type="text" name="num" value='<%=rs.getInt("num")%>' readonly></td>
			</tr>
			<tr>
				<th>CATEGORY</th>
				<td>
					<select name="category">
						<%
							if(rs.getString("category").equals("상품")) {
						%>								
						<option value="상품" selected>상품</option>
						<%
							} else {
						%>
						<option value="상품">상품</option>
						<%
							}
						%>
						
						<%
							if(rs.getString("category").equals("주문")) {
						%>								
						<option value="주문" selected>주문</option>
						<%
							} else {
						%>
						<option value="주문">주문</option>
						<%
							}
						%>
						
						<%
							if(rs.getString("category").equals("배달")) {
						%>								
						<option value="배달" selected>배달</option>
						<%
							} else {
						%>
						<option value="배달">배달</option>
						<%
							}
						%>
						
						<%
							if(rs.getString("category").equals("기타")) {
						%>								
						<option value="기타" selected>기타</option>
						<%
							} else {
						%>
						<option value="기타">기타</option>
						<%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<th>TITLE</th>
				<td><input type="text" name="title" value='<%=rs.getString("title")%>'></td>
			</tr>
			<tr>
				<th>CONTENT</th>
				<td><textarea rows="5" cols="50" name="content"><%=rs.getString("content")%></textarea></td>
			</tr>
			<tr>
				<th>AGE</th>
				<td><input type="number" name="age" min="0" step="10" value='<%=rs.getString("age")%>'></td>
			</tr>
			<tr>
				<th>PW</th>
				<td><input type="password" name="pw"></td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
	<%
		}
	%>
</body>
</html>