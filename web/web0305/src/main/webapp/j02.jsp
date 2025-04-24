<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>j02.jsp</title>
</head>
<body>
	<h1>데이터 타입</h1>
	<%
		int x = 10; // 변수 선언
		x = 10; // 변수 초기화 : 변수에 처음으로 값을 할당(대입)
		System.out.println(x);
		
		// 추론 타입의 변수 선언
		var y = 7; // 선언과 초기화 같이
		
		int z = 3;
		System.out.println(z); // 3
		z = 1;
		System.out.println(z); // 1
		// int z = 5; // 동일한 이름의 변수는 선언할 수 없다.
		byte a = 1;
		// byte a2 = 128;
		short b = 1;
		// short b2 = 33000;
		int c = 1;
		// int c2 = 3000000000;
		long d = 3000000000L;
		long e = (long)10;
		int f = (int)3000000000L; // 강제 형 변환
		System.out.println(f);
		
		float g = 0.1F;
		double h = 1.5;
		g = 4.777777777777777F;
		System.out.println(g);
		
		boolean i = false;
		i = (7==7);
		
		char j = 'a';
		
		String s = "abc";
		String s2 = "a";
		// 8개의 값 타입
		
		// 주소 타입 | 참조 타입
		String str = "가나다";
	%>
</body>
</html>