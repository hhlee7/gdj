<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="dto.Emp" %>
<!-- controller 단 -->
<%
	String[] deptno = request.getParameterValues("deptno");
	System.out.println(deptno);
%>

<!-- model 단 -->
<%
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select * from emp";
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/xe", "goodee", "java1234");

	if(deptno == null) {
		stmt = conn.prepareStatement(sql);
	} else {
		if(deptno.length == 1) {
			sql = "select * from emp where deptno in (?)";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(deptno[0]));
		} else if(deptno.length == 2) {
			sql = "select * from emp where deptno in (?, ?)";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(deptno[0]));
			stmt.setInt(2, Integer.parseInt(deptno[1]));
		} else if(deptno.length == 3) {
			sql = "select * from emp where deptno in (?, ?, ?)";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(deptno[0]));
			stmt.setInt(2, Integer.parseInt(deptno[1]));
			stmt.setInt(3, Integer.parseInt(deptno[2]));
		}
	}
	
	
	
	rs = stmt.executeQuery();
	
	ArrayList<Emp> list = new ArrayList<>(); // rs -> list(모델)
	while(rs.next()) {
		Emp e = new Emp(); // rs의 한 행을 저장하는 타입
		e.empno = rs.getInt("empno");
		e.ename = rs.getString("ename");
		e.job = rs.getString("job");
		e.mgr = rs.getInt("mgr");
		e.hiredate = rs.getString("hiredate");
		e.sal = rs.getInt("sal");
		e.comm = rs.getInt("comm");
		e.deptno = rs.getInt("deptno");
		// 한 행의 데이터를 list에 추가 : rs의 1행을 list[0]로 복사, rs의 2행을 list[1]로 복사, ... while문이 끝나면 전체 행 복사
		list.add(e);
	}
%>

<!-- view 단 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>Emp List</h1>
	<table border="1">
		<tr>
			<th>empno</th>
			<th>ename</th>
			<th>job</th>
			<th>mgr</th>
			<th>hiredate</th>
			<th>sal</th>
			<th>comm</th>
			<th>deptno</th>
		</tr>
		<%
			for(Emp e : list) {
		%>
				<tr>
					<td><%=e.empno%></td>
					<td><%=e.ename%></td>
					<td><%=e.job%></td>
					<td><%=e.mgr%></td>
					<td><%=e.hiredate%></td>
					<td><%=e.sal%></td>
					<td><%=e.comm%></td>
					<td><%=e.deptno%></td>
				</tr>
		<%
			}
		%>
	</table>
	<form action="/web0320/empList.jsp">
		<input type="checkbox" name="deptno" value="1">1. Sales
		<input type="checkbox" name="deptno" value="2">2. Training
		<input type="checkbox" name="deptno" value="3">3. Services
		<button type="submit">검색</button>
	</form>
</body>
</html>