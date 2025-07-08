package com.example.diaop.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.diaop.service.PersonService;

@RestController
public class GuestController {
	// GuestController는 PoliceService가 없으면 구현할 수 없다.
	// PoliceService가 필수로 먼저 생성되어야 한다. -> 의존한다. -> 의존 관계
	PersonService personService; // 생성자의 의존성 삭제, 하지만 타입 선언에 대한 의존성은 여전히 존재
	
	// 생성자 주입은 @Autowired 어노테이션 생략 가능
	public GuestController(PersonService personService) {
		// 의존성 주입 전, 선행되는 코드를 추가
		this.personService = personService;
		// 테스트 코드를 추가
	}
	
	@GetMapping("/guest")
	public void guest() {
		personService.service();
	}
}
