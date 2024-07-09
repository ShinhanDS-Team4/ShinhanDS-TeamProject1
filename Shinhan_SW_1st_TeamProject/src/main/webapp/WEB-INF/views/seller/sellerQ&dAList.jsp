<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자Q&A</title>
<!-- 본문 css -->
<link rel="stylesheet" href="${path}/resources/css/style.css">
<!-- 헤더,푸터 css -->
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<!-- jquery 연결 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- Slick 불러오기 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
<!-- Slick 직접 연결 -->
<link rel="stylesheet" href="${path}/resources/slick/slick-theme.css">
<link rel="stylesheet" href="${path}/resources/slick/slick.css">
<!-- 페이지용 css -->
<link rel="stylesheet" href="${path}/resources/css/q&a_list.css" />
<script src="${path}/resources/slick/slick.min.js"></script>
<script>
	function addAdminQAPopUp(){
		var popup = window.open("addAdminQA.do","_blank","width=1000,height=1000,scrollbars=yes");
		popup.onbeforeunload = function() {
            window.location.reload();
        };
	}
	
	function answerCustomerPopUp(buyer_inq_id){
		var popup = window.open("answerCustomer.do?buyer_inq_id="+buyer_inq_id,"_blank","width=1000,height=1000,scrollbars=yes");
		popup.onbeforeunload = function() {
            window.location.reload();
        };
	}
	
	function adminAnswerPopUp(admin_inq_id){
		var popup = window.open("answerAdmin.do?admin_inq_id="+admin_inq_id,"_blank","width=1000,height=1000,scrollbars=yes");
		popup.onbeforeunload = function() {
            window.location.reload();
        };
	}
</script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<main>

		<aside>
			<ul>
				<%-- <li><a onclick="location.href='${path}/seller/MainPage.do'">통계</a></li> --%>
				<li><a onclick="location.href='${path}/seller/PrdList.do'">판매/대여
						상품 목록</a></li>
				<li><a onclick="location.href='${path}/seller/DeliveryList.do'">주문/배송</a></li>
				<li><a onclick="location.href='${path}/seller/Q&AList.do'">문의
						목록</a></li>
			</ul>
		</aside>
		<section>
			<h2>마이페이지</h2>
			<hr />
			<div class="user-info">
				<p>${sellerInfo.member_name}</p>
				<p>${sellerInfo.member_id}</p>
			</div>
			<!-- 고객 문의글 -->
			<h3>고객 문의 목록</h3>
			<div class="product-list">
				<table>
					<thead>
						<tr>
							<th>문의등록번호</th>
							<th>문의제목</th>
							<th>등록일자</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="buyer_qa" items="${buyerQAList}">
							<tr>
								<td>${buyer_qa.buyer_inq_id}</td>
								<td>${buyer_qa.buyer_inq_title}</td>
								<td>${buyer_qa.buyer_inq_date}</td>
								<td>
									<c:choose>
										<c:when test="${buyer_qa.buyer_reply == null}">답변 대기중</c:when>
									<c:otherwise>답변 완료</c:otherwise>
									</c:choose>
								</td>
								<td><button onclick="answerCustomerPopUp(${buyer_qa.buyer_inq_id})">답변작성</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<h3>관리자 답변 목록</h3>
			<div class="product-list">
				<table>
					<thead>
						<tr>
							<th>문의등록번호</th>
							<th>문의제목</th>
							<th>등록일자</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="admin_qa" items="${adminQAList}">
							<tr>
								<td>${admin_qa.admin_inq_id}</td>
								<td>${admin_qa.admin_inq_title}</td>
								<td>${admin_qa.admin_inq_date}</td>
								<td>
									<c:choose>
										<c:when test="${admin_qa.admin_reply == null}">답변 대기중</c:when>
									<c:otherwise>답변 완료</c:otherwise>
									</c:choose>
								</td>
								<td><button onclick="adminAnswerPopUp(${admin_qa.admin_inq_id})">조회</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
			</div>
			<div class="actions">
					<button onclick="addAdminQAPopUp()">문의 등록</button>
				</div>
		</section>
		<%-- <aside class="notifications">
			<div class="notify_icon">
				<img src="${path}/resources/images/bell.png" alt="알림"
					class="bell_icon" />
				<div class="icon">
					<span>15</span>
				</div>
				<div class="popup">
					<p>결제 완료 주문 : 5건</p>
					<p>결제 대기 주문 : 23건</p>
				</div>
			</div>
		</aside> --%>
	</main>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>