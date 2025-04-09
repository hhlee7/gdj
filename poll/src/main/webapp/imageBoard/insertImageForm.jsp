<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>이미지 올리기</title>
    </head>
    <body>
    <%
    	if(request.getParameter("msg") != null) { // insertImageAction.jsp에서 png파일이 아니라서 redirect
    %>
    		<div><%=request.getParameter("msg")%></div>
    <%
    	}
    %>
    <form action="/poll/imageBoard/insertImageAction.jsp" method="post"	enctype="multipart/form-data">
	<!-- enctype="multipart/form-data" : 2진수 파일 형태로 전송 -->
		<div>메모 : <input type="text" name="memo" /></div>
		<div>이미지 : <input type="file" name="imageFile" /></div>
		<button type="submit">이미지 등록</button>
    </form>
    </body>
</html>