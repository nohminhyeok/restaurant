package com.example.restaurant.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.restaurant.dto.Reservation;
import com.example.restaurant.dto.Room;
import com.example.restaurant.mapper.ReservationMapper;

@Service
public class ReservationService {
	private ReservationMapper reservationMapper;
	
	public ReservationService(ReservationMapper reservationMapper) {
		this.reservationMapper = reservationMapper;
	}

	public List<Room> getTable() {
		return reservationMapper.getTable();
	}

	public List<Integer> getReservedRoom(Date date, String reserveTime) {
		return reservationMapper.getReservedRoom(date, reserveTime);
	}

	public int addReservationRoom(Reservation reservation) {
		return reservationMapper.addReservationRoom(reservation);
	}

}
