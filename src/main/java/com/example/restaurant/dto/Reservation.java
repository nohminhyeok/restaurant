package com.example.restaurant.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class Reservation {
	private int reservationNo;
	private int roomNo;
	private Date reservationDate;
	private String reservationOption;
	private String reservationId;
	private int reservationCount;
	private String provider;
	private Date createdate;
	private Date updatedate;
}
