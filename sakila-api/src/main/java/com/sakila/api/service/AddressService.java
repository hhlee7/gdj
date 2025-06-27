package com.sakila.api.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sakila.api.dto.AddressDto;
import com.sakila.api.entity.AddressEntity;
import com.sakila.api.entity.CityEntity;
import com.sakila.api.repository.AddressRepository;
import com.sakila.api.repository.CityRepository;

@Service
@Transactional
public class AddressService {
	private AddressRepository addressRepository;
	private CityRepository cityRepository;
	
	// 생성자 주입 사용
	public AddressService(AddressRepository addressRepository, CityRepository cityRepository) {
		this.addressRepository = addressRepository;
		this.cityRepository = cityRepository;
	}
	
	// address 전체 조회
	public List<AddressEntity> findAll() {
		return addressRepository.findAll();
	}

	// AddressEntity 입력
	public void save(AddressDto addressDto) {
		// DTO -> Entity
		AddressEntity saveAddressEntity = new AddressEntity();
		saveAddressEntity.setAddress(addressDto.getAddress());
		saveAddressEntity.setDistrict(addressDto.getDistrict());
		saveAddressEntity.setPhone(addressDto.getPhone());
		
		// CityEntity
		CityEntity cityEntity = cityRepository.findById(addressDto.getCityId()).orElse(null);
		saveAddressEntity.setCityEntity(cityEntity);
		
		addressRepository.save(saveAddressEntity);
	}

	// address 수정
	public void update(AddressDto addressDto) {
		AddressEntity updateAddressEntity = addressRepository.findById(addressDto.getAddressId()).orElse(null);
		updateAddressEntity.setAddress(addressDto.getAddress());
		updateAddressEntity.setAddress2(addressDto.getAddress2());
		updateAddressEntity.setDistrict(addressDto.getDistrict());
		updateAddressEntity.setPostalCode(addressDto.getPostalCode());
		updateAddressEntity.setPhone(addressDto.getPhone());
	}
}
