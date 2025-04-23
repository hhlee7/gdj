<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));

	// boardNo 값 들어오는지 확인
	System.out.println("boardNo: " + boardNo);

	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select board_no boardNo, board_title boardTitle, board_content boardContent, board_writer boardWriter, board_pw boardPw, updatedate, createdate from board where board_no = ?";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0317", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, boardNo);
	// stmt / 쿼리 완성됨을 확인
	System.out.println(stmt);
	
	// rs / 쿼리 실행 후 결과 확인
	rs = stmt.executeQuery();
	System.out.println("rs: " + rs);
	
	// commentList	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	String sql2 = "select comment_no commentNo, board_no boardNo, comment_content commentContent, comment_writer commentWriter, createdate from comment where board_no = ? order by comment_no desc";
	
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, boardNo);
	System.out.println(stmt2);
	
	rs2 = stmt2.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>boardOne</h1>
	<%
		if(rs.next()) {			
	%>
			<table border="1">
				<tr>
					<th>boardNo</th>
					<td><%=rs.getInt("boardNo")%></td>
				</tr>
				<tr>
					<th>boardTitle</th>
					<td><%=rs.getString("boardTitle")%></td>
				</tr>
				<tr>
					<th>boardContent</th>
					<td><%=rs.getString("boardContent")%></td>
				</tr>
				<tr>
					<th>boardWriter</th>
					<td><%=rs.getString("boardWriter")%></td>
				</tr>
				<tr>
					<th>updatedate</th>
					<td><%=rs.getString("updatedate")%></td>
				</tr>
				<tr>
					<th>createdate</th>
					<td><%=rs.getString("createdate")%></td>
				</tr>
			</table>
			<a href="/web0317/deleteBoardForm.jsp?boardNo=<%=boardNo%>">글삭제</a>
			<a href="/web0317/updateBoardForm.jsp?boardNo=<%=boardNo%>">글수정</a>
	<%
		}
	%>
	
	<hr>
	<h1>insert Comment</h1>
	<form action="/web0317/insertCommentAction.jsp">
		<input type="hidden" name="boardNo" value="<%=boardNo%>">
		<table border="1">
			<tr>
				<th>commentContent</th>
				<td><textarea rows="2" cols="50" name="commentContent"></textarea></td>
			</tr>		
			<tr>
				<th>commentWriter</th>
				<td><input type="text" name="commentWriter"></td>
			</tr>		
			<tr>
				<th>commentPw</th>
				<td><input type="password" name="commentPw"></td>
			</tr>
		</table>
		<button type="submit">댓글 입력</button>
	</form>
	
	<hr>
	<h1>Comment List</h1>
	<table border="1">
	<%
		while(rs2.next()) {
	%>
			<tr>
				<td><%=rs2.getInt("commentNo")%></td>
				<td><%=rs2.getString("commentContent")%></td>
				<td><%=rs2.getString("commentwriter")%></td>
				<td><%=rs2.getString("createdate")%></td>
				<td><a href='/web0317/deleteCommentForm.jsp?boardNo=<%=boardNo%>&commentNo=<%=rs2.getInt("commentNo")%>'>댓글 삭제</a></td>
			</tr>
	<%		
		}
	%>
	</table>
</body>
</html>