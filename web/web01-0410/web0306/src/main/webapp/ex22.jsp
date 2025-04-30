<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String name = request.getParameter("name");
	String pw = request.getParameter("pw");
	String age = request.getParameter("age");
	// int numAge = Integer.parseInt("age");
	String birth = request.getParameter("birth");
	String favoriteColor = request.getParameter("favoriteColor");
	String starPoint = request.getParameter("starPoint");
	String gender = request.getParameter("gender");
	String classroom = request.getParameter("classroom");
	
	// 동일한 name값 여러개를 한 번에 받는 방법
	String[] hobby = request.getParameterValues("hobby");
%>
	
	<!-- 출력 화면 -->
	<table>
		<tr>
			<td>name</td>
			<td><%=name%></td>
		</tr>
		<tr>
			<td>pw</td>
			<td><%=pw%></td>
		</tr>
		<tr>
			<td>age</td>
			<td><%=age%></td>
		</tr>
		<tr>
			<td>birth</td>
			<td><%=birth%></td>
		</tr>
		<tr>
			<td>favoriteColor</td>
			<td><%=favoriteColor%></td>
		</tr>
		<tr>
			<td>starPoint</td>
			<td><%=starPoint%></td>
		</tr>
		<tr>
			<td>gender</td>
			<td><%=gender%></td>
		</tr>
		<tr>
			<td>classroom</td>
			<td><%=classroom%></td>
		</tr>
		<tr>
			<td>hobby</td>
			<td><%=hobby[0]%>, <%=hobby[1]%>, <%=hobby[2]%></td>
		</tr>
	</table>
</body>
</html>