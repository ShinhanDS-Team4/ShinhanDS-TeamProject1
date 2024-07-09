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
	let mainImgFileCount = 0;//메인 사진 개수
	let descImgFileCount = 0;//설명 사진 개수

	//1.메인 사진 업로드 추가
	function addMainImgFile() {
		if (mainImgFileCount >= 5) {
			alert("메인 사진은 최대 5개까지 추가할 수 있습니다.");
			return;
		}

		// 새로운 파일 항목 생성
		const fileItem = document.createElement('div');
		fileItem.className = 'file-item';

		// 파일 선택 필드 생성
		const fileField = document.createElement('input');
		fileField.className = 'file-input';
		fileField.type = 'file';
		fileField.name = 'mainImgFile';
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
			removeMainFile(this);
		};

		fileItem.appendChild(fileField);
		fileItem.appendChild(fileRemove);

		document.getElementById('prdMainImgFileContainer')
				.appendChild(fileItem);

		mainImgFileCount = getMainFileItemCount();
	}

	function getMainFileItemCount() {
		return document.querySelectorAll('#prdMainImgFileContainer .file-item').length;
	}

	//2.설명사진 업로드 추가
	function addDescImgFile() {
		if (descImgFileCount >= 8) {
			alert("상품 설명 사진은 최대 8개까지 추가할 수 있습니다.");
			return;
		}

		// 새로운 파일 항목 생성
		const fileItem = document.createElement('div');
		fileItem.className = 'file-item';

		// 파일 선택 필드 생성
		const fileField = document.createElement('input');
		fileField.className = 'file-input';
		fileField.type = 'file';
		fileField.name = 'descImgFile';
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
			removeDescFile(this);
		};

		fileItem.appendChild(fileField);
		fileItem.appendChild(fileRemove);

		document.getElementById('prdDescImgFileContainer')
				.appendChild(fileItem);

		descImgFileCount = getDescFileItemCount();
	}

	function getDescFileItemCount() {
		return document.querySelectorAll('#prdDescImgFileContainer .file-item').length;
	}

	function removeMainFile(button) {
		// 부모 요소(file-item) 제거
		button.parentNode.remove();
		mainImgFileCount = getMainFileItemCount();
	}

	function removeDescFile(button) {
		// 부모 요소(file-item) 제거
		button.parentNode.remove();
		descImgFileCount = getDescFileItemCount();
	}

	function setProdDescribeImg(event, fileItem) {
		var file = event.target.files[0];
		var reader = new FileReader();
		reader.onload = function(event) {
			var imgContainer = document.createElement("div");
			imgContainer.classList.add("prdImgFile");
			var img = document.createElement("img");
			img.setAttribute("src", event.target.result);
			
			img.style.width = '300px';
			img.style.height = '400px';
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
		optionName.placeholder = '옵션명 입력';

		// 옵션값 입력 필드 생성
		const optionValue = document.createElement('input');
		optionValue.type = 'text';
		optionValue.name = 'optValue';
		optionValue.placeholder = '옵션값 입력';

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

	/* //URL 파라미터에서 메시지 가져오기
	const urlParams = new URLParams(window.location.search);
	const message = urlParams.get('PrdRegisterResult');

	if (message) {
		alert(message);
	} */

	//Depth = 1인 항목들에서 선택
	function firstDepth() {
		var selectedValue = document.getElementById("depth1").value;

		$.ajax({
			type : 'POST',
			url : '${path}/seller/find2ndCategoryList.do',
			contentType : 'application/json',
			data : JSON.stringify(selectedValue),
			success : function(response) {
				console.log(response);
				//location.reload();

				// depth2 요소가 이미 존재하는 경우 제거
				var existingSelect = document.getElementById('depth2');
				if (existingSelect) {
					existingSelect.remove();
				}


				// 새로운 <select> 요소 depth2 생성
				var newSelect = document.createElement('select');
				newSelect.className = 'prdCategory';
				newSelect.id = 'depth2'; // ID가 중복되지 않도록 확인 필요
				newSelect.setAttribute('onchange', 'secondDepth()');

				
				// Add default option
                var defaultOption = document.createElement('option');
                defaultOption.value = 0;
                defaultOption.textContent = '카테고리 선택';
                newSelect.appendChild(defaultOption);

				// Add options based on response
				response.forEach(function(category) {
					var option = document.createElement('option');
					option.value = category.category_id;
					option.textContent = category.category_name;
					newSelect.appendChild(option);
				});

				// categoryContainer에 새로운 <select> 추가
				var categoryContainer = document
						.querySelector('.categoryContainer');
				categoryContainer.appendChild(newSelect);
			},
			error : function(xhr, status, error) {
				console.error('AJAX 오류:', status, error);
			}
		})
	}

	function secondDepth() {
		var selectedValue = document.getElementById("depth2").value;

		$.ajax({
			type : 'POST',
			url : '${path}/seller/find3rdCategoryList.do',
			contentType : 'application/json',
			data : JSON.stringify(selectedValue),
			success : function(response) {
				console.log(response);
				//location.reload();
				
				// depth3 요소가 이미 존재하는 경우 제거
				var existingSelect = document.getElementById('depth3');
				if (existingSelect) {
					existingSelect.remove();
				}

				// 새로운 <select> 요소 depth3 생성
				var newSelect = document.createElement('select');
				newSelect.className = 'prdCategory';
				newSelect.id = 'depth3'; // ID가 중복되지 않도록 확인 필요
				newSelect.setAttribute('onchange', 'ThirdDepth()');

				// Add default option
                var defaultOption = document.createElement('option');
                defaultOption.value = 0;
                defaultOption.textContent = '카테고리 선택';
                newSelect.appendChild(defaultOption);
				
				// Add options based on response
				response.forEach(function(category) {
					var option = document.createElement('option');
					option.value = category.category_id;
					option.textContent = category.category_name;
					newSelect.appendChild(option);
				});

				// categoryContainer에 새로운 <select> 추가
				var categoryContainer = document
						.querySelector('.categoryContainer');
				categoryContainer.appendChild(newSelect);
			},
			error : function(xhr, status, error) {
				console.error('AJAX 오류:', status, error);
			}
		})
	}
	
	function ThirdDepth() {
		var selectedValue = document.getElementById("depth3").value;
		
		$.ajax({
			type : 'POST',
			url : '${path}/seller/find4thCategoryList.do',
			contentType : 'application/json',
			data : JSON.stringify(selectedValue),
			success : function(response) {
				console.log(response);
				//location.reload();
				
				// depth4 요소가 이미 존재하는 경우 제거
				var existingSelect = document.getElementById('depth4');
				if (existingSelect) {
					existingSelect.remove();
				}
				
				//case 1. response가 비어있는 경우 >> 3단계가 마지막 선택항목임
				if(response.length===0){
					document.getElementById('depth3').setAttribute('name', 'finalCategory');
				}else{//case 2. response가 비어있지 않은 경우 >> 해당 항목은 4단계 선택지가 있음
					
					// 새로운 <select> 요소 depth4 생성
					var newSelect = document.createElement('select');
					newSelect.className = 'prdCategory';
					newSelect.id = 'depth4'; // ID가 중복되지 않도록 확인 필요
					//newSelect.setAttribute('onchange', 'FourthDepth()');
					newSelect.setAttribute('name', 'finalCategory');
					
					// Add default option
	                var defaultOption = document.createElement('option');
	                defaultOption.value = 0;
	                defaultOption.textContent = '카테고리 선택';
	                newSelect.appendChild(defaultOption);

					// Add options based on response
					response.forEach(function(category) {
						var option = document.createElement('option');
						option.value = category.category_id;
						option.textContent = category.category_name;
						newSelect.appendChild(option);
					});

					// categoryContainer에 새로운 <select> 추가
					var categoryContainer = document
							.querySelector('.categoryContainer');
					categoryContainer.appendChild(newSelect);
				
				}
				
			},
			error : function(xhr, status, error) {
				console.error('AJAX 오류:', status, error);
			}
		})
	}
</script>

</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<main>
		<aside>
			<ul>
				<%-- <li><a onclick="location.href='${path}/seller/MainPage.do'">통계</a></li> --%>
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
				<p>${sellerInfo.member_name}</p>
				<p>${sellerInfo.member_id}</p>
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
						<label>상품명</label> <input id="prdPrice" type="text" name="prdName">
					</div>
					<div class="form-group">
						<label>가격</label> <input id="prdPrice" type="number" name="prdPrice">
					</div>

					<!-- 카테고리 -->
					<div class="form-group">
						<label>카테고리</label>
						<div class="categoryContainer">
							<select class="prdCategory" id="depth1" onchange="firstDepth()">
								<option value=0>선택 안함</option>
								<c:forEach var="category1" items="${depth1categoryList}">
									<option value="${category1.category_id}">${category1.category_name}</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<!-- 상품의 메인 사진으로 사용할 여러 개의 사진을 집어넣는 곳 -->
					<div class="form-group">
						<label>메인사진</label>
						<button type="button" id="addImageBtn" onclick="addMainImgFile()">사진
							추가</button>
					</div>
					<div id="prdMainImgFileContainer"></div>


					<!-- 상품 설명에 사용할 여러 개의 사진들을 집어넣는 곳  -->
					<div class="form-group">
						<label>상품 설명 사진 등록</label>
						<button type="button" id="addImageBtn" onclick="addDescImgFile()">사진
							추가</button>
					</div>
					<div id="prdDescImgFileContainer"></div>

					<div class="form-group">
						<label>상품설명</label>
					</div>
					<div class="form-group">
						<textarea rows="5" id="prdDescription" name="prdDescription"></textarea>
					</div>
					<div class="form-group options">
						<div class="form-option-title">
							<label>옵션</label>
							<button type="button" onclick="addOption()">옵션 추가</button>
						</div>
						<div id="optionsContainer"></div>
					</div>
					<div class="form-group">
						<label style="display: inline-block; width: 100px;">재고량</label>
						<input id="prdPrice" type="number" name="prdStock">
						<label style="display: inline-block; width: 100px;">개</label>
					</div>
					<div class="buttons">
						<button type="submit">등록하기</button>
					</div>
				</form>
			</div>
		</section>

		<!-- 여기부터는 오른쪽에 있는 알림버튼창 관련 -->
		<%-- <aside class="notifications">
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
		</aside> --%>
	</main>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>