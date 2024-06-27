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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- 사진의 순서 변경에 사용 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.14.0/Sortable.min.js"></script>
<!-- 페이지용 css -->
<link rel="stylesheet" href="${path}/resources/css/prdAdd.css" />


<script>
	let optionCount = 0;//기존 옵션 개수
	let fileCount = 0;

	//사진 업로드 추가
	function addFile() {
		if (fileCount >= 5) {
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
		fileField.onchange = function(event) {
			setProdDescribeImg(event, fileItem);
        };

		//파일 항목 삭제 버튼 생성
		const fileRemove = document.createElement('button');
		fileRemove.classname = 'file-remove';
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

	function setProdDescribeImg(event, fileItem) {
		var file = event.target.files[0];
		var reader = new FileReader();

		reader.onload = function(event) {
			var imgContainer = document.createElement("div");
			imgContainer.classList.add("prdImgFile");

			var img = document.createElement("img");
			img.setAttribute("src", event.target.result);

			imgContainer.appendChild(img);
			
			fileItem.appendChild(imgContainer);
		};

		reader.readAsDataURL(file);
	}

	//옵션 항목 추가
	function addOption() {
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
		optionName.id = 'option-name';
		optionName.name = 'optName';
		optionName.placeholder = '옵션명 ' + optionCount;

		// 옵션값 입력 필드 생성
		const optionValue = document.createElement('input');
		optionValue.type = 'text';
		optionValue.name = 'optValue';
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

	//URL 파라미터에서 메시지 가져오기
	const urlParams = new URLParams(window.location.search);
	const message = urlParams.get('PrdRegisterResult');

	if (message) {
		alert(message);
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
				<p>김철수</p>
				<!-- 판매자 회원의 이름 -->
				<p>573-50-00882</p>
				<!-- 판매자 회원의 ID(사업자등록번호) -->
			</div>

			<div class="container">
				<div class="header">
					<h1>상품 등록</h1>
				</div>
				<form method="post" action="/shoppingmall/seller/uploadPrd"
					enctype="multipart/form-data" accept-charset="UTF-8">
					<div class="form-group">
						<label>구분</label> <label><input type="radio"
							name="prdType" value="판매">판매</label> <label><input
							type="radio" name="prdType" value="대여">대여</label>
					</div>
					<div class="form-group">
						<label>상품명</label> <input type="text" name="prdName">
					</div>
					<div class="form-group">
						<label>가격</label> <input type="number" name="prdPrice">
					</div>
					<div class="form-group">
						<label>카테고리</label> <select name="prdCategory">
							<option value="">선택</option>
							<option value=1>카테고리 1</option>
							<option value=2>카테고리 2</option>
						</select>
					</div>
					<div class="form-group">
						<label>메인사진</label> <input type="file" name="file"
							accept=".jpg,.jpeg,.png" onchange="setMainProdIMG(event);">
						<div id="image_container"></div>

						<script>
							function setMainProdIMG(event) {
								var reader = new FileReader();

								reader.onload = function(event) {
									// Create a container for the image and the delete button
									var imgContainer = document
											.createElement("div");
									imgContainer.classList.add("image-preview");

									// Create the image element
									var img = document.createElement("img");
									img
											.setAttribute("src",
													event.target.result);

									// Create the delete button
									var deleteButton = document
											.createElement("button");
									deleteButton.textContent = "삭제";
									deleteButton.onclick = function() {
										imgContainer.remove();
									};

									// Append the image and delete button to the container
									imgContainer.appendChild(img);
									imgContainer.appendChild(deleteButton);

									// Append the container to the image_container div
									document.querySelector(
											"div#image_container").appendChild(
											imgContainer);
								};

								reader.readAsDataURL(event.target.files[0]);
							}
						</script>
					</div>

					<!-- 상품 설명에 사용할 여러 페이지를  -->
					<div class="form-group">
						<label>상품 설명 사진 등록</label>
						<button type="button" onclick="addFile()">사진 추가</button>
					</div>
					<div id="prdImgFileContainer"></div>

					<div class="form-group">
						<label>상품설명</label>
					</div>
					<div class="form-group">
						<textarea rows="5" name="prdDescription"></textarea>
					</div>
					<div class="form-group options">
						<div class="form-option-title">
							<label>옵션</label>
							<button type="button" onclick="addOption()">옵션 추가</button>
						</div>
						<div id="optionsContainer"></div>
					</div>
					<div class="form-group">
						<label>재고량</label> <input type="text" name="prdStock">
					</div>
					<div class="buttons">
						<button type="submit">등록하기</button>
					</div>
				</form>
			</div>
		</section>

		<!-- 여기부터는 오른쪽에 있는 알림버튼창 관련 -->
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