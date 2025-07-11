package com.example.restaurant.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.restaurant.dto.Room;
import com.example.restaurant.service.ReservationService;

@Controller
public class RoomController {
	private ReservationService reservationService;
	
	public RoomController(ReservationService reservationService) {
		this.reservationService = reservationService;
	}

	@GetMapping("/restaurantTableReservation")
	public String rTreservation(@RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date date
							  , Model model
							  , @RequestParam(required = false, defaultValue = "AM") String reserveTime) {
		if (date == null) {
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.HOUR_OF_DAY, 0); // 시간 0시 0분 0초로 맞춤
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			cal.set(Calendar.MILLISECOND, 0);
			date = cal.getTime();
		}
		List<Room> list = reservationService.getTable();
		List<Integer> reservedRoom = reservationService.getReservedRoom(date, reserveTime);
		
		model.addAttribute("roomList", list);
		model.addAttribute("reservedRooms", reservedRoom);
		model.addAttribute("selectedDate", date);
		model.addAttribute("reserveTime", reserveTime);
		
		return"restaurantTableReservation";
	}
	
	@GetMapping("/reservationOne")
	public String reservationOne() {
		return "reservationOne";
	}

}
