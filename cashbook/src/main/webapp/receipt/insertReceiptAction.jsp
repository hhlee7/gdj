<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.*"%>
<%@page import="model.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	// 전달된 파라미터 값 확인용 출력
	System.out.println("insertReceiptForm.jsp cashNo: " + cashNo);

	Part part = request.getPart("imageFile"); // 파일 받는 API
	String originalName = part.getSubmittedFileName(); // one1.png
	System.out.println("originalName: " + originalName);
	
	// 중복되지 않는 새로운 파일 이름 생성 - java.util.UUID API 사용
	UUID uuid = UUID.randomUUID();
	String filename = uuid.toString();
	filename = filename.replace("-", "");
	System.out.println("uuid str: " + filename);
	
	// 생성한 파일 이름에 확장자 추가
	int dotLastPos = originalName.lastIndexOf("."); // 마지막 . 의 인덱스값 반환
	System.out.println("dotLastPos: " + dotLastPos);
	String ext = originalName.substring(dotLastPos);
	
	// Request 입력값 유효성 검증
	if(!ext.equals(".png") && !ext.equals(".jpg")) {
		response.sendRedirect("/cashbook/receipt/insertReceiptForm.jsp?cashNo=" + cashNo + "&msg=NotCorrectFileExtension");
		return; // JSP 코드 진행을 종료
	}
	
	filename = filename + ext;
	System.out.println("filename: " + filename);
	
	Receipt receipt = new Receipt();
	receipt.setCashNo(cashNo);
	receipt.setFilename(filename);
	
	// 파일 저장
	String path = request.getServletContext().getRealPath("upload");
	// 톰켓 안에 cashbook 프로젝트 안 upload 폴더의 실제 물리적 주소를 반환
	System.out.println("path: " + path);
	File emptyFile = new File(path, filename);
	// 파일을 보낼 inputstream 설정
	InputStream is = part.getInputStream(); // 파트안의 스트림(이미지 파일의 바이너리 파일)
	// 파일을 받을 outputstream 설정
	OutputStream os = Files.newOutputStream(emptyFile.toPath());
	is.transferTo(os); // inputstream binary -> 반복(1byte씩) -> outputstream
	
	// db에 저장
	ReceiptDao receiptDao = new ReceiptDao();
	receiptDao.insertReceipt(receipt);
	
	response.sendRedirect("/cashbook/cash/cashOne.jsp?cashNo=" + cashNo);
%>