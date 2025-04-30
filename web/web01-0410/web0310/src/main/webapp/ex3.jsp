<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%!
	public void m1(int input) {
		System.out.println(10 * input);
	}

	public void evenOdd(int input) {
		if(input % 2 == 0) {
			System.out.println("짝수");
		} else {
			System.out.println("홀수");			
		}
	}
	
	public String resultEvenOdd(int input) {
		String result = "홀수";
		if(input % 2 == 0) {
			result = "짝수";
		}
		// System.out.println(result); 디버깅
		return result;
	}
	
	public int add(int x, int y) {
		return x + y;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	m1(3);
	evenOdd(44); // 짝수
	String r1 = resultEvenOdd(33);
	String r2 = resultEvenOdd(20);
%>
	r1 : <%=r1%><br>
	r2 : <%=r2%><br>
	7+15 : <%=add(7, 15)%>
<%
	int z = add(1, 5); // z = 6
	int a = 17;
	int b = 3;
	int c = add(a, b); // c = add(17, 3) -> c = 20
%>
	<div>
		<%=z%><br>
		<%=c%>
	</div>
</body>
</html>