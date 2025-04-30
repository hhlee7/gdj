<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.*"%>
<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String title = request.getParameter("title");
	String[] content = request.getParameterValues("content");
	int type = Integer.parseInt(request.getParameter("type"));
	// 전달된 값 확인용 출력
	System.out.println("updatePollAction.jsp title: " + title);
	System.out.println("updatePollAction.jsp content: " + content);
	System.out.println("updatePollAction.jsp type: " + type);
	
	// question 모델(Dao) 객체 생성
	QuestionDao questionDao = new QuestionDao();
	// update 메서드 호출(title, type 수정)
	questionDao.updateQuestion(num, title, type);
	
	// content 내용 중 공백 요소 제거
	ArrayList<String> contents = new ArrayList<>();
	for(String c : content) {
		if(!c.equals("")) {
			contents.add(c);
		}
	}
	// 공백 제거된 항목 확인용 출력
	System.out.println(contents);
	
	// 항목 객체 리스트 생성
	ArrayList<Item> itemList = new ArrayList<>();
	int i = 1;
	for(String c : contents) {
		Item item = new Item();
		item.setQnum(num);
		item.setInum(i);
		item.setContent(c);
		itemList.add(item);
		i++;
	}
	
	// item 모델(Dao) 객체 생성
	ItemDao itemDao = new ItemDao();
	
	// 해당 num에 연결된 기존 항목 모두 삭제
	itemDao.deleteItem(num);
	
	// 새로운 항목 추가
	for(Item item : itemList) {
		itemDao.insertItem(item);
	}
	
	// View 없으므로, pollList.jsp 로 이동
	response.sendRedirect("/poll/pollList.jsp");
%>
