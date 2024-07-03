<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 마이페이지-프로필</title>
<%-- css --%>
<link rel="stylesheet" href="${path}/resources/css/mypage.css">
<%-- 헤더,푸터 css --%>
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<%-- jquery 연결 --%>
<script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<style>
.hidden{
	display: none;
}
</style>
<body>
	<%@ include file="../common/header.jsp" %>
	<%-- 마이페이지 : 메인 --%>
	<div class="mypage_wrap">
		<div class="myinfo inner">
			<nav>
				<ul>
					<li>
						<h3>
							<a href="${path}/customer/orderlist.do">나의주문</a>
						</h3>
					</li>
					<li>
						<h3>
							<a href="${path}/customer/rentlist.do">나의대여</a>
						</h3>
					</li>
					<li>
						<h3>
							<a href="${path}/cart/cart.do">장바구니</a>
						</h3>
					</li>
					<li>
						<h3>
							<a href="${path}/board/myreview.do">나의글</a>
						</h3>
						<ul class="myinfo_submenu">
							<li><a href="${path}/qna/myqna.do">문의글</a></li>
							<li><a href="${path}/board/reviewjsp">리뷰</a></li>
						</ul>
					</li>
					<li>
						<h3>
							<a href="javascript:#void">회원정보</a>
						</h3>
						<ul class="myinfo_submenu">
							<li><a href="${path}/customer/myInfoUpdate.do">정보수정</a></li>
							<li><a href="${path}/customer/memberDelete.do">회원탈퇴</a></li>
						</ul>
					</li>
				</ul>
			</nav>
			<div class="mypage_here">
				<%-- 프로필 --%>
				<div class="profile_wrap">
					<h1 class="myinfo_title">마이페이지</h1>
					<div class="profile">
						<div class="profile_info">
							<div class="profile_img">
								<p>WELCOME</p>
							</div>
							<div class="profile_text">
								<h3>
									${member.member_name}님 <span>(${member.member_id})</span>
								</h3>
								<div class="profile_text_box">
									<p>
										보유포인트: <span>${myPoints.point != 0 ? myPoints.point : 0 }p</span>
									</p>
									<p>
										회원등급: <span>${myPoints.member_level}</span>
									</p>
									<button class="detail_btn">자세히 보기</button>
								</div>
								<p>
									<a href="${path}/board/myreview.do" class="go_review">작성한 리뷰 보기</a>
								</p>
								<div class="links">
									<a href="javascript:#void">주문내역 <span>${orderCount != 0 ? orderCount : 0} 건</span></a> 
									<a href="javascript:#void">대여내역 <span>${rentCount != 0 ? rentCount : 0} 건</span></a>
									<a href="javascript:#void">문의내역 <span>${inqCount != 0 ? inqCount : 0} 건</span></a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<%-- 주문 내역 --%>
				<div class="profile_wrap">
					<h1 class="myinfo_title">주문 내역</h1>
					<div class="info_text">
						<table class="order_table">
							<thead>
								<tr>
									<th>주문 번호</th>
									<th>상품이미지</th>
									<th>상품 가격</th>
									<th>상품 정보</th>
									<th>주문 날짜</th>
									<th>총 주문 금액</th>
								</tr>
							</thead>
							<tbody>
					            <c:set var="maxOrders" value="2" />
						        <c:choose>
						            <c:when test="${not empty myAllOrders}">
						                <!-- JSTL로 정렬된 결과를 상위 2개만 추출하는 방법은 없으므로 컨트롤러에서 정렬하여 전달 -->
						                <c:forEach items="${myAllOrders}" var="order" varStatus="status">
						                    <c:if test="${status.index lt maxOrders}">
						                        <tr>
						                        	<td>${order.ORDER_ID}</td>
						                            <td style="background-color:powderblue;"><img src="${order.IMG_ID}" alt="${order.IMG_ID}" width="100"></td>
						                            <td class="product-info">
						                                <strong>${order.BRAND}</strong><br>
						                                ${order.PROD_NAME}<br>
						                                <span>${order.ORDER_NUM}개</span>
						                            </td>
						                            <td>${order.ORDER_PRODUCT_PRICE}원<br></td>
						                            <td>
						                            	${order.ORDER_DATE}
						                            </td>
						                            <td class="price">${order.TOTAL_PRICE}원</td>
						                        </tr>
						                    </c:if>
						                </c:forEach>
						            </c:when>
						            <c:otherwise>
						                <tr>
						                    <td colspan="5">주문 내역이 없습니다.</td>
						                </tr>
						            </c:otherwise>
						        </c:choose>
							</tbody>
						</table>
					</div>
				</div>
				<%-- 대여 내역 --%>
				<div class="profile_wrap">
					<h1 class="myinfo_title">대여 내역</h1>
					<div class="info_text">
						<table class="order_table">
							<thead>
								<tr>
									<th>대여 번호</th>
									<th>대여 가격</th>
									<th>상품 정보</th>
									<th>주문 기간</th>
									<th>총 대여 금액</th>
								</tr>
							</thead>
							<tbody>
					            <c:set var="maxOrders" value="5" />
						        <c:choose>
						            <c:when test="${not empty myAllRentOrders}">
						                <c:forEach items="${myAllRentOrders}" var="rent" varStatus="status">
						                    <c:if test="${status.index lt maxOrders}">
						                        <tr>
						                        	<td>${rent.RENTAL_CODE}</td>
						                            <td class="product-info">
						                                <strong>${rent.BRAND}</strong><br>
						                                ${rent.PROD_NAME}<br>
						                                <span>${rent.RENT_NUM}개</span>
						                            </td>
						                            <td>${rent.RENT_PRODUCT_PRICE}원<br></td>
						                            <td>
						                            	${rent.RENT_START_DATE} ~ ${rent.RENT_END_DATE}
						                            </td>
						                            <td class="price">${rent.TOTAL_RENT_PRICE}원</td>
						                        </tr>
						                    </c:if>
						                </c:forEach>
						            </c:when>
						            <c:otherwise>
						                <tr>
						                    <td colspan="5">대여 내역이 없습니다.</td>
						                </tr>
						            </c:otherwise>
						        </c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>