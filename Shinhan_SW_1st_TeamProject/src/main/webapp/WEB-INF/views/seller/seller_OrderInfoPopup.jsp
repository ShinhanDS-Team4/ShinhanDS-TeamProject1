<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>주문 정보</title>
    <link rel="stylesheet" href="${path}/resources/css/orderpopup.css" />
  </head>
  <body>
    <div class="container">
      <h1>주문 정보</h1>
      <div class="order-details">
        <div class="popupform">
          <p><strong>주문ID</strong></p>
          <input type="text" placeholder="주문ID" />
        </div>
        <div class="popupform">
          <p><strong>구매자ID</strong></p>
          <input type="text" placeholder="구매자ID" />
        </div>
        <div class="popupform">
          <p><strong>구매자명</strong></p>
          <input type="text" placeholder="구매자명" />
        </div>
        <div class="popupform">
          <p><strong>전화번호</strong></p>
          <input type="text" placeholder="전화번호" />
        </div>
        <div class="popupform">
          <p><strong>이메일</strong></p>
          <input type="text" placeholder="이메일" />
        </div>
        <div class="popupform">
          <p><strong>배송주소</strong></p>
          <input type="text" placeholder="배송주소" />
        </div>
      </div>
      <h2>주문목록</h2>
      <div class="order-list">
        <div class="order-item">
          <div class="item-image">상품사진</div>
          <div class="item-info">
            <div class="item-details">
              <input class="pName" placeholder="상품명" />
              <input class="pOption" placeholder="옵션1" />
              <input class="pOption" placeholder="옵션2" />
              <input class="pOption" placeholder="옵션3" />
              <input class="pOption" placeholder="옵션4" />
              <input class="pOption" placeholder="옵션5" />
            </div>
            <div class="popupform">
              <p><strong>주문 수량</strong></p>
              <input type="text" placeholder="주문 수량" />
            </div>
          </div>
        </div>
        <div class="order-item">
          <div class="item-image">상품사진</div>
          <div class="item-info">
            <div class="item-details">
              <input class="pName" placeholder="상품명" />
              <input class="pOption" placeholder="옵션1" />
              <input class="pOption" placeholder="옵션2" />
              <input class="pOption" placeholder="옵션3" />
              <input class="pOption" placeholder="옵션4" />
              <input class="pOption" placeholder="옵션5" />
            </div>
            <div class="order_count">
              <label class="order_count_label">주문 수량</label>
              <input
                class="order_count_input"
                type="text"
                placeholder="주문수량"
              />
            </div>
          </div>
        </div>
        <div class="order-item">
          <div class="item-image">상품사진</div>
          <div class="item-info">
            <div class="item-details">
              <input class="pName" placeholder="상품명" />
              <input class="pOption" placeholder="옵션1" />
              <input class="pOption" placeholder="옵션2" />
              <input class="pOption" placeholder="옵션3" />
              <input class="pOption" placeholder="옵션4" />
              <input class="pOption" placeholder="옵션5" />
            </div>
            <div class="order_count">
              <label class="order_count_label">주문 수량</label>
              <input
                class="order_count_input"
                type="text"
                placeholder="주문수량"
              />
            </div>
          </div>
        </div>
      </div>
      <button class="close-button">닫기</button>
    </div>
  </body>
</html>
