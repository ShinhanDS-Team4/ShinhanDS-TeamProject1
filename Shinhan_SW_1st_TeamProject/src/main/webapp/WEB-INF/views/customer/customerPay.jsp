<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문결제페이지</title>
     <!-- 본문 css -->
    <link rel="stylesheet" href="${path}/resources/css/style.css">
     <!-- 헤더,푸터 css -->
    <link rel="stylesheet" href="${path}/resources/css/header_footer.css">
    <!-- jquery 연결 -->
    <script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <!-- Slick 불러오기 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
    <!-- Slick 직접 연결 -->
    <link rel="stylesheet" href="${path}/resources/slick/slick-theme.css">
    <link rel="stylesheet" href="${path}/resources/slick/slick.css">
    <!-- 페이지용 css -->
    <link rel="stylesheet" href="${path}/resources/css/customerPay.css" />
    <script src="${path}/resources/slick/slick.min.js"></script>
</head>
<body>
	<%@ include file=../common/header.jsp" %>
	<main>
      <h1>주문/결제</h1>
      <div class="order-summary">
        <div class="product-info">
          <img src="product_image.png" alt="상품 이미지" />
          <div class="product-details">
            <p>브랜드명</p>
            <p>상품명: 하이퀄리티남자데님셔츠</p>
            <p>색상: 네이비, 크기: L</p>
            <p>가격: 39,200원</p>
            <p>할인쿠폰(5%): 1장</p>
            <p>배송비: 무료배송</p>
            <p>총 주문액: 744,800원</p>
          </div>
        </div>
      </div>

      <div class="delivery-info">
        <h2>배송지 정보</h2>
        <form>
          <div class="form-group">
            <label for="name">이름</label>
            <input type="text" id="name" name="name" value="이호정" />
          </div>
          <div class="form-group">
            <label for="phone">휴대폰</label>
            <input type="text" id="phone" name="phone" value="010-2717-9614" />
          </div>
          <div class="form-group">
            <label for="address">배송주소</label>
            <input type="text" id="address" name="address" />
            <button type="button" class="address-button">주소 찾기</button>
          </div>
          <div class="form-group">
            <input type="checkbox" id="save-address" name="save-address" />
            <label for="save-address">기본 배송지로 저장</label>
          </div>
          <div class="form-group">
            <label for="message">배송 메시지</label>
            <input type="text" id="message" name="message" />
          </div>
          <button type="submit" class="submit-button">새로입력</button>
        </form>
      </div>

      <div class="coupon-info">
        <h2>쿠폰적용</h2>
        <div class="form-group">
          <label for="coupon-number">쿠폰번호</label>
          <input type="text" id="coupon-number" name="coupon-number" />
          <button type="button" class="coupon-button">쿠폰확인</button>
        </div>
        <div class="form-group">
          <label for="discount">할인쿠폰</label>
          <input
            type="text"
            id="discount"
            name="discount"
            value="사용가능 5장"
            readonly
          />
        </div>
        <div class="form-group">
          <label for="shipping-coupon">배송비쿠폰</label>
          <input
            type="text"
            id="shipping-coupon"
            name="shipping-coupon"
            value="사용가능 0장"
            readonly
          />
        </div>
      </div>

      <div class="payment-summary">
        <p>
          784,000원 (총 상품금액) + 0원 (총 배송비) - 39,200원 (총 할인액) =
          744,800원 (총 주문액)
        </p>
      </div>

      <div class="terms-and-payment">
        <h2>구매 및 결제대행서비스 이용약관</h2>
        <form>
          <div class="form-group">
            <input type="checkbox" id="agree1" name="agree1" />
            <label for="agree1"
              >개인정보 수집 및 이용 동의 <a href="#">약관보기</a></label
            >
          </div>
          <div class="form-group">
            <input type="checkbox" id="agree2" name="agree2" />
            <label for="agree2"
              >개인정보 제3자 제공 동의 <a href="#">약관보기</a></label
            >
          </div>
          <div class="form-group">
            <input type="checkbox" id="agree3" name="agree3" />
            <label for="agree3"
              >전자금융거래 이용약관 <a href="#">약관보기</a></label
            >
          </div>
          <div class="form-group">
            <input type="checkbox" id="agree4" name="agree4" />
            <label for="agree4"
              >주소정보 수집 및 이용 동의 <a href="#">약관보기</a></label
            >
          </div>
          <div class="form-group">
            <input type="checkbox" id="agree5" name="agree5" />
            <label for="agree5">구매확인서 <a href="#">약관보기</a></label>
          </div>
          <button type="submit" class="payment-button">결제하기</button>
        </form>
      </div>
    </main>
</body>
</html>