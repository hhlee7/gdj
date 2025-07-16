package com.example.springai.api;

import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.springai.service.AIChatService;

import jakarta.servlet.http.HttpSession;

@RestController
public class AIChatController {
	private final AIChatService aiChatService;
	public AIChatController(AIChatService aiChatService) {
		this.aiChatService = aiChatService;
	}
	
	@PostMapping("/chat")
	public String chat(@RequestBody Map<String, String> body, HttpSession session) { // session 속성안에 message List를 만들어 이전 대화를 누적
		System.out.println(body);
		System.out.println(body.get("userMsg"));
		
		// {"msg":"hello"} JSON 문자열 -> java DTO 객체 변환(@RequestBody의 역할)
		String userMsg = body.get("userMsg");
		String aiReply = aiChatService.generate(userMsg, session);
		
		return aiReply;
	}
	
}
