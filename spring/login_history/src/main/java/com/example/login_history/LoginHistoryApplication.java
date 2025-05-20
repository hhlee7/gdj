package com.example.login_history;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class LoginHistoryApplication {

	public static void main(String[] args) {
		SpringApplication.run(LoginHistoryApplication.class, args);
	}

}
