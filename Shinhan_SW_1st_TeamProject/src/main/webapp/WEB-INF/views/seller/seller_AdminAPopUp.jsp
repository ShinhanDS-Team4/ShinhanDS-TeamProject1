<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>판매자 문의</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>

	
	function closePopUp() {
		window.close();
	}
</script>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 40px;
}

h1 {
	font-size: 36px;
}

.container {
	width: 50%;
	margin: auto;
}

.info {
	margin-bottom: 20px;
}

.info div {
	margin: 10px 0;
}

.info label {
	font-weight: bold;
}

.info input {
	border: none;
	outline: none;
	font-size: 15px;
}

.input-group {
	margin: 20px 0;
}

.input-group label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
}

.input-group input, .input-group textarea {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	background-color: #f7f7f7;
}

.buttons {
	text-align: center;
}

.buttons button {
	padding: 10px 20px;
	margin: 0 10px;
	border: none;
	border-radius: 4px;
	background-color: black;
	color: white;
	font-size: 16px;
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="container">
		<h1>관리자 문의 결과</h1>
		<div class="info">
			<div>
				<label>문의ID</label>
				<input type="number" id="admin_inq_id" name="admin_inq_id" value="${aqa.admin_inq_id}" />
			</div>
			<div>
				<label>문의일자</label>
				<input type="date" id="admin_inq_date" name="admin_inq_date" value="${aqa.admin_inq_date}" />
			</div>
		</div>
		<div class="input-group">
			<label for="subject">제목</label>
			<input type="text" id="admin_inq_title" name="admin_inq_title" readonly="readonly"
				value="${aqa.admin_inq_title}" />
		</div>
		<div class="input-group">
			<label for="inquiry">문의내용</label>
			<textarea id="admin_inq_content" name="admin_inq_content" readonly="readonly" rows="5">${aqa.admin_inq_content}</textarea>
		</div>
		<div class="input-group">
			<label for="response">답변</label>
			<textarea id="admin_reply" name="admin_reply" readonly="readonly" rows="5" >${aqa.admin_reply}</textarea>
		</div>
		<div class="buttons">
			<button type="button" onclick="closePopUp()">닫기</button>
		</div>
	</div>
</body>
</html>