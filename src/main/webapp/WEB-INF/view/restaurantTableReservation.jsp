<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식당 테이블 예약</title>
<style>
    :root {
        --bg: #e5e5e5;
        --font: #222;
        --form-bg: #fff;
        --shadow: #bbb8;
        --th-bg: #ececec;
        --td-bg-even: #fafafa;
        --td-bg-odd: #f3f3f3;
        --btn-bg: #333;
        --btn-bg-hover: #222;
        --btn-font: #fff;
        --a-bg: #333;
        --a-bg-hover: #222;
        --a-font: #fff;
    }
    body.dark-mode {
        --bg: #202124;
        --font: #eee;
        --form-bg: #26282a;
        --shadow: #111a;
        --th-bg: #232528;
        --td-bg-even: #23272c;
        --td-bg-odd: #212328;
        --btn-bg: #333;
        --btn-bg-hover: #181818;
        --btn-font: #fff;
        --a-bg: #333;
        --a-bg-hover: #111;
        --a-font: #fff;
    }
    body {
        background: var(--bg);
        color: var(--font);
        font-family: 'SUIT', 'Pretendard', 'Apple SD Gothic Neo', sans-serif;
        margin: 0;
        padding: 0;
        transition: background 0.3s, color 0.3s;
    }
    h1 {
        margin: 40px 0 24px 0;
        text-align: center;
        color: var(--font);
        font-size: 2rem;
        letter-spacing: 2px;
    }
    .theme-toggle {
        position: absolute;
        top: 30px;
        right: 34px;
        background: var(--btn-bg);
        color: var(--btn-font);
        border: none;
        border-radius: 8px;
        padding: 8px 22px;
        font-weight: 600;
        font-size: 1rem;
        cursor: pointer;
        transition: background 0.2s;
        z-index: 100;
        box-shadow: 0 2px 8px #0002;
    }
    .theme-toggle:hover {
        background: var(--btn-bg-hover);
    }
    form {
        background: var(--form-bg);
        padding: 20px 24px;
        max-width: 480px;
        margin: 0 auto 32px auto;
        border-radius: 18px;
        box-shadow: 0 2px 12px var(--shadow);
        display: flex;
        align-items: center;
        gap: 18px;
        flex-wrap: wrap;
        transition: background 0.3s, box-shadow 0.3s;
    }
    input[type="date"], select {
        background: var(--td-bg-even);
        color: var(--font);
        border: 1px solid #ccc;
        border-radius: 8px;
        padding: 8px 14px;
        font-size: 1rem;
        margin-left: 10px;
        margin-right: 10px;
        transition: background 0.3s, color 0.3s;
    }
    button[type="submit"] {
        background: var(--btn-bg);
        color: var(--btn-font);
        font-weight: 600;
        font-size: 1.05rem;
        padding: 9px 26px;
        border: none;
        border-radius: 9px;
        cursor: pointer;
        box-shadow: 0 2px 8px #1112;
        margin-left: 10px;
        transition: background 0.2s;
    }
    button[type="submit"]:hover {
        background: var(--btn-bg-hover);
    }
    table {
        width: 92%;
        margin: 0 auto 40px auto;
        border-collapse: collapse;
        background: var(--form-bg);
        border-radius: 14px;
        overflow: hidden;
        box-shadow: 0 2px 16px var(--shadow);
        transition: background 0.3s, box-shadow 0.3s;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 13px 8px;
        text-align: center;
        color: var(--font);
    }
    th {
        background: var(--th-bg);
        color: var(--font);
        font-weight: 700;
        letter-spacing: 1px;
    }
    tr:nth-child(even) td {
        background: var(--td-bg-even);
    }
    tr:nth-child(odd) td {
        background: var(--td-bg-odd);
    }
    a {
        color: var(--a-font);
        background: var(--a-bg);
        border-radius: 6px;
        padding: 7px 18px;
        text-decoration: none;
        font-weight: 500;
        box-shadow: 0 1px 6px #bbb2;
        transition: background 0.18s;
    }
    a:hover {
        background: var(--a-bg-hover);
    }
</style>
</head>
<body>
    <button class="theme-toggle" onclick="toggleTheme()">
        <span id="theme-label">🌙 다크모드</span>
    </button>
    <h1>${loginUsername }님 식당 테이블 예약</h1>
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
            <th>최대 정원</th>
            <th>예약</th>
        </tr>
        <c:forEach var="room" items="${roomList}">
            <tr>
                <td>${room.roomNo}</td>
                <td>${room.roomName}</td>
                <td>${room.roomLimit }</td>
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
    <script>
        // 라이트/다크 모드 토글
        function toggleTheme() {
            const body = document.body;
            const themeLabel = document.getElementById("theme-label");
            body.classList.toggle("dark-mode");
            if(body.classList.contains("dark-mode")){
                themeLabel.textContent = "☀️ 라이트모드";
            } else {
                themeLabel.textContent = "🌙 다크모드";
            }
            // 선택값을 localStorage에도 저장 (새로고침에도 유지)
            localStorage.setItem('mode', body.classList.contains("dark-mode") ? "dark" : "light");
        }
        // 페이지 로드시 이전 모드 유지
        window.onload = function() {
            if(localStorage.getItem('mode') === "dark") {
                document.body.classList.add("dark-mode");
                document.getElementById("theme-label").textContent = "☀️ 라이트모드";
            }
        }
    </script>
</body>
</html>
