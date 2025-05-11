<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addBoard</title>
</head>
<body>
	<h1>addBoard</h1>
	<form id="addForm" action="${pageContext.request.contextPath}/addBoard" method="post" enctype="multipart/form-data">
		<table border="1">
			<tr>
				<td>boardTitle</td>
				<td>
					<input type="text" name="boardTitle" id="boardTitle">
				</td>
			</tr>
			<tr>
				<td>boardfile</td>
				<td>
					<div>
						<button id="appendFile" type="button">파일 추가</button>
					</div>
					<div id="fileDiv">
						<input type="file" name="boardfile" class="boardfile">
					</div>
				</td>
			</tr>
		</table>
		<button id="addBtn" type="button">입력</button>
	</form>
	<a href="/boardList">목록으로</a>
	<script>
		document.querySelector('#appendFile').addEventListener('click', () => {
			let flag = false; // 두 번째, 세 번째... flag = false로 초기화
			
			// input type=file 추가 : 앞의 파일이 모두 선택되어 있다면
			let boardfiles = document.querySelectorAll('.boardfile');
			boardfiles.forEach((e) => {
				if(e.value == '') {
					alert('공백인 boardfile이 있습니다.');
					flag = true; // 공백이 존재
					return; // forEach 콜백 함수를 탈출
				}
			});
			
			if(flag) { // 공백이 존재한다면
				return;
			}
			
			let inputFile = document.createElement('input');
			inputFile.setAttribute('type', 'file');
			inputFile.setAttribute('name', 'boardfile');
			inputFile.setAttribute('class', 'boardfile');
			document.querySelector('#fileDiv').appendChild(inputFile);
		})
		
		document.querySelector('#addBtn').addEventListener('click', () => {
			// alert('addBtn click!');
			// 폼(값) 유효성 검사 선행
			if(document.querySelector('#boardTitle').value == '') {
				alert('title을 입력하세요.');
				return;
			}
			
			// 파일이 추가되지 않은 node(input type=file)을 삭제
			let boardfiles = document.querySelectorAll('.boardfile');
			boardfiles.forEach((e) => {
				if(e.value == '') {
					e.remove(); // node 삭제
				}
			})
				
			document.querySelector('#addForm').submit();
		})
	</script>
</body>
</html>