<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>j05.jsp</title>
</head>
<body>
	<h1>비교 연산자 - 결과가 true / false</h1>
	<%
		int a = 10;
		int b = 10;
		System.out.println(a == b); // true
		
		String s1 = "구디";
		String s2 = "구디";
		System.out.println(s1 == s2); // true
		
		String str1 = new String("구디");
		String str2 = new String("구디");
		System.out.println(str1 == str2); // false
		System.out.println(str1.equals(str2)); // true
		
		int[] arr1 = {1, 3};
		int[] arr2 = {1, 3};
		System.out.println(arr1 == arr2); // false
	%>
	
	<h1>대입 연산자</h1>
	<%
		int x = 10;
		// x = x + 10;
		x += 10;
		System.out.println(x); // 20
	%>
	
	<h1>논리 연산자 and &&, or ||, not !</h1>
	<%
		boolean b1 = 3 > 2; // true
		boolean b2 = 3 < 2; // false
		
		System.out.println(!b1); // false
		System.out.println(b1 && b2); // false
		System.out.println(b1 || b2); // true
	%>
</body>
</html>