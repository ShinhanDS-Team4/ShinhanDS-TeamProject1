<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>   
	<link rel="stylesheet" type="text/css" href="../resources/css/header_footer.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>신상품</title>
    <style> 
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #ffffff; 
            flex-direction: column;
            min-height: 100vh;
        }  

        .container { 
            justify-content: space-between;
            align-items: flex-start;
            padding: 20px; 
        }

        .inner {
            max-width: 1300px;
            margin: 0 auto;
        }

        .title {
            padding: 20px;
        }

        .title h1 {
            display: inline-block;
            margin: 0;
        }

        .title h1 span {
            font-size: 14px;
            color: black;
            margin-left: 10px;
        }

        .separator {
            border-bottom: 1px solid black;
            margin: 0 20px;
        }

        nav ul {
            list-style: none;
            padding: 0;
            margin: 10px 20px 0;
        }

        nav ul li {
            display: inline;
            margin-right: 10px;
        }

        nav ul li a {
            text-decoration: none;
            color: black;
        }

        .filters {
            margin: 20px;
        }

        .filters select {
            margin-right: 10px;
        }

        .products {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            padding: 20px;
        }

        .product {
            padding: 10px;
            width: calc(25% - 20px);
            box-sizing: border-box;
            text-align: left; 
        }

        .product img {
            max-width: 100%;
            height: auto;
        }

        .product p {
            margin: 10px 0;
        }

        .product button {
            background: none;
            border: none;
            font-size: 20px;
            cursor: pointer;
        }

        .pagination {
            display: flex;
            justify-content: center;
            padding: 20px 0;
        }

        .pagination button {
            margin: 0 5px;
            padding: 5px 10px;
            border: 1px solid transparent;  
            background-color: #fff;
            cursor: pointer;
        }

        .pagination button.active {
            font-weight: bold;
        }

        .pagination button:disabled {
            cursor: not-allowed;
            opacity: 0.5;
        }

        .pagination button.arrow {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <%@ include file="../common/header.jsp"%> 
    <div class="container">
        <div class="main-content inner">
            <div class="title">
                <h1>신상품 <span>10,106개 상품</span></h1>
            </div>
            <div class="separator"></div>
            <nav>
                <ul>
                    <li><a href="#">전체</a></li>
                    <li><a href="#">아우터</a></li>
                    <li><a href="#">정장</a></li>
                    <li><a href="#">팬츠</a></li>
                    <li><a href="#">재킷/베스트</a></li>
                    <li><a href="#">셔츠</a></li>
                    <li><a href="#">니트</a></li>
                    <li><a href="#">티셔츠</a></li>
                </ul>
            </nav>
            <div class="filters">
                <select>
                    <option>브랜드</option>
                </select>
                <select>
                    <option>가격</option>
                </select>
                <select>
                    <option>사이즈</option>
                </select>
                <select>
                    <option>색상</option>
                </select>
            </div>
            
            <section class="products" id="product-list">
                <!-- Products will be dynamically inserted here -->
            </section>
            
            <div class="pagination" id="pagination">
                <!-- Pagination buttons will be dynamically inserted here -->
            </div>
        </div>
    </div>
    <%@ include file="../common/footer.jsp"%>

    <script>
        const products = [];

        // JSP에서 서버 데이터 받아오기
        <c:forEach var="product" items="${prodAllOrders}">
            products.push({
                img_url: '${product.IMG_URL}',
                brand: '${product.BRAND}',
                prod_name: '${product.PROD_NAME}',
                prod_price: '${product.PROD_PRICE}'
            });
        </c:forEach>

        // console.log(products); // products 배열 확인

        const productsPerPage = 12;
        let currentPage = 1;

        const renderProducts = () => {
            const productList = document.getElementById('product-list');
            productList.innerHTML = '';
            const start = (currentPage - 1) * productsPerPage;
            const end = start + productsPerPage;
            const paginatedProducts = products.slice(start, end);
            
            paginatedProducts.forEach(product => {
                const productDiv = document.createElement('div');
                productDiv.classList.add('product');
                productDiv.innerHTML = `
                    <img src='${product.IMG_URL}' alt='상품 이미지'>
                    <p>${product.brand}</p>
                    <p>${product.prod_name}</p>
                    <p>${product.prod_price}원</p>
                    <button>❤</button>
                `;
                console.log(product.brand);
                
                productList.appendChild(productDiv);
            });
        };

        const renderPagination = () => {
            const pagination = document.getElementById('pagination');
            pagination.innerHTML = '';
            const totalPages = Math.ceil(products.length / productsPerPage);

            const createButton = (text, pageNumber, disabled = false) => {
                const button = document.createElement('button');
                button.innerText = text;
                button.disabled = disabled;
                button.classList.toggle('active', pageNumber === currentPage);
                button.addEventListener('click', () => {
                    currentPage = pageNumber;
                    renderProducts();
                    renderPagination();
                });
                return button;
            };

            pagination.appendChild(createButton('<<', 1, currentPage === 1));
            pagination.appendChild(createButton('<', currentPage - 1, currentPage === 1));
            for (let i = 1; i <= totalPages; i++) {
                pagination.appendChild(createButton(i, i));
            }
            pagination.appendChild(createButton('>', currentPage + 1, currentPage === totalPages));
            pagination.appendChild(createButton('>>', totalPages, currentPage === totalPages));
        };

        document.addEventListener('DOMContentLoaded', () => {
            renderProducts();
            renderPagination();
        });
    </script>
</body>
</html>
