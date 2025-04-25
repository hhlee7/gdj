<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
</head>
<body>
	<!-- 자바 코드 X / 대신 EL + JSTL 사용 : mustache (단독으로 사용할 수 없기 때문에 JSP 안에서 사용) -->
	<c:forEach var="b" items="${list}">
		<div>
			${b.boardNo} ${b.boardTitle}
			<a href="/remove?boardNo=${b.boardNo}">[삭제]	</a>
		</div>
	</c:forEach>
</body>
</html>