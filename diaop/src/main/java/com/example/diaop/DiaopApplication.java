package com.example.diaop;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import com.example.diaop.service.OfficialService;
import com.example.diaop.service.PersonService;
import com.example.diaop.service.PoliceService;

// SpringBootApplication은 Configuration 어노테이션을 포함한다. - 설정 파일의 역할을 한다.
@SpringBootApplication
public class DiaopApplication {

	public static void main(String[] args) {
		SpringApplication.run(DiaopApplication.class, args);
	}
	
	// 설정 파일에서 빈을 생성하기
	@Bean
	public PersonService personService() {
		return new OfficialService();
	}
	
}
