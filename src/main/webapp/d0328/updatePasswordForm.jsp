<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//로그인 상태 확인
	Integer staffId = (Integer)(session.getAttribute("loginStaff"));
			
	if(staffId == null) { // 로그아웃 상태라면 로그인 페이지로 이동
		response.sendRedirect("/sakila/d0328/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>Update Password</h1>
	<form action="/sakila/d0328/updatePasswordAction.jsp">
		<input type="hidden" name="staffId" value="<%=staffId%>">
		<table border="1">
			<tr>
				<th>기존 비밀번호</th>
				<td><input type="password" name="beforePassword"></td>
			</tr>
			<tr>
				<th>새 비밀번호</th>
				<td><input type="password" name="newPassword"></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" name="confirmPassword"></td>
			</tr>
		</table>
		<button type="submit">비밀번호 변경</button>
	</form>
</body>
</html>