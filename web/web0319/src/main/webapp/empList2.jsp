<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="dto.Emp" %>
<!-- controller 단 -->
<%
	int searchNumberFirst = 0;
	String numberFirst = request.getParameter("numberFirst");
	// numberFirst 값 넘어오는지 확인
	System.out.println("numberFirst: " + numberFirst);
	
	if(numberFirst == null || numberFirst == "") { // 첫 번째 입력 값 : null or ""
		searchNumberFirst = 0;
	} else {
		searchNumberFirst = Integer.parseInt(numberFirst);
	}
	
	int searchNumberLast = 0;
	String numberLast = request.getParameter("numberLast");
	// numberLast 값 넘어오는지 확인
	System.out.println("numberLast: " + numberLast);
	
	if(numberLast == null || numberLast == "") { // 두 번째 입력 값 : null or ""
		searchNumberLast = 0;
	} else {
		searchNumberLast = Integer.parseInt(numberLast);
	}
%>

<!-- model 단 -->
<%
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select * from emp";
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/xe", "goodee", "java1234");
	
	if(searchNumberFirst == 0 && searchNumberLast == 0) { // 입력 값 모두 없을 때
		stmt = conn.prepareStatement(sql);
	} else if(searchNumberFirst != 0 && searchNumberLast == 0) { // 첫 번째 입력 값만 있을 때
		sql = "select * from emp where empno >= ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, searchNumberFirst);
	} else { // 두 번째 입력 값만 있거나 입력 값 모두 있을 때
		sql = "select * from emp where empno >= ? and empno <= ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, searchNumberFirst);
		stmt.setInt(2, searchNumberLast);
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
	<form action="/web0319/empList2.jsp">
		<input type="number" name="numberFirst">이상 <input type="number" name="numberLast">이하
		<button type="submit">번호 검색</button>
	</form>
</body>
</html>