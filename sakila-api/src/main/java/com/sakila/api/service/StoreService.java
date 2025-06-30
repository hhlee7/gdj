package com.sakila.api.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sakila.api.dto.StoreDto;
import com.sakila.api.entity.AddressEntity;
import com.sakila.api.entity.StoreEntity;
import com.sakila.api.repository.AddressRepository;
import com.sakila.api.repository.CustomerRepository;
import com.sakila.api.repository.StoreRepository;

@Service
@Transactional
public class StoreService {
	private StoreRepository storeRepository;
	private AddressRepository addressRepository;
	private CustomerRepository customerRepository;

	// 생성자 주입 사용
	public StoreService(StoreRepository storeRepository, AddressRepository addressRepository, CustomerRepository customerRepository) {
		// 생성자 주입 전에 선행 작업 or 테스트 등 작업 가능
		this.storeRepository = storeRepository;
		this.addressRepository = addressRepository;
		this.customerRepository = customerRepository;
	}

	// 전체 조회
	public List<StoreEntity> findAll() {
		return storeRepository.findAll();
	}

	// 한 행 조회
	public StoreEntity findById(int storeId) {
		return storeRepository.findById(storeId).orElse(null);
	}

	// 입력
	public void save(StoreDto storeDto) {
		// DTO -> Entity
		StoreEntity saveStoreEntity = new StoreEntity();
		saveStoreEntity.setManagerStaffId(storeDto.getManagerStaffId());

		// AddressEntity (외래키 컬럼 확인 및 설정)
		AddressEntity addressEntity = addressRepository.findById(storeDto.getAddressId()).orElse(null);
		saveStoreEntity.setAddressEntity(addressEntity);

		storeRepository.save(saveStoreEntity);
	}
	
	// 수정
	public void update(StoreDto storeDto) {
		StoreEntity updateStoreEntity = storeRepository.findById(storeDto.getStoreId()).orElse(null);
		updateStoreEntity.setManagerStaffId(storeDto.getManagerStaffId());

		// AddressEntity (외래키 컬럼 확인 및 설정)
		AddressEntity addressEntity = addressRepository.findById(storeDto.getAddressId()).orElse(null);
		updateStoreEntity.setAddressEntity(addressEntity);
	}
	
	// 삭제
	public boolean delete(int storeId) {
		// 자식 테이블에 외래키를 참조하는 행이 존재하는지 확인
		if(0 == customerRepository.countByStoreEntity(storeRepository.findById(storeId).orElse(null))) {
			storeRepository.deleteById(storeId);
			return true;
		}
		return false;
	}

}
