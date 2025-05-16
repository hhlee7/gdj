package com.example.mbboard.listener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.example.mbboard.dto.ConnectCount;
import com.example.mbboard.service.IRootService;

import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class ConnectCountListener implements HttpSessionListener {
	@Autowired IRootService rootService;
	
    public void sessionCreated(HttpSessionEvent se) {
    	log.info("새로운 세션 생성");
    	
    	// 현재 접속자 카운트
    	// currentConnectCount++
    	se.getSession().getServletContext().setAttribute("currentConnectCount"
    			, (Integer)(se.getSession().getServletContext().getAttribute("currentConnectCount")) + 1);
    	
    	// 처음 세션이 만들어 졌을 때 호출되는 메서드
    	// 클라이언트(쿠키) - 서버(세션)
    	// 처음 - 쿠키(empty) - new세션.id - response와 함께 클라이언트에 전송
    	ConnectCount cc = new ConnectCount();
    	cc.setMemberRole("ANONYMOUS");
    	if(rootService.getConnectDateByKey(cc) == null) {
    		rootService.addConnectCount(cc);
    	} else {
    		rootService.modifyConnectCount(cc);
    	}
    }

    public void sessionDestroyed(HttpSessionEvent se)  {
    	// session.invalidate() or session timeout 시
    	// currentConnectCount--
    	se.getSession().getServletContext().setAttribute("currentConnectCount"
    			, (Integer)(se.getSession().getServletContext().getAttribute("currentConnectCount")) - 1);
    	// JSP : application.getAttribute("currentConnectCount")
    	// ${application_scope.currentConnection}, 약식 ${currentConnectCount}
    }
	
}
