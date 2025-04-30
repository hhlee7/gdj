<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%
	// 52개의 Card를 생성
	Card[] card = new Card[52];

	// 52개의 Card를 초기화 (spade, 1) ~ (clover, 13)
	
	for(int i = 0; i < card.length; i++) {
		card[i] = new Card();
		card[i].num = (i % 13) + 1; // 13장 씩 순서대로 1 ~ 13
		if(i / 13 == 0) {
			card[i].kind = "spade";
		} else if(i / 13 == 1) {
			card[i].kind = "diamond";			
		} else if(i / 13 == 2) {
			card[i].kind = "heart";		
		} else if(i / 13 == 3) {
			card[i].kind = "clover";
		}
	}
	
	// 초기화 후 디버깅
	// for(Card c : card) {
		// System.out.println(c.kind + " " + c.num);
	// }
	
	// 셔플
	for(int i = 0; i < 1000000; i++) { // 섞기 횟수가 1000000번
		int rNum = (int)(Math.random() * card.length); // 0 ~ 51
		// 스왑
		Card temp = card[0];
		card[0] = card[rNum];
		card[rNum] = temp;
	}
	
	// 셔플 후 디버깅
	for(Card c : card) {
		System.out.println(c.kind + " " + c.num);
	}
	
	// 두 명의 player
	Player p1 = new Player();
	p1.name = "루피";
	p1.pcard = new Card[3];
	
	Player p2 = new Player();
	p2.name = "조로";
	p2.pcard = new Card[3];
	
	int cardPerPlayer = 3;
	int playerCount = 2;
	
	for(int i = 0; i < cardPerPlayer * playerCount; i++) {
		if(i / cardPerPlayer == 0) { // 0, 1, 2 -> 첫 번째 플레이어
			p1.pcard[i % cardPerPlayer] = card[i];
		} else if(i / cardPerPlayer == 1) { // 3, 4, 5 -> 두 번째 플레이어
			p2.pcard[i % cardPerPlayer] = card[i];
		}
	}	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cardGame.jsp</title>
</head>
<body>
	<div>
		<%=p1.name%> 카드
		<%
			for(Card c : p1.pcard) {
		%>
				<%=c.kind%>-<%=c.num%>,
		<%
			}
		%>
	</div>
	<div>
		<%=p2.name%> 카드
		<%
			for(Card c : p2.pcard) {
		%>
				<%=c.kind%>-<%=c.num%>,
		<%
			}
		%>
	</div>
</body>
</html>