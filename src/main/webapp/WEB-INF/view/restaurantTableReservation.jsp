<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식당 테이블 예약</title>
</head>
<body>
    <h1>식당 테이블 예약</h1>
    <div>
	<form method="get" action="/restaurantTableReservation">
		날짜: <input type="date" name="date" value="<fmt:formatDate value='${selectedDate}' pattern='yyyy-MM-dd'/>">
        시간대:
			<select name="reserveTime">
			    <option value="AM" <c:if test="${reserveTime == 'AM'}">selected</c:if>>오전</option>
			    <option value="PM" <c:if test="${reserveTime == 'PM'}">selected</c:if>>오후</option>
			</select>
		<button type="submit">조회</button>
	</form>
    </div>
    <table border="1">
        <tr>
            <th>방 번호</th>
            <th>방 이름</th>
            <th>예약</th>
        </tr>
		<c:forEach var="room" items="${roomList}">
		    <tr>
		        <td>${room.roomNo}</td>
		        <td>${room.roomName}</td>
		        <td>
		            <c:set var="isReserved" value="false" />
		            <c:forEach var="reservedRoomNo" items="${reservedRooms}">
		                <c:if test="${reservedRoomNo == room.roomNo}">
		                    <c:set var="isReserved" value="true" />
		                </c:if>
		            </c:forEach>
		            <c:choose>
		                <c:when test="${isReserved}">
		                    예약 불가
		                </c:when>
		                <c:otherwise>
		                    <a href="/reservationOne?roomNo=${room.roomNo}&date=<fmt:formatDate value='${selectedDate}' pattern='yyyy-MM-dd'/>&reserveTime=${reserveTime}">예약하기</a>
		                </c:otherwise>
		            </c:choose>
		        </td>
		    </tr>
		</c:forEach>
    </table>
</body>
</html>
