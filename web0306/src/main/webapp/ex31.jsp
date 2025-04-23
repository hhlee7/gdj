<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>P129 예제</h1>
	<form action="/web0306/ex32.jsp">
		<div>
			이름 : <input type="text" name="name">
		</div>
		<div>
			좋아하는 색깔
			<select name="color">
				<option value="blue" selected="selected">파란색</option>
				<option value="red">붉은색</option>
				<option value="orange">오렌지색</option>
				<option value="etc">기타</option>
			</select>
		</div>
		<div>
			<button type="submit">보내기</button>
		</div>
	</form>
</body>
</html>