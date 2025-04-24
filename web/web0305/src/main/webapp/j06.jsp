<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>조건문</h1>
	<%
		int num = 9;
		int result = 0;
	
		if(num > 10) {
			result = result + num; // result += num;
		}
	%>
	<div>
		RESULT : <% out.print(result); %>
		<br>
		RESULT : <%=result%>
	</div>
	
	<%
		int num2 = 10;
		String str = "홀수";
		
		if(num2 % 2 == 0) {
			str = "짝수";
		}
	%>
	<div>
		str : <%=str%>
	</div>
	
	<%
		int score = 80;
		String scoreTable = "";
		if(score >= 90) {
			scoreTable = "A";
		} else if(score >= 80) {
			scoreTable = "B";
		} else if(score >= 70) {
			scoreTable = "C";
		} else {
			scoreTable = "F";
		}
	%>
	<div>
		scoreTable : <%=scoreTable%>
	</div>
</body>
</html>