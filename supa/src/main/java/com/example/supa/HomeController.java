package com.example.supa;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HomeController {
	@Autowired NowMapper nowMapper;
	
	@GetMapping("/")
	public String home() {
		return nowMapper.selectNow();
	}
}

/*
 * com.example.supa.mapper.BoardMapper
 * com.example.supa.service.BoardService
 * com.example.supa.controller.BoardController
 * com.example.supa.dto.BoardDto
 * /WEB-INF/view/addBoard.jsp
 * /WEB-INF/view/editBoard.jsp
 * /WEB-INF/view/boardList.jsp
 */