package com.sakila.api.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sakila.api.entity.AddressEntity;
import com.sakila.api.entity.CityEntity;

public interface AddressRepository extends JpaRepository<AddressEntity, Integer>{
	Long countByCityEntity(CityEntity cityEntity);
	// select count(*) from address where city_id = cityEntity.getCityId()
}
