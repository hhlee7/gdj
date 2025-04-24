<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>for문을 이용한 계산</h1>
	<%
		// 1 ~ 100까지 합
		int total = 0;
		for(int i = 1; i < 101; i = i + 1) { // i = 1 ~ i = 10
			total = total + i; // total += i;
		}
	%>
	<div>total : <%=total%></div>
	
	<%
		// 1 ~ 100까지 곱
		double mul = 1;
		for(double i = 1; i < 101; i = i + 1) {
			mul = mul * i; // mul *= i;
		}
	%>
	<div>mul : <%=mul%></div>
	
	<h1>for문 안에 if문을 중첩</h1>
	<%
		// 1 ~ 10 짝수만 출력
		for(int i = 2; i <= 10; i = i + 2) { // 요구 사항을 지키지 못한 경우
	%>
				<%=i%>&nbsp;
	<%
		}
	%>
	
	<br>
	<%
		for(int i = 1; i <= 10; i = i + 1) {
			if(i % 2 == 0) {
	%>
				<%=i%>&nbsp;
	<%
			} else {
				
			}
		}
	%>
	
	<br>
	<%
		for(int i = 1; i <= 10; i = i + 1) {
			if(i % 2 == 1) {
				continue;
			}
	%>
				<%=i%>&nbsp;
	<%
			}
	%>
</body>
</html>