<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int y = Integer.parseInt(request.getParameter("y"));
	int m = Integer.parseInt(request.getParameter("m"));
	int d = Integer.parseInt(request.getParameter("d"));
	// y, m, d 값 넘어오는지 확인
	System.out.println("insertDiaryForm.jsp y: " + y);
	System.out.println("insertDiaryForm.jsp m: " + m);
	System.out.println("insertDiaryForm.jsp d: " + d);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>insertDiaryForm</h1>
	<form action="/web0318/insertDiaryAction.jsp">
		<input type="hidden" name="y" value="<%=y%>">
		<input type="hidden" name="m" value="<%=m%>">
		<input type="hidden" name="d" value="<%=d%>">
		<table border="1">
			<tr>
				<th>diaryTitle</th>
				<td><input type="text" name="diaryTitle"></td>
			</tr>
			<tr>
				<th>diaryColor</th>
				<td><input type="color" name="diaryColor"></td>
			</tr>
			<tr>
				<th>diaryMemo</th>
				<td><textarea rows="5" cols="50" name="diaryMemo"></textarea></td>
			</tr>
		</table>
		<button type="submit">일정 추가</button>
	</form>
</body>
</html>