<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%
	// Controller
	// 1) 요청 분석
	int dan = 2; 
	if(request.getParameter("dan") != null) {
		dan = Integer.parseInt(request.getParameter("dan"));
	}

	// 2) 모델 연결(모델에게서 모델값을 반환)
	GuguModel guguModel = new GuguModel();
	ArrayList<String> list = guguModel.getDanList(dan);
	
	// 3) 뷰 연결(뷰에게 모델값 전달)
	request.setAttribute("list", list);
	RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/guguView.jsp"); // 연결 뷰 준비
	rd.forward(request, response);
%>