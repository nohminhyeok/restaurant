package com.example.restaurant.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class Pay {
	private int payNo;
	private int reservationNo;
	private int amount;
	private String payMethod;
	private Date createdate;
}
