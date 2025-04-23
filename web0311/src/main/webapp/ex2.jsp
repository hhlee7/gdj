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
	// 65 ~ 90 : A ~ Z
	// 97 ~ 122 : a ~ z
	
	// 임의의 소문자 하나를 생성 : 97 ~ 122
	int temp = ((int)(Math.random() * 26)) + 97; // (0 ~ 25) + 97 -> 97 ~ 122
	// System.out.println(temp);
	// System.out.println((char)temp);
	char c1 = (char)temp;
	
	temp = ((int)(Math.random() * 26)) + 97;
	char c2 = (char)temp;
	
	temp = ((int)(Math.random() * 26)) + 97;
	char c3 = (char)temp;
	
	String ranStr = "" + c1 + c2 + c3;
	System.out.println(ranStr);
%>
</body>
</html>