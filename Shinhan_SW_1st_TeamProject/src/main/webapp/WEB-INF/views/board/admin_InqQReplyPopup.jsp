<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>판매자 문의 작성</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	function closePopUp() {
		self.close();
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
	display: inline-block;
	width: 100px;
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
		<h1>관리자 문의 작성</h1>
		<form id="registerAQ" method="post" action="${path}/adminqna/writeqna.do"
			enctype="multipart/form-data" accept-charset="UTF-8">
			<div class="info">
				<div>
					<label>회원ID</label>
					<input type="text" name="member_id" id="member_id" value="${adminInq.member_id}" readonly/>
				</div>
			</div>
			<div class="info">
				<div>
					<label>문의날짜</label> <input type="text" name="admin_inq_date"
						id="admin_inq_date" value="${adminInq.admin_inq_date}" readonly />
				</div>
			</div>
			<div class="input-group">
				<label for="subject">제목</label>
				<input type="text" id="admin_inq_title" name="admin_inq_title" value="${adminInq.admin_inq_title}" readonly/>
			</div>
			<div class="input-group">
				<label for="content">답변</label>
				<textarea id="admin_reply" rows="10" name="admin_inq_reply" readonly>${adminInq.admin_reply}</textarea>
			</div>
			<div class="buttons">
				<button type="button" onclick="closePopUp()">확인</button>
			</div>
		</form>
	</div>
</body>
</html>
