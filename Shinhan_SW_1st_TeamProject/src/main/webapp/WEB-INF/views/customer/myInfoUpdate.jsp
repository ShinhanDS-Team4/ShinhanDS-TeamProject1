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
    #searchPostcode {
        padding: 10px 15px;
        border: 1px solid #ccc;
        background-color: #f1f1f1;
        cursor: pointer;
    }
    #submitBtn {
        width: 100%;
        padding: 10px;
        background-color: #513AE4;
        color: white;
        border: none;
        border-radius: 6px;
	    cursor: pointer;
	    margin-top: 30px;
	    font-size: 18px;
	    font-weight: bold;
    }
    #submitBtn:hover {
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
         
         //클릭한 주소 목록 화면에서 삭제  (작업중)
         $('.delete-btn').click(function(e) {
        	 e.preventDefault();
        	 
       	 
        	 
        	 // 클릭된 버튼의 부모 요소인 address-box를 찾음
       		 var addressBox = $(this).parent('.address-box');
        	 var addr_num = addressBox.find('input[type="hidden"]').val();
        	 console.log('삭제할 주소 번호: ' + addr_num);
       	    
       	 	 // 현재 address-box의 개수를 계산
       	     var addressBoxCount = $('.address-box').length;
       	     console.log('현재 address-box 개수: ' + addressBoxCount);
       	     
       	     
       	    // 삭제 요청을 위한 데이터
       	    var addrData = {
       	        addr_num: addr_num
       	    };
       	    console.log(addrData);
       
       	    // 주소가 1개 이상일 때만 삭제 요청
       	    if (addressBoxCount > 1) {
	       	    // 확인 절차 추가
	       	    if (!confirm("정말로 이 주소를 삭제하시겠습니까?")) {
	       	    	
	       	        return;
	       	    }
				$.ajax({
	                url: "${path}/customer/myAddrDelete.do",
	                type: "POST",
	                contentType: 'application/json',
	                data: JSON.stringify(addrData),
	                success: function(resultData) {
	                	
	                	if(resultData == 1){
	                		
	 	                    //$(".resultText_here").text("삭제되었습니다."); //아직 css 없음
	 	                    alert("배송지가 삭제되었습니다.");
	                	}else{
	                		//$(".resultText_here").test("오류가 발생했습니다. 다시 시도해주세요.");
	 	                    alert("오류가 발생했습니다. 다시 시도해주세요.");
	                	}
	                	
	                },
	                error: function(xhr, status, error) {
	                    console.error("Error: " + error);
	                    //$(".resultText_here").text("서버 오류가 발생했습니다. 다시 시도해주세요.");
	                }
	            });
       	    } else {
       	        alert("주소는 최소 1개 이상 존재해야 합니다. 삭제할 수 없습니다.");
       	    }
				
		 });
         
        //대표 주소로 설정
        $('.address-box').click(function() {
			
		}) 
	});
</script>
<body>
	<%@ include file="../common/header.jsp" %>
	<div class="overlay"></div>
	<div>
		<p class="resultText_here"></p>
	</div>
	<%-- 배송지 입력 팝업창 --%>
    <div class="overlay"></div>
	<div id="addrAdd_wrap">
	    <form id="addrAddForm">
	    	<h1>배송지 입력</h1>
			<span class="close">&times;</span>
	        <label for="address">주소 <span style="color: red;">*</span></label>

	        <%-- 우편번호API --%>	
			<input type="text" id="sample6_postcode" placeholder="우편번호" name="zipcode">
			<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" id="searchPostcode"><br>
			<input type="text" id="sample6_address" placeholder="주소" name="main_address"><br>
			<input type="text" id="sample6_detailAddress" placeholder="상세주소" name="detail_address">
			<input type="text" id="sample6_extraAddress" placeholder="참고항목" name="sub_address">
			<br/>
			<span>대표주소 설정</span>
			<input type="checkbox" name="is_master_addr" id="isMasterAddr">
			
	        <input type="button" id="submitBtn" value="확인">
	    </form>
    </div>
    <script type="text/javascript">
    $(function() {
    	
    	//배송지 팝업 확인 버튼
    	$('#submitBtn').on('click', function(e) {
    		e.preventDefault();
    		
    		var isMasterAddrChecked = $("#isMasterAddr").is(":checked") ? "Y" : "N";
    		var addrAddFormData = {
                zipcode: $("#sample6_postcode").val(),
                main_address: $("#sample6_address").val(),
                detail_address: $("#sample6_detailAddress").val(),
                is_master_addr:  isMasterAddrChecked,
                sub_address: $("#sample6_extraAddress").val()
            };
    		console.log(addrAddFormData);
            $.ajax({
                type: "POST",
                url: "${path}/customer/myAddrInsert.do",
                data: JSON.stringify(addrAddFormData),
                contentType: 'application/json',
                dataType: 'json',
                success: function(resultData) {
                    if(resultData == 1){
                    	alert("배송지가 추가되었습니다.");
                    	location.reload();
                    	
                    }else{
                    	alert("오류가 발생되었습니다. 다시 시도해 주세요.");
                    	location.reload();
                    }
                },
                error: function(request, status, error) {
                    console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
            });
    	});
    	
    });
    </script>
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
				<form id="addrListForm" method="post">
					<div class="section">
						<c:forEach items="${addrlist}" var="addr">
							<div class="address-box">
								<div class="label">
									${addr.IS_MASTER_ADDR == "Y" ? "대표" : ""}
								</div>
								<input type="hidden" value="${addr.ADDR_NUM}">
								<div class="info">
									${addr.MEMBER_NAME}<strong>${addr.PHONE}</strong><br> >
									(${addr.ZIPCODE}) 
									${addr.MAIN_ADDRESS}
									${addr.DETAIL_ADDRESS}
									${addr.SUB_ADDRESS}
								</div>
								<button class="delete-btn">삭제</button>
							</div>
						</c:forEach>
						<div class="adress-add">
							<button id="addrAddButton" type="button" class="button">배송지 추가</button>
						</div>
					</div>
				</form>
				</div>
			</div>
			<script type="text/javascript">
				 $(document).ready(function(){
		            $("#loadButton").click(function(){
		                //$("#mypage_here").load("${path}/customer/myInfoUpdate_step2.do");
		                
		                $.ajax({
		                    url: "${path}/customer/myInfoUpdatePw.do",
		                    type: "POST",
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
	<%@ include file="../common/footer.jsp" %>
</body>
</html>