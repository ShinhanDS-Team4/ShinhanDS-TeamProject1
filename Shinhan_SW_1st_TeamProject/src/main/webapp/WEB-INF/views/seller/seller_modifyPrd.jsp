<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자_상품수정</title>
<!-- 본문 css -->
<link rel="stylesheet" href="${path}/resources/css/style.css">
<!-- 헤더,푸터 css -->
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<!-- jquery 연결 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- 페이지용 css -->
<link rel="stylesheet" href="${path}/resources/css/prdAdd.css" />

<script>
	let fileCount = document.querySelectorAll('#prdImgFileContainer .file-item').length;
	const maxFileCount = 5;
	
	// 사진 업로드 추가
    function addFile() {
        if (fileCount >= maxFileCount) {
            alert("사진은 최대 5개까지 추가할 수 있습니다.");
            return;
        }

        // 새로운 파일 항목 생성
        const fileItem = document.createElement('div');
        fileItem.className = 'file-item';

        // 파일 선택 필드 생성
        const fileField = document.createElement('input');
        fileField.className = 'file-input';
        fileField.type = 'file';
        fileField.name = 'file';
        fileField.accept = '.jpg,.jpeg,.png';

        // 파일 항목 삭제 버튼 생성
        const fileRemove = document.createElement('button');
        fileRemove.className = 'file-remove';
        fileRemove.type = 'button';
        fileRemove.innerText = '삭제';
        fileRemove.onclick = function() {
            removeFile(this);
        };

        fileItem.appendChild(fileField);
        fileItem.appendChild(fileRemove);

        document.getElementById('prdImgFileContainer').appendChild(fileItem);

        fileCount = getFileItemCount();
    }

    function removeFile(button) {
        // 부모 요소(file-item) 제거
        button.parentNode.remove();

        fileCount = getFileItemCount();
    }

    function getFileItemCount() {
        return document.querySelectorAll('#prdImgFileContainer .file-item').length;
    }
	
</script>

</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<main>
		<aside>
			<ul>
				<li><a onclick="location.href='${path}/seller/MainPage.do'">통계</a></li>
				<li><a onclick="location.href='${path}/seller/PrdList.do'">판매/대여
						상품 목록</a></li>
				<li><a onclick="location.href='${path}/seller/DeliveryList.do'">주문/배송</a></li>
				<li><a onclick="location.href='${path}/seller/Q&AList.do'">문의
						목록</a></li>
			</ul>
		</aside>
		<section>
			<h2>마이페이지</h2>
			<hr />
			<div class="user-info">
				<input type="text" name="member_name" id="member_name"
					placeholder="김철수"> <input type="text" name="member_id"
					id="member_id" placeholder="573-50-00882">
			</div>

			<div class="container">

				<h1>상품 정보 수정</h1>

				<!-- <div class="form-group">
					<label>구분</label>
					<label><input type="radio" name="category" value="판매" >판매</label>
					<label><input type="radio" name="category" value="대여"> 대여</label>
				</div> -->

				<form method="post" action="/shoppingmall/seller/modifyPrdouct"
					enctype="multipart/form-data" accept-charset="UTF-8">
					<div class="form-group">
						<label>재고ID</label>
						<c:choose>
							<c:when test="${StockInfo.s_stock_id != null}">
								<input type="text" name="stockID"
									value="${StockInfo.s_stock_id}">
							</c:when>
							<c:when test="${StockInfo.r_stock_id != null}">
								<input type="text" name="stockID"
									value="${StockInfo.r_stock_id}">
							</c:when>
							<c:otherwise>
								<input type="text" name="stockID" value="">
							</c:otherwise>
						</c:choose>
					</div>
					<div class="form-group">
						<label>상품명</label> <input type="text" name="prdName"
							value="${ProductInfo.prod_name}">
					</div>
					<div class="form-group">
						<label>가격</label> <input type="number" name="prdPrice"
							value="${ProductInfo.prod_price}">
					</div>
					<div class="form-group">
						<label>카테고리</label> <select>
							<option value="">선택</option>
							<option value="category1">카테고리 1</option>
							<option value="category2">카테고리 2</option>
						</select>
					</div>
					<div class="form-group">
						<label>메인사진</label>
						<c:choose>
							<c:when
								test="${not empty ProdImgList and ProdImgList.size() > 0}">
								<input type="file" name="file" accept=".jpg,.jpeg,.png"
									value="${ProdImgList[0].img_id}">
							</c:when>
							<c:otherwise>
								<input type="file" name="file" accept=".jpg,.jpeg,.png">
							</c:otherwise>
						</c:choose>
					</div>
					<div class="form-group">
						<label>사진 등록</label>
						<button type="button" onclick="addFile()">사진 추가</button>
					</div>
					<c:forEach var="image" items="${ProdImgList}" varStatus="status">
						<c:if test="${status.index > 0}">
							<div class="file-item">
								<input type="file" class="file-input" name="file"
									accept=".jpg,.jpeg,.png" value="${image.img_id}">
								<button type="button" class="file-remove"
									onclick="removeFile(this)">삭제</button>
							</div>
						</c:if>
					</c:forEach>
					<!-- <div class="form-group file-list">
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
					</div> -->
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
						<label>재고량</label> <input type="text" name="prdStock">
					</div>
					<div class="buttons">
						<button type="submit">수정하기</button>
					</div>
				</form>
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