<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Header</title>
    <!-- css -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header_footer.css">
    <link rel="stylesheet" href="css/common.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .inner {
            width: 80%;
            margin: 0 auto;
        }

        .review-container {
            margin-top: 40px;
            display: flex;
        }

        .sidebar {
            width: 150px;
            margin-right: 20px;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
        }

        .sidebar ul li {
            margin: 10px 0;
        }

        .sidebar ul li a {
            text-decoration: none;
            color: #000;
            font-size: 16px;
        }

        .review-content {
            flex-grow: 1;
            margin-left: 20px;
        }

        .review-header {
            text-align: center;
            border-bottom: 2px solid #000;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        .review-header h2 {
            margin: 0;
            font-size: 20px;
            font-weight: bold;
        }

        .review-form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .review-form label {
            width: 100%;
            margin-bottom: 10px;
        }

        .review-form label span {
            display: inline-block;
            width: 100px;
            font-weight: bold;
        }

        .review-form input[type="text"],
        .review-form textarea {
            width: calc(100% - 110px);
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
        }

        .review-form textarea {
            height: 100px;
        }

        .review-form .rating {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .review-form .rating span {
            font-weight: bold;
            margin-right: 10px;
        }

        .review-form .rating input[type="radio"] {
            margin-right: 5px;
        }

        .review-form img {
            width: 200px;
            height: auto;
            margin-bottom: 10px;
        }

        .review-form button {
            background-color: #6a0dad;
            color: #fff;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
        }

        .review-form button:hover {
            background-color: #5a0cac;
        }
    </style>
</head>

<body>
    <!-- header -->
    <header>
        <div class="header_top inner">
            <div class="leftGnb">
                <h1 class="logo">
                    <img src="images/logo_black.png" alt="로고">
                </h1>
                <form class="search_form">
                    <label for="search_wrap"> <input name="search_input" type="search" /> <img src="images/icon_serch.png" alt="돋보기 아이콘" class="search_img" />
                    </label>
                </form>
            </div>
            <div class="rightGnb">
                <ul>
                    <li><a href="#"> <img src="images/icon-login.gif" alt="로그인">로그인
                    </a></li>
                    <li><a href="#">회원가입</a></li>
                    <li><a href="#">마이페이지</a></li>
                    <li><a href="#">쇼핑백</a></li>
                </ul>
            </div>
        </div>
        <div class="header_bottom">
            <div class="menu_wrap inner">
                <ul class="left_menu">
                    <li><a href="javascript:#void">여성</a>
                        <div class="dropdown_nav">
                            <ul>
                                <li><a href="#">신상품</a></li>
                                <li><a href="#">전체 상품</a></li>
                                <li><a href="#">아우터</a></li>
                                <li><a href="#">재킷/베스트</a></li>
                                <li><a href="#">니트</a></li>
                                <li><a href="#">셔츠/블라우스</a></li>
                                <li><a href="#">티셔츠</a></li>
                                <li><a href="#">원피스</a></li>
                                <li><a href="#">팬츠</a></li>
                                <li><a href="#">스커트</a></li>
                                <li><a href="#">쥬얼리/시계</a></li>
                            </ul>
                        </div>
                    </li>
                    <li><a href="javascript:#void">남성</a>
                        <div class="dropdown_nav">
                            <ul>
                                <li><a href="#">신상품</a></li>
                                <li><a href="#">전체 상품</a></li>
                                <li><a href="#">아우터</a></li>
                                <li><a href="#">재킷/베스트</a></li>
                                <li><a href="#">니트</a></li>
                                <li><a href="#">셔츠/블라우스</a></li>
                                <li><a href="#">티셔츠</a></li>
                                <li><a href="#">원피스</a></li>
                                <li><a href="#">팬츠</a></li>
                                <li><a href="#">스커트</a></li>
                                <li><a href="#">쥬얼리/시계</a></li>
                            </ul>
                        </div>
                    </li>
                    <li><a href="javascript:#void">키즈</a>
                        <div class="dropdown_nav">
                            <ul>
                                <li><a href="#">신상품</a></li>
                                <li><a href="#">전체 상품</a></li>
                                <li><a href="#">남아</a></li>
                                <li><a href="#">여아</a></li>
                            </ul>
                        </div>
                    </li>
                    <li><a href="javascript:#void">럭셔리</a>
                        <div class="dropdown_nav">
                            <ul>
                                <li><a href="#">신상품</a></li>
                                <li><a href="#">전체 상품</a></li>
                                <li><a href="#">여성의류</a></li>
                                <li><a href="#">여성가방/지갑</a></li>
                                <li><a href="#">여성슈즈</a></li>
                                <li><a href="#">여성 쥬얼리/시계</a></li>
                                <li><a href="#">남성의류</a></li>
                                <li><a href="#">남성가방/지갑</a></li>
                                <li><a href="#">남성슈즈</a></li>
                                <li><a href="#">선글라스/안경테</a></li>
                            </ul>
                        </div>
                    </li>
                    <li><a href="javascript:#void">키즈</a>
                        <div class="dropdown_nav">
                            <ul>
                                <li><a href="#">신상품</a></li>
                                <li><a href="#">전체 상품</a></li>
                                <li><a href="#">아우터</a></li>
                                <li><a href="#">재킷/베스트</a></li>
                                <li><a href="#">니트</a></li>
                                <li><a href="#">셔츠/블라우스</a></li>
                                <li><a href="#">티셔츠</a></li>
                                <li><a href="#">원피스</a></li>
                                <li><a href="#">팬츠</a></li>
                                <li><a href="#">스커트</a></li>
                                <li><a href="#">쥬얼리/시계</a></li>
                            </ul>
                        </div>
                    </li>
                    <li><a href="javascript:#void">스포츠</a>
                        <div class="dropdown_nav">
                            <ul>
                                <li><a href="#">신상품</a></li>
                                <li><a href="#">전체 상품</a></li>
                                <li><a href="#">아웃도어/캠핑</a></li>
                                <li><a href="#">피트니스</a></li>
                            </ul>
                        </div>
                    </li>
                    <li><a href="javascript:#void">가방&신발</a>
                        <div class="dropdown_nav">
                            <ul>
                                <li><a href="#">신상품</a></li>
                                <li><a href="#">전체 상품</a></li>
                                <li><a href="#">여성 가방</a></li>
                                <li><a href="#">여성 슈즈</a></li>
                                <li><a href="#">남성 가방</a></li>
                                <li><a href="#">남성 슈즈</a></li>
                            </ul>
                        </div>
                    </li>
                </ul>
                <ul class="right_menu">
                    <li><a href="#void" class="highlight">AI추천코디</a></li>
                    <li><a href="#void" class="highlight">옷대여</a></li>
                    <li><a href="#void">Q&A</a></li>
                    <li><a href="#void">공지사항</a></li>
                </ul>
            </div>
        </div>
    </header>

    <div class="review-container inner">
        <div class="sidebar">
            <ul>
                <li><a href="#">나의 주문</a></li>
                <li><a href="#">나의 대여</a></li>
                <li><a href="#">장바구니</a></li>
                <li><a href="#">나의 글</a></li>
                <ul>
                    <li><a href="#">문의글</a></li>
                    <li><a href="#">리뷰</a></li>
                </ul>
                <li><a href="#">회원정보</a></li>
                <ul>
                    <li><a href="#">정보 수정</a></li>
                    <li><a href="#">회원 탈퇴</a></li>
                </ul>
            </ul>
        </div>
        <div class="review-content">
            <div class="review-header">
                <h2>나의 리뷰</h2>
            </div>
            <div class="review-form">
                <label>
                    <span>상품명/옵션</span>
                    <input type="text" name="product_name" placeholder="상품명/옵션을 입력하세요">
                </label>
                <label>
                    <span>작성일자</span>
                    <input type="text" name="review_date" placeholder="2024.05.29" disabled>
                </label>
                <label>
                    <span>사진</span>
                    <input type="file" name="image">
                </label>
                <img src="../images/tshirt.jpg" alt="티셔츠 이미지">
                <label>
                    <span>평점</span>
                    <div class="rating">
                        <input type="radio" name="rating" value="1"> 1
                        <input type="radio" name="rating" value="2"> 2
                        <input type="radio" name="rating" value="3"> 3
                        <input type="radio" name="rating" value="4"> 4
                        <input type="radio" name="rating" value="5" checked> 5
                    </div>
                </label>
                <label>
                    <span>내용</span>
                    <textarea name="content" placeholder="내용을 입력하세요">착용감도 너무 좋고 갖고 있는 바지들과 계속 입고 다닐 것 같아요! 강력추천합니다~~</textarea>
                </label>
                <button>등록하기</button>
            </div>
        </div>
    </div>
</body>

</html>
    