<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자_상품추가</title>
<!-- 본문 css -->
<link rel="stylesheet" href="${path}/resources/css/style.css">
<!-- 헤더,푸터 css -->
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<!-- jquery 연결 -->
<script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Slick 불러오기 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
<!-- Slick 직접 연결 -->
<link rel="stylesheet" href="${path}/resources/slick/slick-theme.css">
<link rel="stylesheet" href="${path}/resources/slick/slick.css">
<!-- 페이지용 css -->
<link rel="stylesheet" href="${path}/resources/css/prdAdd.css" />
<script src="${path}/resources/slick/slick.min.js"></script>
</head>
<body>
	<main>
		<aside>
			<ul>
				<li><a href="#">통계</a></li>
				<li><a href="#">판매 상품 목록</a></li>
				<li><a href="#">대여 상품 목록</a></li>
				<li><a href="#">주문/배송</a></li>
				<li><a href="#">문의 목록</a></li>
			</ul>
		</aside>
		<section>
			<h2>마이페이지</h2>
			<hr />
			<div class="user-info">
				<p>김철수</p>
				<p>573-50-00882</p>
			</div>

			<div class="container">
				<div class="header">
					<h1>상품 등록</h1>
				</div>
				<div class="form-group">
					<label>구분</label> <label><input type="radio"
						name="category" value="판매"> 판매</label> <label><input
						type="radio" name="category" value="대여"> 대여</label>
				</div>
				<div class="form-group">
					<label>상품명</label> <input type="text">
				</div>
				<div class="form-group">
					<label>가격</label> <input type="text">
				</div>
				<div class="form-group">
					<label>카테고리</label> <select>
						<option value="">선택</option>
						<option value="category1">카테고리 1</option>
						<option value="category2">카테고리 2</option>
					</select>
				</div>
				<div class="form-group">
					<label>메인사진</label> <input type="file">
				</div>
				<div class="form-group">
					<label>사진 등록</label> <input type="file">
				</div>
				<div class="form-group file-list">
					<table>
						<thead>
							<tr>
								<th>순서</th>
								<th>파일명</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>001</td>
								<td>파일명_102939_asdjk.jpg</td>
								<td><button type="button">삭제</button></td>
							</tr>
							<tr>
								<td>002</td>
								<td>파일명_102939_asdjk.jpg</td>
								<td><button type="button">삭제</button></td>
							</tr>
							<tr>
								<td>003</td>
								<td>파일명_102939_asdjk.jpg</td>
								<td><button type="button">삭제</button></td>
							</tr>
							<tr>
								<td>004</td>
								<td>파일명_102939_asdjk.jpg</td>
								<td><button type="button">삭제</button></td>
							</tr>
							<tr>
								<td>005</td>
								<td>파일명_102939_asdjk.jpg</td>
								<td><button type="button">삭제</button></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="form-group">
					<label>상품설명</label>
				</div>
				<div class="form-group">

					<textarea rows="5"></textarea>
				</div>

				<div class="form-group options">
					<div class="form-option-title">
						<label>옵션선택</label>
						<button type="button" onclick="addOption()">옵션 추가</button>
					</div>

					<div id="optionsContainer">
						<div class="option-item">
							<input type="text" id="option-name" placeholder="옵션명 1">
							<input type="text" placeholder="옵션값 1">
							<button type="button" onclick="removeOption(this)">-</button>
						</div>
						<div class="option-item">
							<input type="text" id="option-name" placeholder="옵션명 2">
							<input type="text" placeholder="옵션값 2">
							<button type="button" onclick="removeOption(this)">-</button>
						</div>
						<div class="option-item">
							<input type="text" id="option-name" placeholder="옵션명 3">
							<input type="text" placeholder="옵션값 3">
							<button type="button" onclick="removeOption(this)">-</button>
						</div>
					</div>
					<div class="add-option"></div>
				</div>
				<div class="form-group">
					<label>재고량</label> <input type="text">
				</div>
				<div class="buttons">
					<button type="button">등록하기</button>
				</div>
			</div>
			</div>
		</section>
		<aside class="notifications">
			<div class="icon">
				<span>15</span>
			</div>
			<div class="popup">
				<p>예약한 공용공간에서 대기 중입니다.</p>
				<p>공용공간 3층 카운터에서 확인하세요.</p>
				<p>문의사항은 전화로 연락 바랍니다. 02-0000-0000</p>
			</div>
		</aside>
	</main>
</body>
</html>