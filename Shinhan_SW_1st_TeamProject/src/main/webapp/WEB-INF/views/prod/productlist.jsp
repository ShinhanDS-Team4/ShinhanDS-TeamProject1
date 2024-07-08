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
    <title>SAREN</title>
    <style>
    	* {font-family: Pretendard-Regular;}
    
        body {
            margin: 0;
            padding: 0;
            background-color: #ffffff; 
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .container { 
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: flex-start;
            padding: 20px; 
        }

        .inner {
            max-width: 1300px;
            margin: 0 auto;
            width: 100%;
        }

 		.title {
   			padding: 20px;
   		    padding-bottom: 5px;  
		}


        .title h1 {
            display: inline-block;
            margin: 0;
            font-size: 30px;  
        }

        .title h1 span {
            font-size: 14px;
            color: black;
            margin-left: 0;
        }
        
        .bread {
        	padding-left: 20px;
        }
        
        .bread li {
        	display: inline-block;
        	margin-left: 5px;
        }

        .separator {
            border-bottom: 2px solid black;
            margin: 0 20px;
            
        }

        nav ul {
            list-style: none;
            padding: 0;
            margin: 10px 20px 0;
        }

        nav ul li {
            display: inline;
            margin-right: 15px;
        }

        nav ul li a {
            text-decoration: none;
            font-size: 16px;
            color: #999;
        }

        .filters {
            margin: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between; 
        }
        
        

        .filters li {
            margin-right: 10px;
            float: left;
            border: solid 1px #ddd;
            border-radius: 10px;
            padding: 8px 15px;
            font-size: 14px;
            cursor: pointer;
        }
        
        .filters li img{
        	width: 16px;
        	height: 16px;
        	margin-left: 8px;
        	transition: .3s;
        }
        
        .letrotate {
        	transform: rotate(180deg);
        }

        .sort-buttons {
            display: flex; 
        }

        .sort-buttons button {
		    padding: 5px 10px;
		    border: 0px solid #ccc;
		    background-color: #fff;
		    cursor: pointer;
		    font-size: 14px;
}
        }

        .sort-buttons button.active {
            font-weight: bold;
        }

        .products {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            padding: 20px;
        }

        .products a {
            padding: 10px;
            width: calc(25% - 20px);
            box-sizing: border-box;
            text-align: left;
        }
        
        .product img {
            max-width: 100%;
            height: auto;
        }

        .product span {
        	width: 100%;
            margin: 10px 0;
            display: block;
            font-size: 14px;
            font-weight: 100;
            
            overflow: hidden;
		    word-wrap: break-word;
		    word-break: keep-all;
		    text-overflow: ellipsis;
		    white-space: nowrap;
        }
        
        .product span.name {
        	font-size: 13px;
        }
        
        .product span.brand, .product span.price {
        	font-weight: 900;
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

        .pagination a {
            margin: 0 5px;
            padding: 5px 10px;
            border: 1px solid transparent;  
            background-color: #fff;
            cursor: pointer;
        }

        .pagination a.active {
            font-weight: bold;
        }

        .pagination a:disabled {
            cursor: not-allowed;
            opacity: 0.5;
        }

        .pagination a.arrow {
            font-weight: bold;
        }
        
        .bread {
        	font-size: 15px;
        }
        
        .bread a{
        	color: #999;
        }
        
        .classify {
        	width: 100%;
        	
        	display: flex;
        	justify-content: center;
        	align-items: center;
        	box-sizing: border-box;
        }
        
        .clsinner {
        	width: 100%;
        	margin: 0 20px;
        	background-color: #eee;
        	padding: 30px;
        	padding-bottom: 10px;
        }
        
        .clsinner > p {
        	text-align: center;
        	margin-bottom: 30px;
        }
        
        .clsinner ul {
        	display: grid;
        	gap: 16px;
        	grid-template-columns: repeat(4, 1fr);
    
        	align-items: center;
        	box-sizing: border-box;
        }
        
        .clsinner li {
			width: auto;
			font-size: 14px;
			
        }
        
        .clsinner li > i {
        	display: inline-block;
        	width: 17px;
        	height: 17px;
        	background-color: white;
        	border-radius: 4px;
        	border: solid 1px #ddd;
        	cursor: pointer;
        }
        
        .clsinner li p {
        	display: inline-block;
        	position: absolute;
        	margin-left: 5px;
        }
        
        .checked {
        	background-image: url('../resources/images/checked.png');
        	background-size: 100% 100%;
        }
        
        .paginationBrnd {
            display: flex;
            justify-content: center;
            padding: 20px 0;
        }

        .paginationBrnd button {
            margin: 0 5px;
            padding: 5px 10px;
            border: 1px solid transparent;
            cursor: pointer;
        }

        .paginationBrnd button.active {
            font-weight: bold;
        }

        .paginationBrnd button:disabled {
            cursor: not-allowed;
            opacity: 0.5;
        }

        .paginationBrnd button.arrow {
            font-weight: bold;
        }
        
        .schedPagination {
            display: flex;
            justify-content: center;
            padding: 20px 0;
        }

        .schedPagination button {
            margin: 0 5px;
            padding: 5px 10px;
            border: 1px solid transparent;
            cursor: pointer;
            background-color: #fff;
        }

        .schedPagination button.active {
            font-weight: bold;
        }

        .schedPagination button:disabled {
            cursor: not-allowed;
            opacity: 0.5;
        }

        .schedPagination button.arrow {
            font-weight: bold;
        }
        
    </style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
    <%@ include file="../common/header.jsp"%>
    <div class="container">
        <div class="main-content inner">
        	<div class="bread">
        		<ol>
            		<li>
            			<a href="${path}">Home</a>
            		</li>
            		<c:forEach var="ctg" items="${traceCtgs}">
	            		<li>
	            			<c:choose>
	            				<c:when test="${ctg.parent_category_id == null}">
	            					<a href="${path}">></a>
	            				</c:when>
	            				
	            				<c:otherwise>
	            					<a href="${path}/prod/productlist?shwCtgNum=${ctg.parent_category_id}">></a>
	            				</c:otherwise>
	            			</c:choose>
	            			<a href="${path}/prod/productlist?shwCtgNum=${ctg.category_id}">${ctg.category_name}</a>
	            		</li>
            		</c:forEach>
            	</ol>
        	</div>
            <div class="title">
                <h1>${currentCtg.category_name }
                <span id="prodNums">${String.format("%,d", allProdNumsByCtg)}개 상품</span>
                </h1>
            </div>
            <div class="separator"></div>
            <nav>
	                <ul>	
	                    <li><a href="${path}/prod/productlist?shwCtgNum=${currentCtg.is_lowest == 1 ? currentCtg.parent_category_id : currentCtg.category_id}" class="${currentCtg.is_lowest == 1 ? currentCtg.parent_category_id : currentCtg.category_id}">전체</a></li>
            	<c:forEach var="ctg" items="${categoriesByCurCtg}">
	                    <li><a href="${path }/prod/productlist?shwCtgNum=${ctg.category_id}" class="${ctg.category_id}">${ctg.category_name }</a></li>
            	</c:forEach>
	                </ul>
            </nav>
            
            <div class="filters">
                <div class="brndAndprc">
                	<ul>
                		<li class="brnd">
                			<span>브랜드<img src="${path}/resources/images/arrow.png" alt=""></span>
                		</li>
                		
                		<li class="prc">
                			<span>가격<img src="${path}/resources/images/arrow.png" alt=""></span>
                		</li>
                	</ul>
                </div>
                <div class="sort-buttons">
                    <button id="sort-low-price">• 낮은 가격 순</button>
                    <button id="sort-high-price">• 높은 가격 순</button>
                </div>
            </div>
            
	        <div class="classify">
	            <div class="clsinner">
	           		
	            </div>
            </div>
            
            <section class="products" id="product-list">
            </section>
            
            <div class="pagination" id="pagination">
            </div>
            
            <div class="schedPagination" id="schedPagination">
            </div>
        </div>
    </div>
    <%@ include file="../common/footer.jsp"%>

    <script> 
    const products = [];
	
    // JSP에서 서버 데이터 받아오기
    <c:forEach var="product" items="${allProdByCtg}">
        products.push({
            IMG_URL: '/saren/ProdImgFile/main/${product.PROD_ID}_image_1.jpg',
            BRAND: '${product.BRAND}',
            PROD_NAME: '${product.PROD_NAME}',
            PROD_PRICE: ${product.PROD_PRICE},
            PROD_ID: '${product.PROD_ID}'
        });
    </c:forEach>
    const productsPerPage = 24;
    let currentPage = ${currentPg};
    let sortedProducts = [...products];
    
    let schedProducts;
    
    let tempAllSchNums;
    let schCrntPg = 1;
    
    const brndsPerPage = 20;
    let brndCrntPg = 1;
    
    let schConds = {'brnd':[], 'price_start':0, 'price_end':0};

    const sortProducts = (criteria) => {
    	currentProducts = (schConds.brnd.length == 0 && schConds.price_start == 0) ? sortedProducts : schedProducts;
    	
        if (criteria === 'low') {
        	currentProducts.sort((a, b) => a.PROD_PRICE - b.PROD_PRICE);
        } else if (criteria === 'high') {
        	currentProducts.sort((a, b) => b.PROD_PRICE - a.PROD_PRICE);
        }
        if(schConds.brnd.length == 0 && schConds.price_start == 0) {
        	renderProducts();
            renderPagination();
        } else {
        	setSortedProductsByBrnds();
        }
    };

    document.getElementById('sort-low-price').addEventListener('click', () => {
        sortProducts('low');
    });

    document.getElementById('sort-high-price').addEventListener('click', () => {
        sortProducts('high');
    });

    const renderProducts = () => {
        const productList = document.getElementById('product-list');
        productList.innerHTML = '';
        
        sortedProducts.forEach(product => {
        	var img_url_base = '${path}/prod/product_detail?prod_id='
            img_url_base = img_url_base + product.PROD_ID;
        	
        	const productA = document.createElement('a');
        	productA.setAttribute('href', img_url_base);
        	
            const productDiv = document.createElement('div');
            productDiv.classList.add('product');
            productDiv.innerHTML = `
	                <img src=\${product.IMG_URL} alt='상품 이미지'>
	                <span class='brand'>\${product.BRAND}</span>
	                <span class='name'>\${product.PROD_NAME}</span>
	                <span class='price'>\${product.PROD_PRICE.toLocaleString('ko-KR')}</span>
	                <button>❤</button>
            `;
            
            productA.appendChild(productDiv);
            productList.appendChild(productA);
        });
    };

    const renderPagination = () => {
    	$('#pagination').show();
        const pagination = document.getElementById('pagination');
        $('#schedPagination').hide();
        pagination.innerHTML = '';
        const totalPages = Math.ceil(${allProdNumsByCtg} / productsPerPage);

        const createA = (text, pageNumber, disabled = false) => {
            const a = document.createElement('a');
            a.innerText = text;
            a.classList.toggle('active', pageNumber === currentPage);
            a.setAttribute("href", "${path}/prod/productlist?shwCtgNum=${currentCtg.category_id}&currentPg="+pageNumber);
            if(disabled) {
				a.removeAttribute('href');
				a.style.cursor = "default";
				a.style.color = "#ddd";
            }
            a.addEventListener('click', () => {
                currentPage = pageNumber;
            });
            return a;
        };
		
        start = ${currentPg}%10 == 0 ? Math.floor(${currentPg}/10)*10-9 : Math.floor(${currentPg}/10)*10+1;
        end = start+9 < totalPages ? start+9 : totalPages;
        
        surpassingLeft = Math.floor(${currentPg-10}/10)*10+1;
        surpassingRight = ${currentPg+10}%10 == 0 ? Math.floor(${currentPg+10}/10)*10-9 : Math.floor(${currentPg+10}/10)*10+1;
        
        console.log(surpassingLeft);
        console.log(surpassingRight);
        
        pagination.appendChild(createA('<<', 1, currentPage === 1));
        pagination.appendChild(createA('<', surpassingLeft, currentPage <= 10));
        for (let i = start; i <= end; i++) {
            pagination.appendChild(createA(i, i));
        }
        pagination.appendChild(createA('>', surpassingRight, currentPage >= (totalPages%10 == 0 ? Math.floor(totalPages/10)*10-9 : Math.floor(totalPages/10)*10+1)));
        pagination.appendChild(createA('>>', totalPages, currentPage === totalPages));
    };

    const renderSchedPagination = () => {
    	$('#schedPagination').show();
        const pagination = document.getElementById('schedPagination');
        $('#pagination').hide();
        pagination.innerHTML = '';
        
        const schedTotalPages = Math.ceil(tempAllSchNums / productsPerPage);
        
        console.log(tempAllSchNums);
        console.log(productsPerPage);

        const createC = (text, pageNumber, disabled = false) => {
        	const b = document.createElement('button');
            b.innerText = text;
            b.disabled = disabled;
            b.classList.toggle('active', pageNumber === schCrntPg);
            b.addEventListener('click', () => {
            	schCrntPg = pageNumber;
            	setProductsByBrnds();
            });
            return b;
        };
		
        start = schCrntPg%10 == 0 ? Math.floor(schCrntPg/10)*10-9 : Math.floor(schCrntPg/10)*10+1;
        end = start+9 < schedTotalPages ? start+9 : schedTotalPages;
        
        schSurpassingLeft = Math.floor((schCrntPg-10)/10)*10+1;
        schSurpassingRight = (schCrntPg+10)%10 == 0 ? Math.floor((schCrntPg+10)/10)*10-9 : Math.floor((schCrntPg+10)/10)*10+1;
        
        pagination.appendChild(createC('<<', 1, schCrntPg === 1));
        pagination.appendChild(createC('<', schSurpassingLeft, schCrntPg <= 10));
        for (let i = start; i <= end; i++) {
            pagination.appendChild(createC(i, i));
        }
        pagination.appendChild(createC('>', schSurpassingRight, schCrntPg >= (schedTotalPages%10 == 0 ? Math.floor(schedTotalPages/10)*10-9 : Math.floor(schedTotalPages/10)*10+1)));
        pagination.appendChild(createC('>>', schedTotalPages, schCrntPg === schedTotalPages));
    };
    
    const renderBold = () => {
    	const lastAOfBread = $('.bread a').last();
    	lastAOfBread.css('color', '#000');
    	lastAOfBread.css('pointer', 'default');
    	lastAOfBread.removeAttr('href');
    	
    	$('.${currentCtg.category_id}').css('color', '#000');
    }
    
    const renderArrow = (clsName) => {
    	$('.'+clsName).on('click', function() {
    		if($('.'+clsName+' img').hasClass('letrotate')) {
    			$('.'+clsName+' img').removeClass('letrotate');
    			$('.classify').hide();
    		} else {
    			$('.'+clsName+' img').addClass('letrotate');
    			$('.classify').show();
    			
    			setBrnds();
    		}
    	})    	
    }
    
    const setBrnds = () => {
    	$.ajax({
			url:"${path}/prod/setbrnds",
			type:'get',
			data:{
				category_id:${currentCtg.category_id},
				brndPg:brndCrntPg,
				is_lowest:${currentCtg.is_lowest}
			},
			success: function(resp) {
				$('.clsinner').html(resp);

		        renderCheckBox();
		        renderBrndPagination();
			},
			error: function() {
				
			}
		});
    }
    
    const renderCheckBox = () => {
    	$('.clsinner i').each(function(index, item) {
    		if(schConds.brnd.indexOf($(item).next().text()) !== -1) {
    			$(item).addClass('checked');
    		}
    		
    		$(item).on('click', function() {
    			schCrntPg = 1;
    			if($(item).hasClass('checked')) {
    				$(item).removeClass('checked');
    				schConds.brnd = schConds.brnd.filter((e) => e !== $(item).next().text());
    				
    				if(schConds.brnd.length == 0 && schConds.price_start == 0) {
    					schedProducts = [];
    					$('#prodNums').text('${String.format("%,d", allProdNumsByCtg)}개 상품');
    					renderProducts();
    					renderPagination();
    				} else {
    					
    					setProductsByBrnds();
    				}
    				
    				console.log(schConds);
    			} else {
    				$(item).addClass('checked');
    				schConds.brnd.push($(item).next().text());
    				
    				setProductsByBrnds();
    			}
    		})
    	})
    }
    
    const setSortedProductsByBrnds = () => {
    	const productList = document.getElementById('product-list');
        productList.innerHTML = '';
        
        schedProducts.forEach(product => {
        	var img_url_base = '${path}/prod/product_detail?prod_id='
            img_url_base = img_url_base + product.PROD_ID;
        	
        	const productA = document.createElement('a');
        	productA.setAttribute('href', img_url_base);
        	
            const productDiv = document.createElement('div');
            productDiv.classList.add('product');
            productDiv.innerHTML = `
	                <img src=\${'/saren/ProdImgFile/main/'+product.PROD_ID+'_image_1.jpg'} alt='상품 이미지'>
	                <span class='brand'>\${product.BRAND}</span>
	                <span class='name'>\${product.PROD_NAME}</span>
	                <span class='price'>\${product.PROD_PRICE.toLocaleString('ko-KR')}</span>
	                <button>❤</button>
            `;
            
            productA.appendChild(productDiv);
            productList.appendChild(productA);
        });
    }
    
    const setProductsByBrnds = () => {
    	var slctdBrnd = schConds.brnd;
    	console.log(slctdBrnd);
    	var price_start = schConds.price_start;
    	var price_end = schConds.price_end;
    	
    	schInfo = {
			slctdBrnd:slctdBrnd,
			price_start:price_start,
			price_end:price_end,
			category_id:${currentCtg.category_id},
			currentPage:schCrntPg,
			is_lowest:${currentCtg.is_lowest}
		};
    	
    	$.ajax({
			url:"${path}/prod/setproductbyctg",
			type:'post',
			data:JSON.stringify(schInfo),
			dataType: "json",
			contentType:"application/json",
			success: function(products) {
				schedProducts = [...products]
				
				const productList = document.getElementById('product-list');
		        productList.innerHTML = '';
		        
		        products.forEach(product => {
		        	var img_url_base = '${path}/prod/product_detail?prod_id='
		            img_url_base = img_url_base + product.PROD_ID;
		        	
		        	const productA = document.createElement('a');
		        	productA.setAttribute('href', img_url_base);
		        	
		            const productDiv = document.createElement('div');
		            productDiv.classList.add('product');
		            productDiv.innerHTML = `
			                <img src=\${'/saren/ProdImgFile/main/'+product.PROD_ID+'_image_1.jpg'} alt='상품 이미지'>
			                <span class='brand'>\${product.BRAND}</span>
			                <span class='name'>\${product.PROD_NAME}</span>
			                <span class='price'>\${product.PROD_PRICE.toLocaleString('ko-KR')}</span>
			                <button>❤</button>
		            `;
		            
		            productA.appendChild(productDiv);
		            productList.appendChild(productA);
		        });
			},
			error: function() {
				
			}
		});
    	
    	$.ajax({
			url:"${path}/prod/getproductnumsbyctg",
			type:'post',
			data:JSON.stringify(schInfo),
			dataType: "json",
			contentType:"application/json",
			success: function(allNumsByBrnd) {
				tempAllSchNums = allNumsByBrnd;
				renderSchedPagination();
				console.log(tempAllSchNums);
				$('#prodNums').text(`\${tempAllSchNums.toLocaleString('ko-KR')}개 상품`);
			},
			error: function() {
				
			}
		});
    	
    	console.log(products);
    }
    
    const renderBrndPagination = () => {
        const pagination = document.getElementById('paginationBrnd');
        pagination.innerHTML = '';
        const brndTotalPages = Math.ceil(Number($('#totalBrnds').val()) / brndsPerPage);

        const createB = (text, pageNumber, disabled = false) => {
            const b = document.createElement('button');
            b.innerText = text;
            b.disabled = disabled;
            b.classList.toggle('active', pageNumber === brndCrntPg);
            b.addEventListener('click', () => {
            	brndCrntPg = pageNumber;
            	setBrnds();
            });
            return b;
        };
		
        start = brndCrntPg%10 == 0 ? Math.floor(brndCrntPg/10)*10-9 : Math.floor(brndCrntPg/10)*10+1;
        end = start+9 < brndTotalPages ? start+9 : brndTotalPages;
        
        brndSurpassingLeft = Math.floor((brndCrntPg-10)/10)*10+1;
        brndSurpassingRight = (brndCrntPg+10)%10 == 0 ? Math.floor((brndCrntPg+10)/10)*10-9 : Math.floor((brndCrntPg+10)/10)*10+1;

        
        pagination.appendChild(createB('<<', 1, brndCrntPg === 1));
        pagination.appendChild(createB('<', brndSurpassingLeft, brndCrntPg <= 10));
        for (let i = start; i <= end; i++) {
            pagination.appendChild(createB(i, i));
        }
        pagination.appendChild(createB('>', brndSurpassingRight, brndCrntPg >= (brndTotalPages%10 == 0 ? Math.floor(brndTotalPages/10)*10-9 : Math.floor(brndTotalPages/10)*10+1)));
        pagination.appendChild(createB('>>', brndTotalPages, brndCrntPg === brndTotalPages));
    };
    
    document.addEventListener('DOMContentLoaded', () => {
    	$('.classify').hide();
    	
        renderProducts();
        renderPagination();
        renderBold();
        renderArrow('brnd');
        renderArrow('prc');
    });
    </script>
</body>
</html>
