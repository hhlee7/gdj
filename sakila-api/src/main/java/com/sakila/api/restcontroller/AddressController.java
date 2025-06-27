package com.sakila.api.restcontroller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sakila.api.entity.AddressEntity;
import com.sakila.api.service.AddressService;

@RestController
public class AddressController {
	private AddressService addressService;
	
	// 생성자 주입 사용
	public AddressController(AddressService addressService) {
		this.addressService = addressService;
	}
	
	// 전체 조회
	@GetMapping("/address")
	public ResponseEntity<List<AddressEntity>> address() {
		return new ResponseEntity<List<AddressEntity>>(addressService.findAll(), HttpStatus.OK);
	}
}
