<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dto.Student" %>
<%@ page import = "java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
   Student[] s = null;
   s = new Student[14];

   s[0] = new Student();
   s[0].no = 1;
   s[0].name = "김성민";
   s[0].gender = 'M';
   s[0].birthYear = 2000;
   s[0].height = 179.0;
   s[0].isArmy = true;
   
   s[1] = new Student();
   s[1].no = 2;
   s[1].name = "김예진";
   s[1].gender = 'F';
   s[1].birthYear = 2001;
   s[1].height = 158.0;
   s[1].isArmy = false;
   
   s[2] = new Student();
   s[2].no = 3;
   s[2].name = "노민혁";
   s[2].gender = 'M';
   s[2].birthYear = 1997;
   s[2].height = 177.5;
   s[2].isArmy = true;

   s[3] = new Student();
   s[3].no = 4;
   s[3].name = "송성인";
   s[3].gender = 'M';
   s[3].birthYear = 1994;
   s[3].height = 177.7;
   s[3].isArmy = true;
   
   s[4] = new Student();
   s[4].no = 5;
   s[4].name = "오상윤";
   s[4].gender = 'M';
   s[4].birthYear = 2001;
   s[4].height = 0;
   s[4].isArmy = true;
   
   s[5] = new Student();
   s[5].no = 6;
   s[5].name = "오원재";
   s[5].gender = 'M';
   s[5].birthYear = 1996;
   s[5].height = 178.0;
   s[5].isArmy = true;
   
   s[6] = new Student();
   s[6].no = 7;
   s[6].name = "유빈";
   s[6].gender = 'M';
   s[6].birthYear = 2000;
   s[6].height = 177.5;
   s[6].isArmy = true;
   
   s[7] = new Student();
   s[7].no = 8;
   s[7].name = "윤성권";
   s[7].gender = 'M';
   s[7].birthYear = 2000;
   s[7].height = 171;
   s[7].isArmy = true;
   
   s[8] = new Student();
   s[8].no = 9;
   s[8].name = "이현호";
   s[8].gender = 'M';
   s[8].birthYear = 1994;
   s[8].height = 182;
   s[8].isArmy = true;
   
   s[9] = new Student();
   s[9].no = 10;
   s[9].name = "장정수";
   s[9].gender = 'M';
   s[9].birthYear = 1994;
   s[9].height = 172;
   s[9].isArmy = true;
   
   s[10] = new Student();
   s[10].no = 11;
   s[10].name = "장지영";
   s[10].gender = 'M';
   s[10].birthYear = 1993;
   s[10].height = 178.2;
   s[10].isArmy = true;
   
   s[11] = new Student();
   s[11].no = 12;
   s[11].name = "조서진";
   s[11].gender = 'M';
   s[11].birthYear = 1993;
   s[11].height = 177.0;
   s[11].isArmy = true;
   
   s[12] = new Student();
   s[12].no = 13;
   s[12].name = "최윤석";
   s[12].gender = 'M';
   s[12].birthYear = 1997;
   s[12].height = 0;
   s[12].isArmy = true;
   
   s[13] = new Student();
   s[13].no = 14;
   s[13].name = "황귀환";
   s[13].gender = 'M';
   s[13].birthYear = 2000;
   s[13].height = 182.0;
   s[13].isArmy = true;
   
   // 오늘 날짜의 년도
   Calendar today = Calendar.getInstance();
   int todayYear = today.get(Calendar.YEAR);
%>
<table border="1">
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>성별</th>
			<th>나이(생년)</th>
			<th>키</th>
			<th>군필</th>
		</tr>
		<%
			for(Student st : s) {
				if(st.name.equals("최윤석")) {
		%>
					<tr style="background-color: #00AA22">
		<%	
				} else {
		%>
					<tr>
		<%
				}
		%>
				
						<td><%=st.no%></td>
						<td><%=st.name.substring(0, 1)%>XX</td>
						<td>
							<%
								if(st.gender == 'M') {
							%>
									&#128102;
							<%
								} else {
							%>
									&#128103;
							<%	
								}
							%>
						</td>
						<td><%=todayYear - st.birthYear %>(<%=st.birthYear%>)</td>
						<td><%=st.height%></td>
						<td><%=st.isArmy%></td>
					</tr>
		<%
			}
		%>
	</table>
</body>
</html>