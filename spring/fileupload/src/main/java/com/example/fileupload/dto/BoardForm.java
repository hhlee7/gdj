package com.example.fileupload.dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.example.fileupload.entity.Board;

import lombok.Data;

@Data
public class BoardForm {
	private int bno;
	private String title;
	private String pw;
	private List<MultipartFile> fileList; // spring에서 input type="file"
	
	public Board toEntity() {
		Board entity = new Board();
		entity.setTitle(this.title);
		return entity;
	}
}
