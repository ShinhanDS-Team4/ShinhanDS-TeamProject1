<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>관리자 문의 작성</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	function submitForm(){
		$.ajax({
			url:'/shoppingmall/seller/addAdminQA.do',
			data:$("#registerAQ").serialize(),
			type:'POST',
			success: function(responseData){
				alert(responseData);
				window.close();
			},error:function(responseData){
				alert("실패");
			}
		});
	}

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
		<form id="registerAQ" method="post" action="/shoppingmall/seller/registerStoAquestion"
			enctype="multipart/form-data" accept-charset="UTF-8">
			<div class="info">
				<div>
					<label>판매자ID</label>
					<input type="text" name="member_id" id="member_id" value="${aqa.member_id}" />
				</div>
				<div>
					<label>판매자명</label>
					<input type="text" name="member_name" id="member_name" value="${aqa.member_name}" />
				</div>
				<div>
					<label>전화번호</label>
					<input type="text" name="phone" id="phone" value="${aqa.phone}" />
				</div>
			</div>
			<div class="input-group">
				<label for="subject">제목</label>
				<input type="text" id="admin_inq_title" name="admin_inq_title"/>
			</div>
			<div class="input-group">
				<label for="content">내용작성</label>
				<textarea id="admin_inq_content" rows="10" name="admin_inq_content"></textarea>
			</div>
			<div class="buttons">
				<button type="button" onclick="submitForm()">등록</button>
				<button type="button" onclick="closePopUp()">닫기</button>
			</div>
		</form>
	</div>
</body>
</html>
