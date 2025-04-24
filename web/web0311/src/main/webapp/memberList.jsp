<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.Member"%>
<%@ page import="java.util.UUID"%>
<%@ page import="java.util.Calendar"%>
<%
	String[] lastNames = {
			"김", "이", "박", "최", "정", "강", "조", "윤", "장", "임",
			"한", "오", "서", "신", "권", "황", "안", "송", "류", "전",
			"홍", "고", "문", "양", "손", "배", "조", "백", "허", "유",
			"남", "심", "노", "정", "하", "곽", "성", "차", "주", "우",
			"구", "신", "임", "나", "전", "민", "유", "진", "지", "엄",
			"채", "원", "천", "방", "공", "강", "현", "함", "변", "염",
			"양", "변", "여", "추", "노", "도", "소", "신", "석", "선",
			"설", "마", "길", "주", "연", "방", "위", "표", "명", "기",
			"반", "왕", "금", "옥", "육", "인", "맹", "제", "모", "장",
			"남", "탁", "국", "여", "진", "어", "은", "편", "구", "용"};
	System.out.println(lastNames.length);
	
	String[] locals = {"서울시", "경기도", "강원도", "충청도", "전라도", "경상도", "제주도"};

	Member[] list = new Member[333]; // 배열 생성
	for(int i = 0; i < list.length; i++) {
		list[i] = new Member();
		list[i].lastName = lastNames[(int)(Math.random() * lastNames.length)]; // 0 ~ 99
		list[i].age = (int)(Math.random() * 82) + 19; // 19 ~ 100
		list[i].gender = "남"; // 남 or 여
		if((int)(Math.random() * 2) % 2 == 0) {
			list[i].gender = "여";
		}
		list[i].local = locals[(int)(Math.random() * locals.length)]; // 0 ~ 6
		
		String temp = "010-";
		temp = temp + (int)(Math.random() * 10);
		temp = temp + (int)(Math.random() * 10);
		temp = temp + (int)(Math.random() * 10);
		temp = temp + (int)(Math.random() * 10);
		temp = temp + "-";
		temp = temp + (int)(Math.random() * 10);
		temp = temp + (int)(Math.random() * 10);
		temp = temp + (int)(Math.random() * 10);
		temp = temp + (int)(Math.random() * 10);
		list[i].phone = temp;
		
		list[i].isGlass = false;
		if((int)(Math.random() * 2) % 2 == 0) {
			list[i].isGlass = true;
		}
		
		String tempPw = UUID.randomUUID().toString();
		tempPw = tempPw.replace("-", "");
		tempPw = tempPw.substring(0, 8); // 8개의 문자열을 잘라서 임시 pw로 설정
		list[i].pw = tempPw;
	}
	
	for(Member m : list) {
		System.out.println(m.lastName);
		System.out.println(m.age);
		System.out.println(m.gender);
		System.out.println(m.local);
		System.out.println(m.phone);
		System.out.println(m.isGlass);
		System.out.println(m.pw);
	}
	
	Calendar today = Calendar.getInstance();
	int todayYear = today.get(Calendar.YEAR);
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int idxPerPage = 10;
	// 마지막 페이지 : 전체 개수(list.length) / idxPerPage -> 나누어 떨이지지 않으면 올림(or + 1)
	int lastPage = list.length / idxPerPage;
	if(list.length % idxPerPage != 0) { // 결과가 나누어 떨이지지 않으면
		lastPage += 1; // 333 / 10 --> 33, 333 % / 10 --> 3, lastPage --> 33 + 1
	}
	
	int startIdx = (currentPage - 1) * idxPerPage;
		
	// 출력할 페이지의 마지막 인덱스는 마지막 페이지의 경우 변경 필요
	int endIdx = startIdx + (idxPerPage - 1);
	if(endIdx > list.length - 1) {
		endIdx = list.length - 1; // endIdx를 전체 배열의 마지막 idx로 변경
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<table border="1">
		<tr>
			<th>성(이름)</th>
			<th>생년(나이)</th>
			<th>성별</th>
			<th>지역</th>
			<th>전화번호</th>
			<th>안경(유/무)</th>
			<th>비밀번호</th>
		</tr>
		<%
			for(int i = startIdx; i <= endIdx; i++) {
		%>
				<tr>
					<td><%=list[i].lastName%></td>
					<td><%=todayYear - list[i].age%>(<%=list[i].age%>)</td> <!-- 2000(24) -->
					<td>
						<%
							if(list[i].gender == "남") {
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
						<%
							if(list[i].local.equals("서울시")) {
						%>
								<td style="color: red"><%=list[i].local%></td>
						<%
							} else if(list[i].local.equals("경기도")) {								
						%>
								<td style="color: orange"><%=list[i].local%></td>
						<%
							} else if(list[i].local.equals("강원도")) {								
						%>
								<td style="color: yellow"><%=list[i].local%></td>
						<%
							} else if(list[i].local.equals("충청도")) {								
						%>
								<td style="color: green"><%=list[i].local%></td>
						<%
							} else if(list[i].local.equals("전라도")) {								
						%>
								<td style="color: blue"><%=list[i].local%></td>
						<%
							} else if(list[i].local.equals("경상도")) {								
						%>
								<td style="color: navy"><%=list[i].local%></td>
						<%
							} else if(list[i].local.equals("제주도")) {								
						%>
								<td style="color: purple"><%=list[i].local%></td>
						<%
							}
						%>
					<td><%=list[i].phone%></td>
					<td>
						<%
							if(list[i].isGlass == true) {
						%>
									O
						<%
							} else {								
						%>
									X
						<%
							}
						%>
					</td>
					<td><%=list[i].pw.substring(0, 2)%>******</td> <!-- ab****** -->
				</tr>
		<%
			}
		%>
	</table>
	<div>
		<!-- 페이징 로직 -->
		<a href="/web0311/memberList.jsp?currentPage=1">[처음으로]</a>
		<!-- 현재 페이지가 1 이 아닐 때 출력 : 현재 페이지가 1 보다 클 때 -->
		<%
			if(currentPage > 1) { // currentPage != 1
		%>
				<a href="/web0311/memberList.jsp?currentPage=<%=currentPage - 1%>">[이전]</a>				
		<%
			}
		%>
		
		<%=currentPage%>
		
		<!-- 현재 페이지가 마지막 페이지가 아닐 때 출력 : 현재 페이지가 마지막 페이지보다 작을 때 -->
		<%
			if(currentPage < lastPage) {
		%>
				<a href="/web0311/memberList.jsp?currentPage=<%=currentPage + 1%>">[다음]</a>
		<%
			}
		%>
		<a href="/web0311/memberList.jsp?currentPage=<%=lastPage%>">[마지막으로]</a>
	</div>
</body>
</html>