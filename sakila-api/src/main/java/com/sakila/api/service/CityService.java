package com.sakila.api.service;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sakila.api.dto.CityDto;
import com.sakila.api.entity.CityEntity;
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
	public List<CityEntity> findAll() {
		return cityRepository.findAll();
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
