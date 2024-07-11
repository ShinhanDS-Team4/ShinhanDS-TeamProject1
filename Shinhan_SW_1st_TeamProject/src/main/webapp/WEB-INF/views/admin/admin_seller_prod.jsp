<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>판매자 판매 상품 조회</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="common.jsp" />
    <div class="content">
        <div class="container-fluid">
            <h1>판매자 판매 상품 조회</h1>
            <%-- <h2>${seller_name}</h2> --%>
            <p>금지 상품을 올렸을 경우 관리자가 판매자의 상품을 임의로 삭제 후 판매자에게 통지합니다.</p>
            
            <form id="searchForm" class="form-inline mb-3">
                <input type="text" name="searchType2" id="searchType2" placeholder="판매자나 상품 또는 브랜드" class="form-control mr-2">
                <input type="button" class="btn btn-primary" onclick="searchProducts()" value="검색"/>
                <input type="button" class="btn btn-secondary ml-2" onclick="resetSearch()" value="초기화"/>                
            </form>

            <div class="table-container">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>등록일</th>
                            <th>상품 이미지</th>
                            <th>상품명</th>
                            <th>상품 설명</th>
                            <th>가격</th>
                            <th>상품 재고</th>
                            <th>판매자 명</th>
                            <th>브랜드</th>                        
                            <th>연락처</th>                         
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody id="productList">
                        <c:forEach var="product" items="${products}">
                        <tr>
                            <td>${product.prod_added_date}</td>
                            <td><img src="${product.img_id}" alt="Product ${product.img_id}" style="width: 50px;"></td>
                            <td>${product.prod_name}</td>
                            <td>${product.prod_desc}</td>
                            <td>${product.prod_price}</td>
                            <td>${product.stock}</td>
                            <td>${product.member_name}</td>
                            <td>${product.brand}</td>
                            <td>${product.phone}</td>
                            <td><button class="btn btn-sm btn-danger" onclick="deleteProduct(${product.prod_id})">삭제</button></td>
                        </tr>                
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
 
    <script>
        function searchProducts() {
            var searchType = $('#searchType2').val();
            alert("aaa:"+searchType);
            $.ajax({
                url: 'search_seller_product_brand',
                type: 'GET',
                data: { searchType: searchType },
                success: function(response) {
                	console.log(response);
                    $('#productList').html(response);
                },
                error: function() {
                    alert('상품 검색에 실패했습니다.');
                }
            });
        }

        function resetSearch() {
            $('#searchType').val('');
            searchProducts();
        }

        function deleteProduct(prod_id) {
            if (confirm('정말로 이 상품을 삭제하시겠습니까?')) {
                window.location.href = 'product_delete?prod_id=' + prod_id;
            }
        }
    </script>
</body>
</html>
