package mvcboard.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mvcboard.dao.BoardDao;
import mvcboard.dto.Board;

import java.io.IOException;

@WebServlet("/modifyBoard")
public class ModifyBoardController extends HttpServlet {
	// 수정 폼
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		
		BoardDao boardDao = new BoardDao();
		Board board =  boardDao.selectBoardOne(boardNo);
		
		request.setAttribute("board", board);
		
		request.getRequestDispatcher("WEB-INF/view/modifyBoard.jsp").forward(request, response);
	}
	
	// 수정 액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Board board = new Board();
		board.setBoardNo(Integer.parseInt(request.getParameter("boardNo")));
		board.setBoardPw(request.getParameter("boardPw"));
		board.setBoardTitle(request.getParameter("boardTitle"));
		board.setBoardContent(request.getParameter("boardContent"));
		
		BoardDao boardDao = new BoardDao();
		int row = boardDao.updateBoard(board);
		if(row < 1) { // 수정 실패
			response.sendRedirect(request.getContextPath() + "/modifyBoard?boardNo=" + board.getBoardNo());
		} else { // 수정 성공
			response.sendRedirect(request.getContextPath() + "/boardOne?boardNo=" + board.getBoardNo());
		}
	}
}
