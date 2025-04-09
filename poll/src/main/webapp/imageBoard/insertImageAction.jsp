<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.*"%>
<%@page import="model.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%
	String memo = request.getParameter("memo");
	Part part = request.getPart("imageFile"); // 파일 받는 API
	String originalName = part.getSubmittedFileName(); // one1.png
	System.out.println("originalName: " + originalName);
	
	// 1) 중복되지 않는 새로운 파일 이름 생성 - java.util.UUID API 사용
	UUID uuid = UUID.randomUUID();
	String filename = uuid.toString();
	filename = filename.replace("-", "");
	System.out.println("uuid str: " + filename);
	
	// 2) 1의 결과에 확장자 추가
	int dotLastPos = originalName.lastIndexOf("."); // 마지막 . 의 인덱스값 반환
	System.out.println("dotLastPos: " + dotLastPos);
	String ext = originalName.substring(dotLastPos);
	
	// Request 입력값 유효성 검증
	if(!ext.equals(".png")) {
		response.sendRedirect("/poll/imageBoard/insertImageForm.jsp?msg=ErrorNotPng");
		return; // JSP 코드 진행을 종료
	}
	
	filename = filename + ext;
	System.out.println("filename: " + filename);
	
	Image img = new Image();
	img.setMemo(memo);
	img.setFilename(filename);
	
	// 3) 파일 저장
	// 빈 파일 생성
	// File emptyFile = new File("c:/upload/a.png");
	String path = request.getServletContext().getRealPath("upload");
	// 톰켓안에 poll 프로젠트 안 upload 폴더의 실제 물리적 주소를 반환
	System.out.println("path: " + path);
	File emptyFile = new File(path, filename);
	// 파일을 보낼 inputstream 설정
	InputStream is = part.getInputStream(); // 파트안의 스트림(이미지 파일의 바이너리 파일)
	// 파일을 받을 outputstream 설정
	OutputStream os = Files.newOutputStream(emptyFile.toPath());
	is.transferTo(os); // inputstream binary -> 반복(1byte씩) -> outputstream
	
	// 4) db에 저장
	ImageDao imageDao = new ImageDao();
	imageDao.insertImage(img);
	response.sendRedirect("/poll/imageBoard/imageList.jsp");
%>