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
    	// 처음 세션이 만들어 졌을 때
    	// 클라이언트(쿠키) - 서버(세션)
    	// 처음 - 쿠키(empty) - new세션.id - response와 함께 클라이언트에 전송
    	// 두 번째 - 쿠키(세션.id) - 세션 연결
    	ConnectCount cc = new ConnectCount();
    	cc.setMemberRole("ANONYMOUS");
    	if(rootService.getConnectDateByKey(cc) == null) {
    		rootService.addConnectCount(cc);
    	} else {
    		rootService.modifyConnectCount(cc);
    	}
    }

    public void sessionDestroyed(HttpSessionEvent se)  {
    	// session.invalidate()
    }
	
}
