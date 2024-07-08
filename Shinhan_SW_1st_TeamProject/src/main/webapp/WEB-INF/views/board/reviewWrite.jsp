<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Header</title>
<%-- css --%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<%-- 본문 css --%>
<link rel="stylesheet" href="${path}/resources/css/style.css">
<%-- 헤더,푸터 css --%>
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<%-- jquery 연결 --%>
<script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
<script
    src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
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
        cursor: pointer;
    }

    .review-form .rating span {
        font-weight: bold;
        margin-right: 10px;
    }

    .review-form .rating .star {
        font-size: 24px;
        color: black;
        margin: 0 1px;
    }

    .review-form .rating .star.filled {
        color: orange;
    }

    .review-form .rating span#rating-value {
        margin-left: 10px;
        font-size: 18px;
    }

    .review-form img {
        width: 200px;
        height: auto;
        margin-bottom: 10px;
        display: none;
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
<script>
    $(document).ready(function() {
        // 함수: 주어진 평점에 따라 별을 채움
        function setRating(rating) {
            // 모든 별 요소를 순회하면서
            $('.star').each(function(index) {
                if (index < rating) {
                    // 현재 인덱스가 평점보다 작으면 채움
                    $(this).addClass('filled');
                } else {
                    // 그렇지 않으면 비움
                    $(this).removeClass('filled');
                }
            });
            // 현재 평점을 숨겨진 input에 설정
            $('#rating-input').val(rating);
            // 현재 평점을 표시
            $('#rating-value').text(rating);
        }

        // 이벤트: 별 클릭 시
        $('.star').on('click', function() {
            // 클릭한 별의 인덱스를 기반으로 평점 설정
            const rating = $(this).index() + 1;
            setRating(rating);
        });

        // 이벤트: 별에 마우스를 올렸을 때
        $('.star').on('mouseover', function() {
            // 마우스를 올린 별의 인덱스를 기반으로 임시 평점 설정
            const rating = $(this).index() + 1;
            setRating(rating);
        });

        // 이벤트: 마우스를 별 영역에서 벗어났을 때
        $('.rating').on('mouseleave', function() {
            // 저장된 평점을 다시 설정
            const ratingValue = $('#rating-input').val();
            setRating(ratingValue);
        });

        // 이벤트: 이미지 파일 선택 시
        $('input[name="reviewImg"]').on('change', function(event) {
            // 파일 읽기 객체 생성
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                // 파일이 로드된 후 실행되는 함수
                reader.onload = function(e) {
                    // 이미지 미리보기 설정
                    $('#selected-image').attr('src', e.target.result).show();
                };
                // 파일 읽기 시작
                reader.readAsDataURL(file);
            }
        });

        // 초기 설정: 기본 평점 설정
        const initialRatingValue = 1; // 기본 평점을 1로 설정
        $('#rating-value').text(initialRatingValue);
        setRating(initialRatingValue);
    });
</script>
</head>

<body>
<%@ include file="../common/header.jsp" %>
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
            <form class="review-form" action="write.do" method="post" enctype="multipart/form-data">
                <label>
                    <span>상품명/옵션</span>
                    <input type="text" name="review_title" value="${prod_name}" readonly>
                </label>
			    <label>
			        <span>작성일자</span>
			        <input type="date" name="review_date" id="review_date" readonly>
			    </label>
                <label>
                    <span>사진</span>
                    <input type="file" name="reviewImg">
                </label>
                <img id="selected-image" alt="선택한 이미지">
                <label>
                    <span>평점</span>
                    <div class="rating">
                        <div class="star">★</div>
                        <div class="star">★</div>
                        <div class="star">★</div>
                        <div class="star">★</div>
                        <div class="star">★</div>
                        <span id="rating-value">1</span> <%-- 기본 평점 값을 1로 설정 --%>
                        <input type="hidden" id="rating-input" name="rate" value="1">
                    </div>
                </label>
                <label>
                    <span>내용</span>
                    <textarea name="review_content" placeholder="내용을 입력하세요">착용감도 너무 좋고 갖고 있는 바지들과 계속 입고 다닐 것 같아요! 강력추천합니다~~</textarea>
                </label>
                <button type="submit">등록하기</button>
            </form>
			<script>
			    document.addEventListener('DOMContentLoaded', (event) => {
			        const today = new Date().toISOString().split('T')[0];
			        document.getElementById('review_date').value = today;
			    });
			</script>
		</div>
    </div>
</body>

</html>
