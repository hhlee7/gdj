package com.sakila.api.restcontroller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.sakila.api.dto.AddressDto;
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
	
	// 한 행 조회
	@GetMapping("/address/{addressId}")
	public ResponseEntity<AddressEntity> addressOne(@PathVariable int addressId) {
		return new ResponseEntity<AddressEntity>(addressService.findById(addressId), HttpStatus.OK);
	}
	
	// 입력
	@PostMapping("/address")
	public ResponseEntity<String> address(@RequestBody AddressDto addressDto) {
		addressService.save(addressDto);
		return new ResponseEntity<String>("입력 성공", HttpStatus.OK);
	}
	
	// 수정
	@PatchMapping("/address")
	public ResponseEntity<String> updateAddress(@RequestBody AddressDto addressDto) {
		addressService.update(addressDto);
		return new ResponseEntity<String>("수정 성공", HttpStatus.OK);
	}
	
	// 삭제
	@DeleteMapping("/address/{addressId}")
	public ResponseEntity<String> deleteAddress(@PathVariable int addressId) {
		boolean result = addressService.delete(addressId);
		if(result) {
			return new ResponseEntity<String>("삭제 성공", HttpStatus.OK);
		}
		return new ResponseEntity<String>("삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
