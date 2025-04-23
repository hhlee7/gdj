package mvcboard.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mvcboard.dao.BoardDao;
import mvcboard.dto.Board;
import mvcboard.dto.Page;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/boardList")
public class BoardListController extends HttpServlet {
	
	// View forward : boardList.jsp
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1) 요청 분석
		int rowPerPage = 10;
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		Page page = new Page(currentPage, rowPerPage);
		
		// 2) 모델 호출
		BoardDao boardDao = new BoardDao();
		ArrayList<Board> list = boardDao.selectBoardList(page);
		int totalCount = boardDao.selectBoardCount(); // lastPage
		int lastPage = totalCount / rowPerPage;
		if(totalCount % rowPerPage != 0) {
			lastPage += 1;
		}
		
		request.setAttribute("list", list);
		request.setAttribute("lastPage", lastPage); // 페이징 네비게이션
		
		// 포워딩
		request.getRequestDispatcher("/WEB-INF/view/boardList.jsp").forward(request, response);
	}

}
