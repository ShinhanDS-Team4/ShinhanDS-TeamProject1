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
<%-- 카카오API --%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
	#addrAddForm>h1{
		padding-bottom: 10px;
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
        padding-top: 20px;
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
         
         //클릭한 주소 목록 화면에서 삭제 
         $('.delete-btn').click(function() {
			$(this).closest('.address-box').remove();
		 });
         
	});
</script>
<body>
	<%@ include file="../common/header.jsp" %>
	<%-- 배송지 입력 팝업창 --%>
    <div class="overlay"></div>
	<div id="addrAdd_wrap">
	    <form action="${path}/customer/myAddrInsert" method="post" id="addrAddForm">
	    	<h1>배송지 입력</h1>
			<span class="close">&times;</span>
	        <label for="shipping-name">배송지 명 <span style="color: red;">*</span></label>
	        <input type="text" id="shipping-name" name="shipping-name" placeholder="최대 10글자로 작성해주세요" required maxlength="10">
	
	        <label for="recipient-name">받으실 분 <span style="color: red;">*</span></label>
	        <input type="text" id="recipient-name" name="recipient-name" placeholder="최대 10글자로 작성해주세요" required maxlength="10">
	
	        <label for="phone-number">휴대폰 번호 <span style="color: red;">*</span></label>
	        <input type="tel" id="phone-number" name="phone-number" placeholder="010-0000-0000" required pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}">
	        <div class="info">안심번호 서비스 <i>(?)</i></div>
	
	        <label for="address">주소 <span style="color: red;">*</span></label>
	        
	        <%-- 우편번호API --%>	
			<input type="text" id="sample6_postcode" placeholder="우편번호" name="zipcode">
			<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" id="sample6_address" placeholder="주소" name="main_address"><br>
			<input type="text" id="sample6_detailAddress" placeholder="상세주소" name="detail_address">
			<input type="text" id="sample6_extraAddress" placeholder="참고항목" name="sub_address">
			<br/>
			<span>대표주소 설정</span>
			<input type="checkbox" name="is_master_addr">
			
	        <input type="submit" value="확인">
	    </form>
    </div>
   
	<script>
	    function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample6_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample6_postcode').value = data.zonecode;
	                document.getElementById("sample6_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("sample6_detailAddress").focus();
	            }
	        }).open();
	    }
	</script>
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
							<div class="label">대표</div>
							<div class="info">
								홍길동<strong>010-0000-0000</strong><br> 00000 서울특별시 00구
								00로 00(00동, 00타운) A동
							</div>
							<button class="delete-btn">삭제</button>
						</div>
						<%-- <form action="${path}/cutomer/수정">--%>
							<div class="address-box">
							<c:forEach var="addr" items="${addrlist}">  
								<div class="label">대표</div>
								<div class="info">
									홍길동<strong>010-0000-0000</strong><br> 
									 [${addr.zipcode}] ${addr.main_address}
									 ${addr.detail_address} ${addr.sub_address}
								</div>
								<button class="delete-btn">삭제</button>
							</c:forEach>
							</div>
						<%--</form>--%>
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