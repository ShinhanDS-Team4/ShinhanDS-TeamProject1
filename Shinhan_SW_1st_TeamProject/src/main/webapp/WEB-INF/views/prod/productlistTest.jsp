<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<script>
    /* 한 페이지에 보여줄 상품수 */
    const productsPerPage = 12;  
    let currentPage = 1;
    const products = [
        {img: "bracelet.png", brand: "브랜드명", name: "상품이름", description: "상세설명상세설명", price: "20,000원"},
        {img: "shirt.png", brand: "브랜드명", name: "상품이름", description: "상세설명상세설명", price: "20,000원"},
        {img: "shirt.png", brand: "브랜드명", name: "상품이름", description: "상세설명상세설명", price: "20,000원"},
        {img: "shirt.png", brand: "브랜드명", name: "상품이름", description: "상세설명상세설명", price: "20,000원"},
        {img: "shirt.png", brand: "브랜드명", name: "상품이름", description: "상세설명상세설명", price: "20,000원"},
        // 추가 상품 데이터를 여기에 삽입
    ];

    function renderProducts() {
        const productList = document.getElementById('product-list');
        productList.innerHTML = '';
        const start = (currentPage - 1) * productsPerPage;
        const end = start + productsPerPage;
        const paginatedProducts = products.slice(start, end);

        paginatedProducts.forEach(product => {
            const productDiv = document.createElement('div');
            productDiv.classList.add('product');
            productDiv.innerHTML = `
                <img src="${product.img}" alt="상품 이미지">
                <p>${product.brand}</p>
                <p>${product.name}</p>
                <p>${product.description}</p>
                <p>${product.price}</p>
                <button>❤</button>
            `;
            productList.appendChild(productDiv);
        });
    }

    function renderPagination() {
        const pagination = document.getElementById('pagination');
        pagination.innerHTML = '';
        const totalPages = Math.ceil(products.length / productsPerPage);

        const firstButton = document.createElement('button');
        firstButton.innerHTML = '&lt;&lt;';
        firstButton.classList.add('arrow');
        firstButton.disabled = currentPage === 1;
        firstButton.addEventListener('click', () => {
            if (currentPage !== 1) {
                currentPage = 1;
                renderProducts();
                renderPagination();
            }
        });
        pagination.appendChild(firstButton);

        const prevButton = document.createElement('button');
        prevButton.innerHTML = '&lt;';
        prevButton.classList.add('arrow');
        prevButton.disabled = currentPage === 1;
        prevButton.addEventListener('click', () => {
            if (currentPage > 1) {
                currentPage--;
                renderProducts();
                renderPagination();
            }
        });
        pagination.appendChild(prevButton);

        for (let i = 1; i <= totalPages; i++) {
            const button = document.createElement('button');
            button.innerText = i;
            if (i === currentPage) {
                button.classList.add('active');
            }
            button.addEventListener('click', () => {
                currentPage = i;
                renderProducts();
                renderPagination();
            });
            pagination.appendChild(button);
        }

        const nextButton = document.createElement('button');
        nextButton.innerHTML = '&gt;';
        nextButton.classList.add('arrow');
        nextButton.disabled = currentPage === totalPages;
        nextButton.addEventListener('click', () => {
            if (currentPage < totalPages) {
                currentPage++;
                renderProducts();
                renderPagination();
            }
        });
        pagination.appendChild(nextButton);

        const lastButton = document.createElement('button');
        lastButton.innerHTML = '&gt;&gt;';
        lastButton.classList.add('arrow');
        lastButton.disabled = currentPage === totalPages;
        lastButton.addEventListener('click', () => {
            if (currentPage !== totalPages) {
                currentPage = totalPages;
                renderProducts();
                renderPagination();
            }
        });
        pagination.appendChild(lastButton);
    }

    document.addEventListener('DOMContentLoaded', () => {
        renderProducts();
        renderPagination();
    });
</script>
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
</body>
</html>
