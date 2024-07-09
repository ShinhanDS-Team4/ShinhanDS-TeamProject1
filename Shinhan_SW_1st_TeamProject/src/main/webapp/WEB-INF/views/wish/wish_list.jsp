<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>위시 리스트</title>
<script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<%-- 헤더,푸터 css --%>
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<%-- jquery 연결 --%>

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f9f9f9;
	color: #333;
}

.container {
	max-width: 800px;
	margin: 50px auto;
	padding: 20px;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
}

h1 {
	margin-bottom: 20px;
	text-align: center;
	font-size: 2em;
	color: #333;
}

.list-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-bottom: 2px solid #000;
	padding-bottom: 10px;
}

.checkbox-container {
	display: flex;
	align-items: center;
	margin: 10px 0;
}

.checkbox-container input[type="checkbox"] {
	margin-right: 10px;
}

.list-item {
	display: flex;
	align-items: center;
	padding: 15px 0;
	border-bottom: 1px solid #eee;
}

.list-item img {
	width: 80px;
	height: 80px;
	object-fit: cover;
	border-radius: 5px;
	margin-right: 20px;
}

.list-item-details {
	flex-grow: 1;
}

.list-item-details div {
	margin-bottom: 8px;
}

.list-item-price {
	text-align: center;
	width: 100px;
	font-size: 1.1em;
	color: #28a745;
}

.list-item-remove {
	text-align: center;
	width: 30px;
	cursor: pointer;
	color: #dc3545;
}

.list-item-remove:hover {
	color: #ff0000;
}

.btn-group {
	display: flex;
	justify-content: flex-end;
	margin-top: 20px;
}

.btn-group .btn {
	margin-left: 10px;
	padding: 10px 20px;
	font-size: 0.9em;
	border-radius: 5px;
	transition: background-color 0.3s ease;
}

.btn-group .btn-danger {
	background-color: #000000;
	color: white;
}

.btn-group .btn-danger:hover {
	background-color: #ff1a1a;
}

.btn-group .btn-secondary {
	background-color: #000000;
	color: white;
}

.btn-group .btn-secondary:hover {
	background-color: #ff1a1a;
}

.no-items {
	text-align: center;
	padding: 50px 0;
	font-size: 1.2em;
	color: #888;
}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container">
		<h1>위시 리스트</h1>
		<div class="list-header">
			<div class="checkbox-container">
				<input type="checkbox" id="selectAll"> <span>전체선택</span>
			</div>
			<div class="btn-group">
				<button class="btn btn-danger" id="deleteSelected">선택 삭제</button>
				<button class="btn btn-secondary" id="deleteAll">전체 삭제</button>
			</div>
		</div>

		<div class="table-container">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>선택</th>
                        <th>이미지</th>
                        <th>상품명</th>
                        <th>옵션</th>
                        <th>가격</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody id="wishList">
                    <c:choose>
                        <c:when test="${fn:length(wishItems) > 0}">
                            <c:forEach var="item" items="${wishItems}">
                                <tr data-id="${item.prod_id}">
                                    <td>
                                        <input type="checkbox" class="item-checkbox" value="${item.prod_id}">
                                    </td>
                                    <td>
                                        <a href="${path}/productDetail.do?prod_id=${item.prod_id}">
                                            <img src="${item.img_id}" alt="Product Image" width="80" height="80" style="object-fit: cover; border-radius: 5px;">
                                        </a>
                                    </td>
                                    <td>
                                        <a href="${path}/productDetail.do?prod_id=${item.prod_id}">
                                            <strong>상품명:</strong> <c:out value="${item.prod_name}" />
                                        </a>
                                    </td>
                                    <td><strong>옵션:</strong> <c:out value="${item.opt_name} ${item.opt_value}" /></td>
                                    <td><strong>가격:</strong> <c:out value="${item.prod_price}" /> 원</td>
                                    <td class="list-item-remove" data-id="${item.prod_id}" style="cursor: pointer; color: #dc3545;">&times;</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" class="text-center">위시 리스트에 항목이 없습니다.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

		<!-- <div class="btn-group">
            <button class="btn btn-primary btn-purchase">주문하기</button>
            <button class="btn btn-primary btn-purchase">대여하기</button>
        </div> -->
	</div>

	<script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
    <script>
        $(document).ready(function() {
            // 전체 선택 체크박스 클릭 이벤트
            $('#selectAll').click(function() {
                $('.item-checkbox').prop('checked', this.checked);
            });

            // 선택 삭제 버튼 클릭 이벤트
            $('#deleteSelected').click(function() {
                var selectedItems = [];
                $('.item-checkbox:checked').each(function() {
                    selectedItems.push($(this).val());
                });

                if (selectedItems.length > 0) {
                    deleteItems(selectedItems);
                }
            });

            // 전체 삭제 버튼 클릭 이벤트
            $('#deleteAll').click(function() {
                var allItems = [];
                $('.item-checkbox').each(function() {
                    allItems.push($(this).val());
                });

                if (allItems.length > 0) {
                    deleteItems(allItems);
                }
            });

            // 개별 삭제 버튼 클릭 이벤트
            $('.list-item-remove').click(function() {
                const itemId = $(this).data('id');
                deleteItems([itemId]);
            });

            function deleteItems(itemIds) {
                console.log(itemIds);
                $.ajax({
                    url: 'wishDeletet.do',
                    type: 'POST',
                    data: { ids: itemIds },
                    traditional: true,
                    success: function(response) {
                        // 성공적으로 삭제된 경우, 해당 항목을 UI에서 제거합니다.
                        console.log(response);
                        itemIds.forEach(id => {
                        	//console.log($(`[data-id="\${id}"]`));
                            $(`[data-id="\${id}"]`).remove();
                        });                        
                    },
                    error: function() {
                        alert('항목을 삭제하는 동안 오류가 발생했습니다.');
                    }
                });
            }
        });
    </script>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>
