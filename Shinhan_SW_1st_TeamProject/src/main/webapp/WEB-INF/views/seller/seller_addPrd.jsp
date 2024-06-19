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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- 페이지용 css -->
<link rel="stylesheet" href="${path}/resources/css/prdAdd.css" />


<script>
	let optionCount = 0;//기존 옵션 개수
	
	function addOption(){
		if (optionCount >= 5) {
            alert("옵션은 최대 5개까지 추가할 수 있습니다.");
            return;
        }
		
		// 새로운 옵션 항목 생성
        const optionItem = document.createElement('div');
        optionItem.className = 'option-item';

        // 옵션명 입력 필드 생성
        const optionName = document.createElement('input');
        optionName.type = 'text';
        optionName.id = 'option-name'
        optionName.placeholder = '옵션명 ' + optionCount;

        // 옵션값 입력 필드 생성
        const optionValue = document.createElement('input');
        optionValue.type = 'text';
        optionValue.placeholder = '옵션값 ' + optionCount;

        // 삭제 버튼 생성
        const removeButton = document.createElement('button');
        removeButton.type = 'button';
        removeButton.innerText = '삭제';
        removeButton.onclick = function() {
            removeOption(this);
        };

        // 옵션 항목에 추가
        optionItem.appendChild(optionName);
        optionItem.appendChild(optionValue);
        optionItem.appendChild(removeButton);

        // 옵션 컨테이너에 추가
        document.getElementById('optionsContainer').appendChild(optionItem);
        
        optionCount = getOptionItemCount();
	}
	
	function removeOption(button) {
        // 부모 요소(option-item) 제거
        button.parentNode.remove();
        
        optionCount = getOptionItemCount();
    }
	
	function getOptionItemCount() {
        return document.querySelectorAll('#optionsContainer .option-item').length;
    }
</script>

</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<main>
		<aside>
			<ul>
				<li><a onclick="location.href='${path}/seller/MainPage.do'">통계</a></li>
				<li><a onclick="location.href='${path}/seller/PrdList.do'">판매/대여 상품 목록</a></li>
				<li><a onclick="location.href='${path}/seller/DeliveryList.do'">주문/배송</a></li>
				<li><a onclick="location.href='${path}/seller/Q&AList.do'">문의 목록</a></li>
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
				
				<!-- 오늘 할 일 : branch 테스트, 사진 파일 DB 업로드 사전작업(BLOB 형식으로 변환) -->
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
						<label>옵션</label>
						<button type="button" onclick="addOption()">옵션 추가</button>
					</div>
					<div id="optionsContainer">
						
					</div>
				</div>
				<div class="form-group">
					<label>재고량</label> <input type="text">
				</div>
				<div class="buttons">
					<button type="button">등록하기</button>
				</div>
			</div>
		</section>
		<aside class="notifications">
			<div class="notify_icon">
				<img src="${path}/resources/images/bell.png" alt="알림"
					class="bell_icon" />
				<div class="icon">
					<span>15</span>
				</div>
				<div class="popup">
					<p>결제 완료 주문 : 5건</p>
					<p>결제 대기 주문 : 23건</p>
				</div>
			</div>
		</aside>
	</main>
	<script>
		document.querySelector(".notifications .bell_icon").addEventListener(
				"click",
				function() {
					document.querySelector(".notifications .popup").classList
							.toggle("show");
				});
	</script>
	<style>
.notifications .popup.show {
	display: block;
}
</style>
</body>
</html>