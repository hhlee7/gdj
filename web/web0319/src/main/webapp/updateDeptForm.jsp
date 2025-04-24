<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	int deptno = Integer.parseInt(request.getParameter("deptno"));
	System.out.println("insertDeptAction.jsp deptno: " + deptno);
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select deptno, dname, loc from dept where deptno = ?";
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/xe", "goodee", "java1234");
	
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, deptno);
	System.out.println("deleteDeptAction.jsp stmt: " + stmt);
	
	rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>updateDeptForm</h1>
		<%
			if(rs.next()) {
		%>
			<form action="updateDeptAction.jsp">
				<table border="1">
					<tr>
						<th>deptno</th>
						<td><input type="number" name="deptno" value="<%=deptno%>"></td>
					</tr>
					<tr>
						<th>dname</th>
						<td><input type="text" name="dname" value='<%=rs.getString("dname")%>'></td>
					</tr>
					<tr>
						<th>loc</th>
						<td><input type="text" name="loc" value='<%=rs.getString("loc")%>'></td>
					</tr>
				</table>
				<button type="submit">부서 수정</button>
			</form>
		<%
			}
		%>
</body>
</html>