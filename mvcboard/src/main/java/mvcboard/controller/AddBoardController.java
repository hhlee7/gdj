package mvcboard.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mvcboard.dao.BoardDao;
import mvcboard.dto.Board;

@WebServlet("/addBoard")
public class AddBoardController extends HttpServlet {
	// 입력 폼 - View forward
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/addBoard.jsp").forward(request, response);
	}
	
	// 입력 액션 - redirect
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1) 요청 분석
		String boardPw = request.getParameter("boardPw");
		String boardTitle = request.getParameter("boardTitle");
		String boardContent = request.getParameter("boardContent");
		String boardUser = request.getParameter("boardUser");
		
		Board board = new Board();
		board.setBoardPw(boardPw);
		board.setBoardTitle(boardTitle);
		board.setBoardContent(boardContent);
		board.setBoardUser(boardUser);
		
		System.out.println("AddBoardController.doPost: " + board.toString());
		
		// 2) 모델 호출
		BoardDao boardDao = new BoardDao();
		int row = boardDao.insertBoard(board);
		// 디버깅 코드 삽입 요망
		
		// 3) redirect(GET)
		// 클라이언트 입장에서의 주소 입력해야 함
		response.sendRedirect(request.getContextPath() + "/boardList");
	}
}
