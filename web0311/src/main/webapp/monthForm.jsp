<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>monthForm</title>
</head>
<body>
	<%
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR);
	%>
	<form action="/web0311/monthAction.jsp">
		<select name="targetYear">
			<%
				for(int i = (year - 5); i <= (year + 5); i++) {
					if(i == year) {
			%>
					<option value="<%=i%>" selected="selected"><%=i%></option>
			<%			
					} else {
			%>
					<option value="<%=i%>"><%=i%></option>
			<%
					}
				}
			%>
		</select>
		년
		<select name="targetMonth">
			<%
				for(int i = 1; i <= 12; i++) {
			%>
					<option value="<%=i%>"><%=i%></option>
			<%
				}
			%>
		</select>
		월
		<button type="submit">출력</button>
	</form>
</body>
</html>