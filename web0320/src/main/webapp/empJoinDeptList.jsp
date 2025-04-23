<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="dto.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>empJoinDeptList</title>
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
	// DTO를 사용
	/*
		public class EmpAndDept {
			public Emp emp;
			public Dept dept;
		}
	*/
	
	ArrayList<EmpAndDept> list = new ArrayList<EmpAndDept>();
	// ArrayList<Hashmap<String, Object>> list = new ArrayList<Hashmap<String, Object>>(); 
	while(rs.next()) {
		EmpAndDept ead = new EmpAndDept();
		// Hashmap<String, Object> map = new Hashmap<String, Object>();
		ead.emp = new Emp();
		ead.dept = new Dept();
		ead.emp.empno = rs.getInt("empno"); // map.put("empno", rs.getInt("empno"))
		ead.emp.ename = rs.getString("ename");
		ead.emp.job = rs.getString("job");
		ead.emp.mgr = rs.getInt("mgr");
		ead.emp.hiredate = rs.getString("hiredate");
		ead.emp.sal = rs.getInt("sal");
		ead.emp.comm = rs.getInt("comm");
		ead.emp.deptno = rs.getInt("deptno");
		ead.dept.dname = rs.getString("dname");
		ead.dept.loc = rs.getString("loc");
		list.add(ead);
	}
%>
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
			for(EmpAndDept ead : list) { // for(Hashmap<String, Object> map : list)
		%>
				<tr>
					<td><%=ead.emp.empno%></td> <!-- map.get("empno") -->
					<td><%=ead.emp.ename%></td>
					<td><%=ead.emp.job%></td>
					<td><%=ead.emp.mgr%></td>
					<td><%=ead.emp.hiredate%></td>
					<td><%=ead.emp.sal%></td>
					<td><%=ead.emp.comm%></td>
					<td><%=ead.emp.deptno%></td>
					<td><%=ead.dept.dname%></td>
					<td><%=ead.dept.loc%></td>
				</tr>
		<%
			}
		%>
	</table>
</body>
</html>