<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>테이블 예약</h1>
	<form method="post" action="reservationAction">
		<div>
			이름: <input type="text">
		</div>
		<div>
			날짜: <input type="date">
		</div>
		<div>
			시간: <input type="checkbox" value="오전">
			<input type="checkbox" value="오후">
		</div>
		<div>
			인원수: <input type="text">
		</div>
		<button type="submit">예약</button>
	</form>
</body>
</html>