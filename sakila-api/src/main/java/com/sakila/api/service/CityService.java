package com.sakila.api.service;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sakila.api.dto.CityDto;
import com.sakila.api.entity.CityEntity;
import com.sakila.api.entity.CountryEntity;
import com.sakila.api.repository.CityRepository;
import com.sakila.api.repository.CountryRepository;

@Service
@Transactional
public class CityService {

	private CityRepository cityRepository;
	private CountryRepository countryRepository;
	
	// 필드 주입 대신 생성자 주입을 사용
	public CityService(CityRepository cityRepository, CountryRepository countryRepository) {
		this.cityRepository = cityRepository;
		this.countryRepository = countryRepository;
	}
	
	// 입력
	public void save(CityDto cityDto) {
		// DTO -> Entity
		CityEntity saveCityEntity = new CityEntity();
		saveCityEntity.setCity(cityDto.getCity());
		
		// CountryEntity
		CountryEntity countryEntity = countryRepository.findById(cityDto.getCountryId()).orElse(null);
		saveCityEntity.setCountryEntity(countryEntity);
		
		cityRepository.save(saveCityEntity);
	}
	
	// 전체 조회
	public List<CityEntity> findAll() {
		return cityRepository.findAll();
	}
}
