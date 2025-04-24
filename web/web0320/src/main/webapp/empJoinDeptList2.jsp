<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>empJoinDeptList2</title>
</head>
<body>
<%
	// Controller
	
	// Model
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select e.empno empno, e.ename ename, e.job job, e.mgr mgr, e.hiredate hiredate, e.sal sal, e.comm comm, e.deptno deptno, d.dname dname, d.loc loc from emp e inner join dept d on e.deptno = d.deptno";
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "goodee", "java1234");
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	while(rs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("empno", rs.getInt("empno"));
		map.put("ename", rs.getString("ename"));
		map.put("job", rs.getString("job"));
		map.put("mgr", rs.getInt("mgr"));
		map.put("hiredate", rs.getString("hiredate"));
		map.put("sal", rs.getInt("sal"));
		
		
		map.put("comm", rs.getInt("comm"));
		map.put("deptno", rs.getInt("deptno"));
		map.put("dname", rs.getString("dname"));
		map.put("loc", rs.getString("loc"));
		list.add(map);
	}
%>
	<!-- View -->
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
			<th>dname</th>
			<th>loc</th>
		</tr>
		<%
			for(HashMap<String, Object> map : list) {
		%>
				<tr>
					<td><%=map.get("empno")%></td>
					<td><%=map.get("ename")%></td>
					<td><%=map.get("job")%></td>
					<td><%=map.get("mgr")%></td>
					<td><%=map.get("hiredate")%></td>
					<td><%=map.get("sal")%></td>
					<td><%=map.get("comm")%></td>
					<td><%=map.get("deptno")%></td>
					<td><%=map.get("dname")%></td>
					<td><%=map.get("loc")%></td>
				</tr>
		<%
			}
		%>
	</table>
</body>
</html>