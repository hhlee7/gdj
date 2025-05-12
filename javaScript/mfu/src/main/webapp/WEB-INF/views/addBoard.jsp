<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>addBoard</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="card shadow">
					<div class="card-body">
						<h1 class="card-title text-center mb-4">게시글 작성</h1>
						<form id="addForm" action="${pageContext.request.contextPath}/addBoard" method="post" enctype="multipart/form-data">
							<div class="mb-3">
								<label for="boardTitle" class="form-label">제목</label>
								<input type="text" class="form-control" name="boardTitle" id="boardTitle">
							</div>
							<div class="mb-3">
								<label class="form-label">파일 첨부</label>
								<div class="d-grid gap-2 d-md-flex justify-content-md-start mb-2">
									<button id="appendFile" type="button" class="btn btn-outline-secondary btn-sm">파일 추가</button>
								</div>
								<div id="fileDiv">
									<input type="file" name="boardfile" class="form-control mb-2 boardfile">
								</div>
							</div>
							<div class="d-flex justify-content-between">
								<button id="addBtn" type="button" class="btn btn-primary">등록</button>
								<a href="/boardList" class="btn btn-secondary">목록</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
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
			inputFile.setAttribute('class', 'form-control mb-2 boardfile');
			document.querySelector('#fileDiv').appendChild(inputFile);
		})
		
		document.querySelector('#addBtn').addEventListener('click', () => {
			// alert('addBtn click!');
			// 폼(값) 유효성 검사 선행
			if(document.querySelector('#boardTitle').value == '') {
				alert('제목을 입력하세요.');
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