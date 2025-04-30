<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "home.Student"%> <!-- home.Student 치환 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>j03.jsp</title>
</head>
<body>
	<h1>주소 타입(참조 타입)</h1>
	<%
		// String 타입(기본 라이브러리(api)에서 제공)
		String name = "구디";
		System.out.println(name);
		// System.out.println(name[0]); // error
		
		// 배열(언어 자체에서 제공)
		int[] arr = {3, 7, 5};
		System.out.println(arr);
		System.out.println(arr[0]); // [] 참조 연산자 사용
		System.out.println(arr[1]);
		System.out.println(arr[2]);
		// System.out.println(arr[3]); // error
		
		// 사용자 정의 타입(Class)
		Student ksm;
		ksm = new Student();
		System.out.println(ksm);
		ksm.name = '김'; // . 참조 연산자 사용
		ksm.age = 28;
		System.out.println(ksm.name);
		System.out.println(ksm.age);		
	%>
</body>
</html>