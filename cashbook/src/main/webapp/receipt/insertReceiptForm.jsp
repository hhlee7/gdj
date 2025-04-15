<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	// 전달된 파라미터 값 확인용 출력
	System.out.println("insertReceiptForm.jsp cashNo: " + cashNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertReceiptForm</title>
</head>
<body>
	<h1>영수증 첨부</h1>
	<form action="/cashbook/receipt/insertReceiptAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="cashNo" value="<%=cashNo%>">
		<div>이미지 : <input type="file" name="imageFile"></div>
		<%
			if(request.getParameter("msg") != null) {
		%>
				<div><%=request.getParameter("msg")%></div>
		<%
			}
		%>
		<button type="submit">등록</button>
    </form>
</body>
</html>