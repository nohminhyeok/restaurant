<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테이블 예약</title>
<style>
    :root {
        --bg: #ececec;
        --font: #222;
        --form-bg: #fff;
        --shadow: #bbb7;
        --input-bg: #f8f8f8;
        --input-border: #dadada;
        --input-font: #202020;
        --readonly-bg: #f2f2f2;
        --readonly-border: #e0e0e0;
        --readonly-font: #707070;
        --radio-accent: #333;
        --btn-bg: #333;
        --btn-hover-bg: #181818;
        --btn-font: #fff;
    }
    body.dark-mode {
        --bg: #181a1b;
        --font: #eee;
        --form-bg: #222325;
        --shadow: #0004;
        --input-bg: #232426;
        --input-border: #222;
        --input-font: #eee;
        --readonly-bg: #181818;
        --readonly-border: #222;
        --readonly-font: #aaa;
        --radio-accent: #fff;
        --btn-bg: #222;
        --btn-hover-bg: #444;
        --btn-font: #fff;
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
        margin-top: 44px;
        text-align: center;
        color: var(--font);
        font-size: 2.2rem;
        letter-spacing: 2px;
        transition: color 0.3s;
    }
    .theme-toggle {
        position: absolute;
        top: 32px;
        right: 40px;
        background: var(--btn-bg);
        color: var(--btn-font);
        border: none;
        border-radius: 8px;
        padding: 9px 22px;
        font-weight: 600;
        font-size: 1rem;
        cursor: pointer;
        box-shadow: 0 2px 8px #0002;
        transition: background 0.2s;
        z-index: 100;
    }
    .theme-toggle:hover {
        background: var(--btn-hover-bg);
    }
    form {
        background: var(--form-bg);
        padding: 36px 28px;
        max-width: 480px;
        margin: 40px auto 32px auto;
        border-radius: 22px;
        box-shadow: 0 3px 28px var(--shadow);
        transition: background 0.3s, box-shadow 0.3s;
    }
    form > div {
        margin-bottom: 22px;
    }
    label {
        display: block;
        margin-bottom: 7px;
        color: var(--font);
        font-weight: 600;
        font-size: 1rem;
        letter-spacing: 1px;
        transition: color 0.3s;
    }
    input[type="text"],
    input[type="number"],
    input[type="date"] {
        background: var(--input-bg);
        color: var(--input-font);
        border: 1px solid var(--input-border);
        border-radius: 9px;
        padding: 9px 14px;
        font-size: 1rem;
        outline: none;
        margin-top: 3px;
        box-sizing: border-box;
        width: 100%;
        transition: border 0.18s, background 0.3s, color 0.3s;
        height: 38px;
    }
    input[readonly] {
        color: var(--readonly-font) !important;
        background: var(--readonly-bg) !important;
        border-color: var(--readonly-border) !important;
        opacity: 1 !important;
    }
    input[type="radio"] {
        accent-color: var(--radio-accent);
        margin-right: 6px;
        margin-left: 10px;
        vertical-align: middle;
        width: 16px;
        height: 16px;
        transition: accent-color 0.3s;
    }
    input[type="radio"]:first-child {
        margin-left: 0;
    }
    input[type="hidden"] {
        display: none;
    }
    button[type="submit"] {
        background: var(--btn-bg);
        color: var(--btn-font);
        font-weight: 700;
        font-size: 1.15rem;
        padding: 15px 0;
        width: 100%;
        border: none;
        border-radius: 13px;
        box-shadow: 0 2px 12px #aaa4;
        cursor: pointer;
        transition: background 0.2s;
        margin-top: 18px;
        letter-spacing: 2px;
    }
    button[type="submit"]:hover {
        background: var(--btn-hover-bg);
    }
    @media (max-width: 520px) {
        form {
            padding: 20px 8px;
            max-width: 99vw;
            border-radius: 10px;
        }
    }
</style>
</head>
<body>
    <button class="theme-toggle" onclick="toggleTheme()">
        <span id="theme-label">🌙 다크모드</span>
    </button>
	<h1>테이블 예약</h1>
	<form method="post" action="/reservationAction">
	    <input type="hidden" name="roomNo" value="${room.roomNo}">
	    <input type="hidden" name="reservationId" value="${reservationId}">
	    <input type="hidden" name="provider" value="${provider}">
	    <div>
	        <label>이름:</label>
	        <c:if test="${not empty loginUsername}">
	            <input type="text" name="username" value="${loginUsername}" readonly>
	        </c:if>
	    </div>
	    <div>
	        <label>예약일자:</label>
	        <input type="date" name="date" value="<fmt:formatDate value='${selectedDate}' pattern='yyyy-MM-dd'/>" readonly>
	    </div>
	    <div>
	        <label>시간대:</label>
	        <input type="radio" name="reserveTime" value="AM" <c:if test="${reserveTime == 'AM'}">checked</c:if> disabled> 오전
	        <input type="radio" name="reserveTime" value="PM" <c:if test="${reserveTime == 'PM'}">checked</c:if> disabled> 오후
	        <input type="hidden" name="reserveTime" value="${reserveTime}">
	    </div>
	    <div>
	        <label>인원수:</label>
	        <input type="number" name="headCount" min="1" required>
	    </div>
	    <div>
	    	<label>최대 정원:</label>
	    	<input type="text" value="${room.roomLimit}" readonly>
	    </div>
	    <button type="submit">예약</button>
	</form>
    <script>
        function toggleTheme() {
            const body = document.body;
            const themeLabel = document.getElementById("theme-label");
            body.classList.toggle("dark-mode");
            if(body.classList.contains("dark-mode")){
                themeLabel.textContent = "☀️ 라이트모드";
            } else {
                themeLabel.textContent = "🌙 다크모드";
            }
            localStorage.setItem('mode', body.classList.contains("dark-mode") ? "dark" : "light");
        }
        window.onload = function() {
            if(localStorage.getItem('mode') === "dark") {
                document.body.classList.add("dark-mode");
                document.getElementById("theme-label").textContent = "☀️ 라이트모드";
            }
        }
    </script>
</body>
</html>
