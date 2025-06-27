package com.sakila.api.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class AddressDto {
	private int addressId;
	private String address;
	private String address2;
	private String district;
	private int cityId;
	private String postalCode;
	private String phone;
	private Timestamp lastUpdate;
}
