package mvcboard.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mvcboard.dao.BoardDao;
import mvcboard.dto.Board;

@WebServlet("/boardOne")
public class BoardOneController extends HttpServlet {
	// View forward - boardOne.jsp
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		
		BoardDao boardDao = new BoardDao();
		Board board =  boardDao.selectBoardOne(boardNo);
		
		request.setAttribute("board", board);
		
		// 위임하지 않는다면 모두 코딩해야 함
		// response.getWriter().print("html ...");
		
		// view에게 협업 or 위임한다.
		request.getRequestDispatcher("WEB-INF/view/boardOne.jsp").forward(request, response);
	}
}
