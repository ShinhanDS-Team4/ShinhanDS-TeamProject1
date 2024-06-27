<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>판매자 상세</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/admin/admin_page.css" rel="stylesheet">
</head>
<body>
<jsp:include page="common.jsp" />
    <div class="content">
        <div class="container-fluid">
            <h1>판매자 상세</h1>
            <h2>${seller_name}</h2>
            <p>금지 상품을 올렸을 경우 관리자가 판매자의 상품을 임의로 삭제 후 판매자에게 통지</p>
            <div class="table-container">
                <table class="table table-striped">
                    <thead>
                        <tr>
                        	<th>등록일</th>
                            <th>상품 이미지</th>
                            <th>상품명</th>
                            <th>상품 설명</th>
                            <th>가격</th>
                            <th>재고</th>                        
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="product" items="${products}">
                        <tr>
                            <td>${prod_added_date}</td>
                            <td><img src="${img_id}" alt="Product ${img_id}" style="width: 50px;"></td>
                            <td>${prod_name}</td>
                            <td>${prod_desc}</td>
                            <td>${prod_price}</td>
                            <td>${s_p_stock}</td>
                            <td><button class="btn btn-sm btn-danger" onclick="productdelete(${prod_id})">삭제</button></td>
                        </tr>                
                        </c:forEach>     
                    </tbody>
                </table>
            </div>
        </div>
    </div>
	<script>
        function deleteProduct(prod_id) {
            if (confirm('정말로 이 상품을 삭제하시겠습니까?')) {
                window.location.href = 'product_delete?prod_id=' + prod_id;
            }
        }
    </script>
</body>
</html>
