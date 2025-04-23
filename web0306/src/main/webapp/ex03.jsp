<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>주사위 게임</h1>
	
	<%
		int num = (int)(Math.random() * 5 + 1);
		System.out.println(num); // 1 ~ 6 -> 디버깅 코드 -> 로그
	%>
	
	<!-- HTML 주석 -->
	<%-- JSP 주석 --%>
	<% // JAVA 주석 %>
	<% /* JAVA 주석 */ %>
	
	<!-- 스크립트로 출력 -->
	<%
		out.print(10 + 7);
	%>
	<!-- 표현식으로 표현하면 -->
	<%=10 + 7%>
	
	<div>
		<%
			if(num == 1) {
		%>
				<img src="/web0306/image/one.jpg" width="200" height="200">
		<%
			} else if(num == 2) {
		%>
				<img src="/web0306/image/two.jpg" width="200" height="200">
		<%
			} else if(num == 3) {
		%>
				<img src="/web0306/image/three.jpg" width="200" height="200">
		<%
			} else if(num == 4) {
		%>
				<img src="/web0306/image/four.jpg" width="200" height="200">
		<%
			} else if(num == 5) {
		%>
				<img src="/web0306/image/five.jpg" width="200" height="200">
		<%
			} else {
		%>
				<img src="/web0306/image/six.jpg" width="200" height="200">
		<%
			}
		%>
	</div>
</body>
</html>