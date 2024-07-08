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
<%-- rank팝업 css --%>
<link rel="stylesheet" href="${path}/resources/css/rank.css">
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
	<%-- rank팝업 보기 --%>
	<div id="popup-overlay" class="popup-overlay">
		<div class="popup-content">
			<span class="close-button" onclick="closePopup()">&times;</span>
			<h2>SAREN 멤버십 등급 혜택 안내</h2>
			<table class="popup-table">
				<tr>
					<th></th>
					<th><div class="ruby_circle">R</div></th>
					<th><div class="diamond_circle">D</div></th>
					<th><div class="gold_circle">G</div></th>
					<th><div class="silver_circle">S</div></th>
					<th><div class="bronze_circle">B</div></th>
					<th><div class="family_circle">F</div></th>
				</tr>
				<tr>
					<td class="header">등급</td>
					<td>RUBY</td>
					<td>DIAMOND</td>
					<td>GOLD</td>
					<td>SILVER</td>
					<td>BRONZE</td>
					<td>FAMILY</td>
				</tr>
				<tr>
					<td class="header">등급 선정 기준</td>
					<td>3,000만원 이상</td>
					<td>1,000만원 이상</td>
					<td>300만원 이상</td>
					<td>100만원 이상</td>
					<td>50만원 이상</td>
					<td>1회 이상 구매</td>
				</tr>
				<tr>
					<td class="header">멤버십 포인트적립</td>
					<td>포인트<br>기프트포인트 50만
					</td>
					<td>포인트<br>기프트포인트 30만
					</td>
					<td>포인트<br>기프트포인트 10만
					</td>
					<td>포인트<br>기프트포인트 5만
					</td>
					<td>포인트<br>기프트포인트 2만
					</td>
					<td>포인트<br>기프트포인트 1만
					</td>
				</tr>
			</table>
			<button class="accordion">등급 산정 기준</button>
			<div class="panel">
				<p>• 매월 1일 등급이 부여되며, 전월 20일까지 12개월간 실결제 구매액 합산 기준으로 산정됩니다.(예, 24년 7월 등급 : 23년 6월 21일 ~ 24년 6월 20일까지 실결제 구매액)<br>
				   • 등급 산정시 온/오프라인 자사상품 및 SAREN SHOP샵 입점상품 금액 모두 포함됩니다. 단, 오프라인 아울렛 매장 구매금액은 아울렛 매장에서 통합 멤버십 가입 이후 구매금액만 포함됩니다.<br>
				   • 쿠폰 사용을 통한 할인액 제외, 실결제 금액 기준으로 등급이 산정됩니다.<br>
				   • 산정 기간 내 구매(주문) 취소/반품 시 등급이 하락할 수 있습니다.<br>
				   • 신규 가입 후 첫 구매 또는 1년 이상 미구매 후 구매 시 구매금액에 상관 없이 3일 후 FAMILY 등급이 부여됩니다.(단, 매월 25일 ~ 말일까지 구매 시에는 다음달 1일에 FAMILY 등급이 부여됩니다.)<br>
				   • 온라인 사이트에만 가입된 고객이 삼성패션 멤버십 통합 가입 시 기존 구매이력을 포함하여 등급이 산정됩니다.<br>
				   • 온라인 사이트에만 가입된 고객이 매월 20일 이내 삼성패션 통합가입 시 다음 달 멤버십 등급이 부여됩니다.(21일 이후 통합 가입 시 두 달 후 부터 등급 부여)<br>
				   • 삼성패션 멤버십 회원에게만 등급이 부여되며, 온라인 사이트 전용 회원은 등급이 부여되지 않습니다.<br>
				   • 멤버십 신규 가입 후 미 구매 고객, 최종 구매 1년 경과 고객에게는 별도 등급이 부여되지 않습니다.<br>
				   • 부당한 방법으로 획득한 고객등급은 재조정될 수 있습니다.</p>
			</div>
			<button class="accordion">멤버십 포인트 적립/사용 안내</button>
			<div class="panel void">
				<p>• SAREN SHOP의 멤버십 포인트 적립률은 프로모션에 따라 정해진 적립률과 다르게 변경될 수 있습니다.<br>
				   • 아울렛 일부 매장은 포인트 적립에서 제외되며 일부 매장 및 상품(할인 적용 상품 등)은 상기 적립률과 다를 수 있습니다.<br>
				   • 온라인 구매 건은 구매 확정 8일 후 사용 가능한 포인트로 전환됩니다.<br>
				   • 멤버십 포인트는 상품별 100원 단위로 적립됩니다.<br>
				   • 최종 구매일로부터 1년 동안 구매 활동이 없을 시 멤버십 포인트는 자동 소멸됩니다.<br>
				   • 매장에서 삼성패션 브랜드 상품 구매 시 결제 전에 고객정보를 확인해 주시면 멤버십 포인트 적립 및 사용이 가능합니다.<br>
				   • 기존 마일리지는 포인트 조회페이지에서 멤버십 포인트로 전액 전환하여 사용하실 수 있습니다.<br>
				   • 멤버십 포인트 적립 내역 조회:<br>
				     - 고객센터(0000-0000) 전화 → 0번 멤버십 관련 문의<br>
				     - SAREN SHOP > 마이페이지 > 나의 쇼핑 혜택 > 멤버십 포인트 확인<br>
				     - 상품 구매 시 멤버십 적립 및 사용에 대한 알림톡 안내 서비스 제공</p>
			</div>
			<button class="accordion">멤버십 혜택 유의사항</button>
			<div class="panel void">
				<table class="popup-table">
					<tr>
						<th class="header">혜택</th>
						<th>내용</th>
					</tr>
					<tr>
						<td>생일축하 금액권</td>
						<td>생일월 첫 발급되며, 생일 다음달 마지막날까지 사용 가능합니다. (예, 3월 생일시 3월 첫 발급, 4월 30일까지 사용 가능)</td>
					</tr>
					<tr>
						<td>무료 AS 수선 서비스</td>
						<td>멤버십 등급에 따라 무료 AS 수선 서비스를 제공합니다.</td>
					</tr>
					<!-- 나머지 혜택 내용을 여기에 추가하세요 -->
				</table>
			</div>
		</div>
	</div>
	
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
							<a href="${path}/review/myreview.do">나의글</a>
						</h3>
						<ul class="myinfo_submenu">
							<li><a href="${path}/adminqna/myqna.do">문의글</a></li>
							<li><a href="${path}/review/myreview.do">리뷰</a></li>
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
									${member.member_name}님 <span>(${member.member_id})</span> <span class="birthText">${member.birth_date}</span>
								</h3>
								<div class="profile_text_box">
									<p>
										보유포인트: <span>${myPoints.point != 0 ? myPoints.point : 0 }p</span>
									</p>
									<p>
										회원등급: <span>${myPoints.member_level}</span>
									</p>
									<button class="detail_btn" onclick="openPopup()" >자세히 보기</button>
								</div>
								<p>
									<a href="${path}/review/myreview.do" class="go_review">작성한 리뷰 보기</a>
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
									<th>No.</th>
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
						                <c:forEach items="${myAllOrders}" var="order" varStatus="status">
					                        <tr>
					                        	<td>${order.ORDER_ID}</td>
					                            <td style="background-color:powderblue;"><img src="${order.IMG_ID}" alt="${order.IMG_ID}" width="100"></td>
					                            <td class="product-info">
					                                <strong>[${order.ORDER_STATE}]</strong><br>
					                                <p>${order.PROD_NAME} (${order.ORDER_NUM}개)</p>
					                            </td>
					                            <td>${order.ORDER_PRODUCT_PRICE}원<br></td>
					                            <td>
					                            	${order.ORDER_DATE}
					                            </td>
					                            <td class="price">${order.TOTAL_PRICE}원</td>
					                        </tr>
						                </c:forEach>
						            </c:when>
						            <c:otherwise>
						                <tr>
						                    <td colspan="6">주문 내역이 없습니다.</td>
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
									<th>No.</th>
									<th>상품 정보</th>
									<th>대여 가격</th>
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
						                                <strong>[${rent.RENT_STATE}]</strong><br>
						                               <span> ${rent.PROD_NAME}</span><span>(${rent.RENT_NUM}개)</span>
						                            </td>
						                            <td>${rent.RENT_PRODUCT_PRICE}원<br></td>
						                            <td class="rentDateText">
						                            	<p class="rent-start">${rent.RENT_START_DATE}</p>
						                            	<p>~</p>
						                            	<p class="rent-end">${rent.RENT_END_DATE}</p>
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
	<script>
		$(function() {
					
			
		});
		function openPopup() {
			document.getElementById('popup-overlay').style.display = 'flex';
		}

		function closePopup() {
			document.getElementById('popup-overlay').style.display = 'none';
		}

		var acc = document.getElementsByClassName("accordion");
		var i;

		for (i = 0; i < acc.length; i++) {
			acc[i].addEventListener("click", function() {
				this.classList.toggle("active");
				var panel = this.nextElementSibling;
				if (panel.style.display === "block") {
					panel.style.display = "none";
				} else {
					panel.style.display = "block";
				}
			});
		}
	</script>
</body>
</html>