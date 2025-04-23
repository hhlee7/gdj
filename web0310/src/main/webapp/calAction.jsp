<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bo.CalBox"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		double result = 0;
		int num1 = Integer.parseInt(request.getParameter("num1"));
		int num2 = Integer.parseInt(request.getParameter("num2"));
		
		String op = request.getParameter("op");
		
		if(op.equals("add")) {
			// result = num1 + num2;
			result = CalBox.add(num1, num2);
		} else if(op.equals("subtraction")) {
			// result = num1 - num2;			
			result = CalBox.subtraction(num1, num2);
		} else if(op.equals("multiplication")) {
			// result = num1 * num2;			
			result = CalBox.multiplication(num1, num2);
		} else if(op.equals("division")) {
			// result = (double)num1 / (double)num2;
			result = CalBox.division(num1, num2);
		}
	%>
	<div>
		계산 결과 : <%=result%>
	</div>
</body>
</html>