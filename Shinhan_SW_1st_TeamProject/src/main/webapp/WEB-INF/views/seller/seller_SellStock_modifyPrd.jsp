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
<style>
.hidden {
	display: none;
}
</style>
<script>
	let fileCount = document
			.querySelectorAll('#prdImgFileContainer .file-item').length;
	const maxFileCount = 5;

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
			removeFile(this);
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
			removeFile(this);
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

	function removeFile(button) {
		// 부모 요소(file-item) 제거
		button.parentNode.remove();
		fileCount = getFileItemCount();
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

	//메인사진 미리보기 삭제 및 데이터 초기화
	function resetMainProdImg() {
		var prodid = '${ProductInfo.prod_id}';
		if(confirm('상품의 메인 사진 목록을 초기화할까요?')){
		$.ajax({
			type : "POST",
			url : "/shoppingmall/seller/resetMainProdImg",
			contentType: 'application/json',
			data: JSON.stringify({prodid:prodid}),
			success : function(response) {
				// 서버에서 반환한 문자열에 따라 처리
				if (response === "resetImgSuccess") {
					console.log("상품 메인 이미지 목록 초기화 성공");
					// 성공했을 때 추가적인 작업 수행
					// 예: 다른 UI 업데이트, 메시지 표시 등
					document.getElementById('mainImgSection').classList.remove('hidden');
					$("#prdMainImgPreview").empty();
				} else if (response === "resetImgFail") {
					console.log("이미지 초기화 실패");
					// 실패했을 때의 처리
					// 예: 경고 메시지 표시 등
				} else {
					console.log("알 수 없는 응답: " + response);
					// 다른 응답에 대한 처리
				}
			},
			error : function(xhr, status, error) {
				console.error(error);
				// 실패 시 처리
			}
		});
		}
	}

	//설명사진 미리보기 삭제 및 데이터 초기화
	function resetDescProdImg() {
		var prodid = '${ProductInfo.prod_id}';
		if(confirm('상품의 설명 사진 목록을 초기화할까요?')){
		alert(prodid);
		$.ajax({
			type : "POST",
			url : "/shoppingmall/seller/resetDescProdImg",
			contentType: 'application/json',
			data: JSON.stringify({prodid:prodid}),
			success : function(response) {
				// 서버에서 반환한 문자열에 따라 처리
				if (response === "resetImgSuccess") {
					console.log("상품 메인 이미지 초기화 성공");
					// 성공했을 때 추가적인 작업 수행
					// 예: 다른 UI 업데이트, 메시지 표시 등
					document.getElementById('descImgSection').classList.remove('hidden');
					$("#prdDescImgPreview").empty();
				} else if (response === "resetImgFail") {
					console.log("이미지 초기화 실패");
					// 실패했을 때의 처리
					// 예: 경고 메시지 표시 등
				} else {
					console.log("알 수 없는 응답: " + response);
					// 다른 응답에 대한 처리
				}
			},
			error : function(xhr, status, error) {
				console.error(error);
				// 실패 시 처리
			}
		});
		}
	}
	
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

				<h1>상품 정보 수정</h1>
				<form method="post" action="/shoppingmall/seller/modifyPrdouct"
					enctype="multipart/form-data" accept-charset="UTF-8">
					
					<div class="form-group">
						<label style="display: inline-block; width: 100px;">상품ID</label>
						<input class="unchangedInput" type="text" name="prdId"
							value="${ProductInfo.prod_id}">
					</div>
					
					<div class="form-group">
						<label style="display: inline-block; width: 100px;">상품명</label>
						<input class="unchangedInput" type="text" name="prdName"
							value="${ProductInfo.prod_name}">
					</div>
					<div class="form-group">
						<label style="display: inline-block; width: 100px;">가격</label>
						<input id="prdPrice" type="number" name="prdPrice"
							value="${ProductInfo.prod_price}">
						<label style="display: inline-block; width: 100px;">원</label>
					</div>
					
					<!-- 카테고리 -->
					<div class="form-group">
						<label style="display: inline-block; width: 100px;">카테고리</label>
						<p class="category" style="display: inline-block; margin: 0;">${CategoryInfo.category_name}</p>
						<div class="categoryContainer">
							<select class="prdCategory" id="depth1" onchange="firstDepth()">
								<option value=0>선택 안함</option>
								<c:forEach var="category1" items="${depth1categoryList}">
									<option value="${category1.category_id}">${category1.category_name}</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<!-- 메인 사진 미리보기 구역 : DB 및 서버 저장소에 등록되어 있는 사진 파일들을 미리보기로 보여준다 -->
					<div id="prdMainImgPreview">
						<div class="form-group">
							<label style="display: inline-block; width: 100px;">메인 사진목록</label>
							<button type="button" id="addImageBtn" onclick="resetMainProdImg()">사진 항목 초기화</button>
						</div>
						<div id="prdMainImgFileContainer">
							<c:forEach var="mainImgName" items="${ProdMainImgList}">
								<img src="http://localhost:9090/saren/ProdImgFile/main/${mainImgName}"
									width="300" height="400">
							</c:forEach>
						</div>
					</div>
					
					<!-- 메인 사진 추가 구역 : 사진 재등록을 선택하면 활성화 & 화면에 표시됨 -->
					<div id="mainImgSection" class="hidden">
						<div class="form-group">
							<label style="display: inline-block; width: 100px;">메인사진</label>
							<button type="button" id="addImageBtn" onclick="addMainImgFile()">사진 추가</button>
						</div>
						<div id="prdMainImgFileContainer"></div>
					</div>

					<!-- 설명 사진 미리보기 구역 : DB 및 서버 저장소에 등록되어 있는 사진 파일들을 미리보기로 보여준다 -->
					<div id="prdDescImgPreview">
						<div class="form-group">
							<label style="display: inline-block; width: 100px;">설명 사진목록</label>
							<button type="button" id="addImageBtn" onclick="resetDescProdImg()">사진 항목 초기화</button>
						</div>
						<div id="prdDescImgFileContainer">
							<c:forEach var="imgName" items="${ProdDescImgList}">
								<img
									src="http://localhost:9090/saren/ProdImgFile/desc/${imgName}"
									width="300" height="400">
							</c:forEach>
						</div>
					</div>
					
					<!-- 설명 사진 추가 구역 : 사진 재등록을 선택하면 활성화 & 화면에 표시됨 -->
					<div id="descImgSection" class="hidden">
						<div class="form-group">
							<label style="display: inline-block; width: 100px;">상품 설명 사진 등록</label>
							<button type="button" id="addImageBtn" onclick="addDescImgFile()">사진 추가</button>
						</div>
						<div id="prdDescImgFileContainer"></div>
					</div>

					<div class="form-group">
						<label>상품설명</label>
					</div>
					<div class="form-group">
						<textarea rows="5" id="prdDescription" name="prdDescription">
						${ProductInfo.prod_desc}</textarea>
					</div>
					
					<hr>
					
					<h1>판매용 재고 정보 조회 / 재고 수정</h1>
					<div class="form-group">
						<label style="display: inline-block; width: 100px;">재고명</label>
						<input class="unchangedInput" type="text" name="stockid"
							value="${StockInfo.s_stock_id}">
					</div>

					<div class="form-group">
						<label>해당 재고의 옵션 목록</label>
					</div>
					<div class="optionList" id="optionList">
						<table id="optionTable">
							<thead>
								<tr>
									<th>옵션명</th>
									<th>옵션값</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="option" items="${optionList}">
									<tr>
										<td>${option.opt_name}</td>
										<td>${option.opt_value}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<div class="form-group">
						<label style="display: inline-block; width: 100px;">재고량</label>
						<input id="prdPrice" type="number" name="prdStock" value = "${StockInfo.stock}">
						<label style="display: inline-block; width: 100px;">개</label>
					</div>
					<div class="buttons">
						<button type="submit">수정하기</button>
					</div>
				</form>
			</div>
		</section>
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