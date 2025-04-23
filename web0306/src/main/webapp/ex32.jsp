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
		String color = request.getParameter("color");
		System.out.println("name: " + name);
		System.out.println("color: " + color);
		
		String msg = "";
		
		if(color.equals("blue")) {
			msg = "파란색";
		} else if(color.equals("red")) {
			msg = "붉은색";
		} else if(color.equals("orange")) {
			msg = "오렌지색";
		} else {
			msg = "기타";
		}
	%>
		<div>
			이름 : <%=name%>
		<div>
		</div>
			좋아하는 색깔은 <%=msg%> 입니다.
		</div>
</body>
</html>