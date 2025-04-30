<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));

	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select board_no boardNo, board_title boardTitle, board_content boardContent, board_writer boardWriter, board_pw boardPw from board where board_no = ?";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0317", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, boardNo);
	System.out.println(stmt);
	rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>BoardUpdateForm</h1>
	<%
		if(rs.next()) {			
	%>
			<form action="/web0317/updateBoardAction.jsp">
				<table border="1">
					<tr>
						<th>boardNo</th>
						<td><input type="number" name="boardNo" value="<%=boardNo%>" readonly></td>
					</tr>
					<tr>
						<th>boardTitle</th>
						<td><input type="text" name="boardTitle" value='<%=rs.getString("boardTitle")%>'></td>
					</tr>
					<tr>
						<th>boardContent</th>
						<td><textarea rows="5" cols="50" name="boardContent"><%=rs.getString("boardContent")%></textarea></td>
					</tr>
					<tr>
						<th>boardWriter</th>
						<td><input type="text" name="boardWriter" value='<%=rs.getString("boardWriter")%>'></td>
					</tr>
					<tr>
						<th>boardPw</th>
						<td><input type="password" name="boardPw"></td>
					</tr>
				</table>
				<button type="submit">등록</button>
			</form>
	<%
		}
	%>
</body>
</html>