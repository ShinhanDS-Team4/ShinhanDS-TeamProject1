<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<%-- css --%>
<link rel="stylesheet" href="${path}/resources/css/mypage.css">
<%-- 헤더,푸터 css --%>
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<%-- jquery 연결 --%>
<script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
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
			<%-- 회원 탈퇴  --%>
			<div class="mypage_here">
				<div class="section_wrap">
					<h1 class="myinfo_title">회원 탈퇴</h1>
					<div class="section myinfo_update">
						<h2 class="member_cancel">회원 탈퇴</h2>
						<div class="pw-check">
							<p>회원 탈퇴를 위해 비밀번호를 입력 하세요.</p>
							<input type="password" placeholder="비밀번호를 입력 해주세요."
								id="pw-check_input" class="pw-check_input">
							<div>
								<button class="cancel">취소</button>
								<button id="deleteButton" class="confirm button">탈퇴</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<script>
				$(document).ready(function(){       
			            $("#deleteButton").click(function(){
			        	   var password = $("#pw-check_input").val(); //입력한 비밀번호
			               $.ajax({
			                   url: "${path}/customer/memberDeletePwCheck.do",
			                   type: "get",
			                   data: { password: password },
			                   success: function(data) {
			                	   alert(data); 
			                	   if(data == "회원 탈퇴 완료") {
			                		   window.location.href = "${path}/";
			                	   }
			                   },
			                   error: function(xhr, status, error) {
			                       console.error("Error: " + error);
			                       console.error("Status: " + status);
			                       console.error("Response Text: " + xhr.responseText);
			                       console.error("XHR Object: ", xhr);
			                   }
			               });
			           }); 
			       });
			</script>
		</div>
	</div>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>