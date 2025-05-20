package com.example.login_history.dto;

import lombok.Data;

@Data
public class Member {
	private String id;
	private String pw;
	private String email;
	private String active;
}