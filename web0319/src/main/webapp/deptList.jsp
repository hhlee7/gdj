<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dto.Dept" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select deptno, dname, loc from dept order by deptno";
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/xe", "goodee", "java1234");
				
		stmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		System.out.println("deptList.jsp stmt: " + stmt);
		rs = stmt.executeQuery();
		// 비지니스(목적) 코드 -> 결과물(값)을 "모델(값)"
		// 외부 API에 의존하는 모델값(타입)을 일반적인(기본) 타입의 모델값(배열)으로 치환
		
		// rs의 사이즈를 알아야 함
		int rsSize = 0;
		while(rs.next()) {
			rsSize += 1;
		}
		
		Dept[] arr = new Dept[rsSize];
		
		// rs -> arr
		rs.beforeFirst();
		int i = 0;
		while(rs.next()) {
			Dept d = new Dept();
			d.deptno = rs.getInt("deptno");
			d.dname = rs.getString("dname");
			d.loc = rs.getString("loc");
			
			arr[i] = d;
			i += 1;
		}
		// 모델 --> arr
	%>
	
	<!-- 모델값 출력 코드는 "뷰" -->
	<h1>Dept List</h1>
	<table border="1">
		<tr>
			<th>deptno</th>
			<th>dname</th>
			<th>loc</th>
			<th>update</th>
			<th>delete</th>
		</tr>
		<%
			for(Dept d : arr) {
		%>
				<tr>
					<td><%=d.deptno%></td>
					<td><%=d.dname%></td>
					<td><%=d.loc%></td>
					<td><a href="updateDeptForm.jsp?deptno=<%=d.deptno%>">수정</a>
					<td><a href="deleteDeptAction.jsp?deptno=<%=d.deptno%>">삭제</a>
				</tr>
		<%		
			}
		%>
	</table>
	<div>
		<a href="/web0319/insertDeptForm.jsp">부서 추가</a>
	</div>
</body>
</html>