<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>구매자 문의</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	function submitForm(){
		alert($("#answerCQ").serialize());
		$.ajax({
			url:'/shoppingmall/seller/answerCustomer.do',
			data:$("#answerCQ").serialize(),
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
}

.input-group {
	margin: 20px 0;
}

.input-group label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
}

.info input {
	border: none;
	outline: none;
	font-size: 15px;
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
		<h1>구매자 문의</h1>

		<form id="answerCQ" method="post" action="/shoppingmall/seller/answerCustomer.do">
			<div class="info">
				<div>
					<label>문의ID</label>
					<input class="inqid-class" type="number" readonly="readonly" 
					id="buyer_inq_id" name="buyer_inq_id" value="${bqa.buyer_inq_id}"
						placeholder="문의ID"/>
				</div>
				<div>
					<label>구매자ID</label>
					<input type="text" readonly="readonly" id="member_id" name="member_id" value="${bqa.member_id}" placeholder="구매자ID" />
				</div>
				<div>
					<label>구매자명</label>
					<input type="text" readonly="readonly"
						value="${bqa.member_name}" placeholder="구매자명" />
				</div>
				<div>
					<label>전화번호</label>
					<input type="text" readonly="readonly"
						value="${bqa.phone}" placeholder="전화번호" />
				</div>
			</div>
			<div class="input-group">
				<label for="subject">제목</label>
				<input type="text" name="buyer_inq_title" id="buyer_inq_title" readonly="readonly" value="${bqa.buyer_inq_title}" />
			</div>
			<div class="input-group">
				<label for="inquiry">문의내용</label>
				<textarea id="buyer_inq_content" name="buyer_inq_content" readonly="readonly"
					rows="5">${bqa.buyer_inq_content}</textarea>
			</div>
			<div class="input-group">
				<label for="response">답변작성</label>
				<textarea id="buyer_reply" name="buyer_reply" rows="5" maxlength="3000">${bqa.buyer_reply}</textarea>
			</div>
			<div class="buttons">
				<button type="button" id="registerBtn" onclick="submitForm()">등록</button>
				<button type="button" onclick="closePopUp()">닫기</button>
			</div>
		</form>
	</div>
</body>
</html>