package com.sakila.api.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class StoreDto {
	private int storeId;
	private int managerStaffId;
	private int addressId;
	private Timestamp lastUpdate;
}
