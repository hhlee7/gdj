package com.sakila.api.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sakila.api.dto.CityDto;
import com.sakila.api.entity.CityEntity;
import com.sakila.api.entity.CityMapping;
import com.sakila.api.entity.CountryEntity;
import com.sakila.api.repository.AddressRepository;
import com.sakila.api.repository.CityRepository;
import com.sakila.api.repository.CountryRepository;

@Service
@Transactional
public class CityService {

	private CityRepository cityRepository;
	private CountryRepository countryRepository;
	private AddressRepository addressRepository;
	
	// 필드 주입 대신 생성자 주입을 사용
	public CityService(CityRepository cityRepository, CountryRepository countryRepository, AddressRepository addressRepository) {
		this.cityRepository = cityRepository;
		this.countryRepository = countryRepository;
		this.addressRepository = addressRepository;
	}
	
	// city 전체 조회
	public Page<CityMapping> findAll(int currentPage) {
		int pageSize = 10;
		int pageNumber = currentPage - 1;
		Sort sort = Sort.by("cityId").ascending();
		PageRequest pageable = PageRequest.of(pageNumber, pageSize, sort);
		return cityRepository.findAllBy(pageable);
	}
	
	// city 한 행 조회
	public CityEntity findById(int cityId) {
		return cityRepository.findById(cityId).orElse(null);
	}

	// CityEntity 입력
	public void save(CityDto cityDto) {
		// DTO -> Entity
		CityEntity saveCityEntity = new CityEntity();
		saveCityEntity.setCity(cityDto.getCity());
		
		// CountryEntity
		CountryEntity countryEntity = countryRepository.findById(cityDto.getCountryId()).orElse(null);
		saveCityEntity.setCountryEntity(countryEntity);
		
		cityRepository.save(saveCityEntity);
	}
	
	// city 수정
	public void update(CityDto cityDto) {
		CityEntity updateCityEntity = cityRepository.findById(cityDto.getCityId()).orElse(null);
		updateCityEntity.setCity(cityDto.getCity());
		
		CountryEntity countryEntity = countryRepository.findById(cityDto.getCountryId()).orElse(null);
		updateCityEntity.setCountryEntity(countryEntity);
	}

	// city 삭제
	public boolean delete(int cityId) {
		// issue : 자식 테이블에 외래키로 참조하는 행이 있다면?
		// 자식 테이블에 참조하는 행이 없다면 (select count(*) from address where city_id = ?)
		if(0 == addressRepository.countByCityEntity(cityRepository.findById(cityId).orElse(null))) {
			cityRepository.deleteById(cityId);
			return true;
		}
		return false;
	}
}
