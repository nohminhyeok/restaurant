package com.example.restaurant.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.restaurant.dto.CustomOAuth2User;
import com.example.restaurant.dto.Reservation;
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
							  , @RequestParam(required = false, defaultValue = "AM") String reserveTime
							  , Model model) {
		if (date == null) {
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.HOUR_OF_DAY, 0); // 시간 0시 0분 0초로 맞춤
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			cal.set(Calendar.MILLISECOND, 0);
			date = cal.getTime();
		}
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String loginUsername = authentication.getName();
		String loginId = null;

		if (authentication.getPrincipal() instanceof CustomOAuth2User) {
		    CustomOAuth2User customUser = (CustomOAuth2User) authentication.getPrincipal();
		    loginId = customUser.getOAuthId(); // 위에서 만든 메소드 사용
		} else {
		    // 일반 로그인(UsernamePasswordAuthenticationToken 등) 처리
		    loginId = authentication.getName(); // 이 경우 username
		}
		List<Room> list = reservationService.getTable();
		List<Integer> reservedRoom = reservationService.getReservedRoom(date, reserveTime);
		
		model.addAttribute("loginUsername", loginUsername);
		model.addAttribute("roomList", list);
		model.addAttribute("reservedRooms", reservedRoom);
		model.addAttribute("selectedDate", date);
		model.addAttribute("reserveTime", reserveTime);
		
		return"restaurantTableReservation";
	}
	
	@GetMapping("/reservationOne")
	public String reservationOne(@RequestParam int roomNo
								,@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date date
								,@RequestParam String reserveTime
								,Model model) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String loginUsername = authentication.getName();
		String reservationId = null;
		String provider = null;
		
		if (authentication.getPrincipal() instanceof CustomOAuth2User) {
		    CustomOAuth2User customUser = (CustomOAuth2User) authentication.getPrincipal();
		    reservationId = customUser.getOAuthId();
		    provider = customUser.getProvider();
		} else {
			reservationId = authentication.getName();
		}
		List<Room> list = reservationService.getTable();
	    Room selectedRoom = null;
	    for (Room room : list) {
	        if (room.getRoomNo() == roomNo) {
	            selectedRoom = room;
	            break;
	        }
	    }

	    model.addAttribute("reservationId", reservationId);
		model.addAttribute("room", selectedRoom);
		model.addAttribute("provider", provider);
		model.addAttribute("loginUsername", loginUsername);
		model.addAttribute("roomNo", roomNo);
		model.addAttribute("reserveTime", reserveTime);
		model.addAttribute("selectedDate", date);
		
		return "reservationOne";
	}

	@PostMapping("/reservationAction")
	public String reservationAction(@RequestParam String reservationId
								   ,@RequestParam int roomNo
								   ,@RequestParam String reserveTime
								   ,@RequestParam int headCount
								   ,@RequestParam String provider
								   ,@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date date) {
		
		if (date == null) {
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.HOUR_OF_DAY, 0); // 시간 0시 0분 0초로 맞춤
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			cal.set(Calendar.MILLISECOND, 0);
			date = cal.getTime();
		}

		Reservation reservation = new Reservation();
		reservation.setRoomNo(roomNo);
		reservation.setReservationDate(new java.sql.Date(date.getTime()));
		reservation.setReservationOption(reserveTime);
		reservation.setReservationId(reservationId);
		reservation.setReservationCount(headCount);
		reservation.setProvider(provider);
		
		reservationService.addReservationRoom(reservation);
		
	    String formattedDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(date);

	    return "redirect:/restaurantTableReservation?date=" + formattedDate;
	}
}
