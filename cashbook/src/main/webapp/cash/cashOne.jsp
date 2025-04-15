<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.*"%>
<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	// 전달된 파라미터 값 확인용 출력
	System.out.println("cashOne.jsp cashNo: " + cashNo);
	
	// Cash 모델 호출
	CashDao cashDao = new CashDao();
	
	// 해당 cashNo 값을 가지는 데이터를 조회하여 list에 저장
	Cash c = cashDao.selectCashOne(cashNo);
	
	// dateList.jsp로 보낼 cashDate 값 형식 변환
	String dateParts[] = c.getCashDate().split("-");
	int y = Integer.parseInt(dateParts[0]);
	int m = Integer.parseInt(dateParts[1]);
	int d = Integer.parseInt(dateParts[2]);
	
	ReceiptDao receiptDao = new ReceiptDao();
	ArrayList<Receipt> list = receiptDao.selectImageList(cashNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashOne</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container">
	<h1>내역 상세</h1>
	<table class="table table-hover">
		<tr>
			<th>분류</th>
			<td><%=c.getKind()%></td>
		</tr>
		<tr>
			<th>항목</th>
			<td><%=c.getTitle()%></td>
		</tr>
		<tr>
			<th>일자</th>
			<td><%=c.getCashDate()%></td>
		</tr>
		<tr>
			<th>금액</th>
			<td><%=c.getAmount()%></td>
		</tr>
		<tr>
			<th>메모</th>
			<td><%=c.getMemo()%></td>
		</tr>
		<tr>
			<th>등록일</th>
			<td><%=c.getCreatedate()%></td>
		</tr>
		<tr>
			<th>수정일</th>
			<td><%=c.getUpdatedate()%></td>
		</tr>
	</table>
	<a class="btn btn-outline-primary" href="/cashbook/dateList.jsp?y=<%=y%>&m=<%=m%>&d=<%=d%>">목록</a>
	<a class="btn btn-outline-primary" href="/cashbook/cash/updateCashForm.jsp?cashNo=<%=c.getCashNo()%>">수정</a>
	<a class="btn btn-outline-primary" href="/cashbook/cash/deleteCashAction.jsp?cashNo=<%=c.getCashNo()%>&y=<%=y%>&m=<%=m%>&d=<%=d%>">삭제</a>
	<a class="btn btn-outline-primary" href="/cashbook/receipt/insertReceiptForm.jsp?cashNo=<%=c.getCashNo()%>">영수증 등록</a>
	
	<!-- 영수증 목록 -->
	<table>
	<%
		// 영수증 파일이 있는 경우
		if (list != null && !list.isEmpty()) {
			for(Receipt r : list) {
	%>
					<tr>
						<td>
							<img src="/cashbook/upload/<%=r.getFilename()%>">
						</td>
					</tr>
					<tr>
						<td><%=r.getCreatedate()%></td>
					</tr>
					<tr>
						<td>
							<a href="/cashbook/receipt/deleteReceipt.jsp?cashNo=<%=r.getCashNo()%>&filename=<%=r.getFilename()%>">삭제</a>
						</td>
					</tr>
	<%
		// 영수증 파일이 없는 경우
			}
		} else {
	%>
			<p>등록된 영수증이 없습니다.</p>
	<%
		}
	%>
	</table>
</body>
</html>