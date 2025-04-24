<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>반복문</h1>
	<!-- while / for / foreach -->
	
	<%
		for(int i = 0; i < 5; i = i + 1) {
			System.out.println(i + "in for!");	
		}
		System.out.println("out for!");
				
		String[] names = {"김성민", "김예진", "노민혁", "송성인", "오상윤"};
		
		for(int i = 0; i < 5; i = i + 1) {
		System.out.println(names[i]);
		}
		
		for(String s : names) { // 읽기 전용
		System.out.println(s);
		}
	%>
</body>
</html>