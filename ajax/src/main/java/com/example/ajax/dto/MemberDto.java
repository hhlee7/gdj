package com.example.ajax.dto;

import lombok.Data;

@Data
public class MemberDto {
	private String id;
	private String pw;
	private String pw2;
	private String gender;
	private int age;
}
