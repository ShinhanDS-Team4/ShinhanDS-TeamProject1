<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지-회원정보수정</title>
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
    .overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        z-index: 999;
    }
	#addrAdd_wrap{
		display: none; 
	}
	#addrAddForm {
	    z-index: 1000;
	    background-color: #fefefe;
	    margin: 0 auto;
	    padding: 20px;
	    border: 1px solid #888;
	    width: 70%;
	    padding: 70px 20px;
	    max-width: 600px;
	    position: fixed;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
        border-radius: 30px;
	}
    }
    label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }
    input[type="text"], input[type="tel"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    input[type="button"] {
        padding: 10px 15px;
        border: 1px solid #ccc;
        background-color: #f1f1f1;
        cursor: pointer;
    }
    input[type="submit"] {
        width: 100%;
        padding: 10px;
        background-color: #513AE4;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    input[type="submit"]:hover {
        background-color: #513AE4;
    }
    .info {
        font-size: 0.9em;
        color: gray;
        margin-bottom: 15px;
    }
    .close {
        position: absolute;
	    right: 20px;
	    top: 10px;
	    font-size: 30px;
	    font-weight: bold;
	    color: #aaa;
	    cursor: pointer;
	}
	.close:hover,
	.close:focus {
	    color: #513AE4;
	    text-decoration: none;
	    cursor: pointer;
	}
</style>
<script type="text/javascript">
	function findAddress() {
	    // 주소 찾기 기능 
	    alert("주소 찾기 기능");
	}
	$(function() {
         $('#addrAddButton').click(function() {
             $('.overlay, #addrAdd_wrap').show();
         });

         $('.close').click(function() {
             $('.overlay, #addrAdd_wrap').hide();
         });

         $(window).click(function(event) {
             if ($(event.target).is('.overlay')) {
                 $('.overlay, #addrAdd_wrap').hide();
             }
         });
	});
</script>
<body>
	<%@ include file="../common/header.jsp" %>
	<%-- 배송지 입력 팝업창 --%>
    <div class="overlay"></div>
	<div id="addrAdd_wrap">
	    <form action="/submit" method="post" id="addrAddForm">
			<span class="close">&times;</span>
	        <label for="shipping-name">배송지 명 <span style="color: red;">*</span></label>
	        <input type="text" id="shipping-name" name="shipping-name" placeholder="최대 10글자로 작성해주세요" required maxlength="10">
	
	        <label for="recipient-name">받으실 분 <span style="color: red;">*</span></label>
	        <input type="text" id="recipient-name" name="recipient-name" placeholder="최대 10글자로 작성해주세요" required maxlength="10">
	
	        <label for="phone-number">휴대폰 번호 <span style="color: red;">*</span></label>
	        <input type="tel" id="phone-number" name="phone-number" placeholder="010-0000-0000" required pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}">
	        <div class="info">안심번호 서비스 <i>(?)</i></div>
	
	        <label for="address">주소 <span style="color: red;">*</span></label>
	        <input type="text" id="address" name="address" placeholder="주소 찾기로 입력해주세요" required>
	        <input type="button" value="주소 찾기" onclick="findAddress()">
	        <input type="text" id="detailed-address" name="detailed-address" placeholder="상세 주소를 입력해주세요" required>
	
	        <input type="submit" value="확인">
	    </form>
    </div>
	<%-- 마이페이지 : 회원정보수정 --%>
	<div class="mypage_wrap">
		<div class="myinfo inner">
			<nav>
				<ul>
					<li>
						<h3>
							<a href="${path}/customer/orderlist">나의주문</a>
						</h3>
					</li>
					<li>
						<h3>
							<a href="${path}/customer/rentlist">나의대여</a>
						</h3>
					</li>
					<li>
						<h3>
							<a href="${path}/cart/cart">장바구니</a>
						</h3>
					</li>
					<li>
						<h3>
							<a href="${path}/board/reviewjsp">나의글</a>
						</h3>
						<ul class="myinfo_submenu">
							<li><a href="javascript:#void">문의글</a></li>
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
				<div class="section_wrap">
					<h1 class="myinfo_title">회원 정보 수정</h1>
					<div class="section myinfo_update">
						<!-- "비밀번호 확인" 버튼 클릭: myinfo_update에서 페이지 업데이트 -->
						<div class="pw-check">
							<p>회원님의 개인정보보호를 위한 본인 확인절차를 위해 비밀번호를 입력해 주세요.</p>
							<button id="loadButton" class="button">비밀번호 확인</button>
						</div>
					</div>
					<h2 class="myinfo_title">나의 배송지</h2>
					<div class="section">
						<div class="address-box">
							<div class="label">기본</div>
							<div class="info">
								홍길동 <strong>010-0000-0000</strong><br> [00000] 서울특별시 00구
								00로 00(00동, 00타운) A동
							</div>
							<button class="delete-btn">삭제</button>
						</div>
						<div class="adress-add">
							<button id="addrAddButton" class="button">배송지 추가</button>
						</div>
					</div>
				</div>
			</div>
			<script type="text/javascript">
				 $(document).ready(function(){
		            $("#loadButton").click(function(){
		                //$("#mypage_here").load("${path}/customer/myInfoUpdate_step2.do");
		                
		                $.ajax({
		                    url: "${path}/customer/myInfoUpdatePw.do",
		                    type: "GET",
		                    success: function(data) {
		                        $(".mypage_here").html(data);
		                    },
		                    error: function(xhr, status, error) {
		                        console.error("Error: " + error);
		                    }
		                });
		            });
		        });
			</script>
		</div>
	</div>
</body>
</html>