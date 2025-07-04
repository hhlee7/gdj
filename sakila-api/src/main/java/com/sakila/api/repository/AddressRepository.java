package com.sakila.api.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.sakila.api.entity.AddressEntity;
import com.sakila.api.entity.AddressMapping;
import com.sakila.api.entity.CityEntity;

public interface AddressRepository extends JpaRepository<AddressEntity, Integer>{
	Long countByCityEntity(CityEntity cityEntity);
	// select count(*) from address where city_id = cityEntity.getCityId()
	
	Page<AddressMapping> findAllBy(Pageable pageable);
	List<AddressMapping> findAllBy();
}
