<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>주민번호 입력</h1>
	<form action="/web0307/ex3Action.jsp">
		<div>
			<input type="text" name="sn1"> - <input type="text" name="sn2">
		</div>
		<button type="submit">입력</button>
	</form>
	<!-- 
		ex3Action.jsp 출력
		1) 성별
		생일이 2000년 이전 : sn2의 첫번째 숫자가 1(남자), 2(여자)
							외국인이면(귀화) 5(남자), 6(여자) 
		생일이 2000년 이후 : sn2의 첫번째 숫자가 3(남자), 4(여자) 
							외국인이면(귀화) 7(남자), 8(여자) 
		2) 나이
	 -->
</body>
</html>