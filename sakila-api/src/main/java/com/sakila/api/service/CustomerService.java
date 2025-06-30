package com.sakila.api.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sakila.api.dto.CustomerDto;
import com.sakila.api.entity.AddressEntity;
import com.sakila.api.entity.CustomerEntity;
import com.sakila.api.entity.StoreEntity;
import com.sakila.api.repository.AddressRepository;
import com.sakila.api.repository.CustomerRepository;
import com.sakila.api.repository.StoreRepository;

@Service
@Transactional
public class CustomerService {
	private CustomerRepository customerRepository;
	private StoreRepository storeRepository;
	private AddressRepository addressRepository;
	
	// 생성자 주입 사용
	public CustomerService(CustomerRepository customerRepository, StoreRepository storeRepository, AddressRepository addressRepository) {
		this.customerRepository = customerRepository;
		this.storeRepository = storeRepository;
		this.addressRepository = addressRepository;
	}
	
	// 전체 조회
	public List<CustomerEntity> findAll() {
		return customerRepository.findAll();
	}
	
	// 한 행 조회
	public CustomerEntity findById(int customerId) {
		return customerRepository.findById(customerId).orElse(null);
	}
	
	// 입력
	public void save(CustomerDto customerDto) {
		// DTO -> Entity
		CustomerEntity saveCustomerEntity = new CustomerEntity();
		saveCustomerEntity.setFirstName(customerDto.getFirstName());
		saveCustomerEntity.setLastName(customerDto.getLastName());
		saveCustomerEntity.setEmail(customerDto.getEmail());
		saveCustomerEntity.setActive(customerDto.getActive());
		
		// StoreEntity (외래키 컬럼 확인 및 설정)
		StoreEntity storeEntity = storeRepository.findById(customerDto.getStoreId()).orElse(null);
		saveCustomerEntity.setStoreEntity(storeEntity);
		
		// AddressEntity (외래키 컬럼 확인 및 설정)
		AddressEntity addressEntity = addressRepository.findById(customerDto.getAddressId()).orElse(null);
		saveCustomerEntity.setAddressEntity(addressEntity);
		
		customerRepository.save(saveCustomerEntity);
	}
	
	// 수정
	public void update(CustomerDto customerDto) {
		CustomerEntity updateCustomerEntity = customerRepository.findById(customerDto.getCustomerId()).orElse(null);
		updateCustomerEntity.setFirstName(customerDto.getFirstName());
		updateCustomerEntity.setLastName(customerDto.getLastName());
		updateCustomerEntity.setEmail(customerDto.getEmail());
		updateCustomerEntity.setActive(customerDto.getActive());
	}
	
	// 삭제
	public boolean delete(int customerId) {
		if(customerRepository.existsById(customerId)) {
			customerRepository.deleteById(customerId);
			return true;
		}
		return false;
	}

}
