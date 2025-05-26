package com.example.signapp.service;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.signapp.dto.SignForm;
import com.example.signapp.mapper.SignMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class SignService {
	@Autowired SignMapper signMapper;

	public boolean addSign(SignForm signForm) {
		
		// 0) signImg 파일 이름을 생성
		String ext = signForm.getSignImg().split("/")[1].split(";")[0]; // data:image/png;Base64,xxxx~
		String filename = UUID.randomUUID().toString().replace("-", "") + ext;
		
		// 1) DB에 Base64 문자열로 저장(mapper 호출)
		int row = signMapper.insertSign(signForm);
		if(row == 1) {
			log.info("사인 저장 성공");
		} else {
			log.info("사인 저장 실패");
		}
		
		// 2) 이미지를 디코딩해서 원하는 위치에 저장
		FileOutputStream fos = null;
		try {
			fos = new FileOutputStream("c:\\sign_img\\" + filename); // throws FileNotFoundException
			// 파일을 만들 수 있는 비어있는 OutputStream에 signImg안의 이미지 문자(signImg ,뒤부터)를 디코딩
			String singImg1 = signForm.getSignImg().split(",")[1];
			fos.write(Base64.getDecoder().decode(singImg1)); // throws IOException
		} catch (FileNotFoundException e1) {
			log.error("파일 생성 실패 @Transactional rollback");
			throw new RuntimeException(); // class SignException extends RuntimeException
		} catch (IOException e2) {
			log.error("파일 디코딩 실패 @Transactional rollback");
		} finally {
			try {
				fos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return true;
	}

}
