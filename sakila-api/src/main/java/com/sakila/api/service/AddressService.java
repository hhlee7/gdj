package com.sakila.api.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sakila.api.dto.AddressDto;
import com.sakila.api.entity.AddressEntity;
import com.sakila.api.entity.CityEntity;
import com.sakila.api.repository.AddressRepository;
import com.sakila.api.repository.CityRepository;
import com.sakila.api.repository.CustomerRepository;
import com.sakila.api.repository.StoreRepository;

@Service
@Transactional
public class AddressService {
	private AddressRepository addressRepository;
	private CityRepository cityRepository;
	private StoreRepository storeRepository;
	private CustomerRepository customerRepository;
	
	// 생성자 주입 사용
	public AddressService(AddressRepository addressRepository, CityRepository cityRepository,
							StoreRepository storeRepository, CustomerRepository customerRepository) {
		this.addressRepository = addressRepository;
		this.cityRepository = cityRepository;
		this.storeRepository = storeRepository;
		this.customerRepository = customerRepository;
	}
	
	// address 전체 조회
	public List<AddressEntity> findAll() {
		return addressRepository.findAll();
	}
	
	// address 한 행 조회
	public AddressEntity findById(int addressId) {
		return addressRepository.findById(addressId).orElse(null);
	}

	// AddressEntity 입력
	public void save(AddressDto addressDto) {
		// DTO -> Entity
		AddressEntity saveAddressEntity = new AddressEntity();
		saveAddressEntity.setAddress(addressDto.getAddress());
		saveAddressEntity.setAddress2(addressDto.getAddress2());
		saveAddressEntity.setDistrict(addressDto.getDistrict());
		saveAddressEntity.setPostalCode(addressDto.getPostalCode());
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
		
		CityEntity cityEntity = cityRepository.findById(addressDto.getCityId()).orElse(null);
		updateAddressEntity.setCityEntity(cityEntity);
	}
	
	// 삭제
	public boolean delete(int addressId) {
		// 자식 테이블에 외래키를 참조하는 행이 존재하는지 확인
		if(0 == storeRepository.countByAddressEntity(addressRepository.findById(addressId).orElse(null)) &&
			0 == customerRepository.countByAddressEntity(addressRepository.findById(addressId).orElse(null))) {
			addressRepository.deleteById(addressId);
			return true;
		}
		return false;
	}
}
