package com.example.restaurant.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.restaurant.dto.Reservation;
import com.example.restaurant.dto.Room;

@Mapper
public interface ReservationMapper {

	List<Room> getTable();

	List<Integer> getReservedRoom(Date date, String reserveTime);

	int addReservationRoom(Reservation reservation);

}
