<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>rspForm</h1>
	
	<form action="/web0306/rspAction.jsp">
		<!-- 여러 개 중에 하나를 선택하는 폼 요소 : radio, select, ... -->
		<div>
			<input type="radio" name="userRsp" value="가위">가위
			<input type="radio" name="userRsp" value="바위">바위
			<input type="radio" name="userRsp" value="보">보
		</div>
		<div>
			<button type="submit">선택</button>
		</div>
	</form>
</body>
</html>