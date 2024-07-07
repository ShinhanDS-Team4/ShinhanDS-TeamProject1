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

<%-- 카카오 우편번호 및 주소입력 API 연결 --%>
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
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	
	<%-- Modal content --%>
	<div id="myModal" class="">
		<div class="myinfo-modal-content modal">
		   <span class="close">&times;</span>
		   <div class="modal-content">
			   <h1>회원 정보 수정</h1 >
		       <div class="section myinfo_update">
		           <div class="infoForm_wrap">
		               <form id="infoForm">
		                   <label for="member_id">아이디</label> 
		                   <input type="text" id="member_id" name="member_id" placeholder="영문, 숫자, 영문+숫자 6자 이상" value="${member.member_id}"> 
		                   
		                   <label for="member_pw">비밀번호</label> 
		                   <input type="text" id="member_pw" name="member_pw" value="${member.member_pw}" required> 
		                   
		                   <label for="member_name">이름</label> 
		                   <input type="text" id="member_name" name="member_name" value="${member.member_name}" disabled="disabled"> 
		                       
		                   <label for="birth_date">생년월일</label> 
		                   <input type="text" id="birth_date" name="birth_date" value="${member.birth_date}"  disabled="disabled"> 
		                   
		                   <label for="phone">휴대폰 번호</label>
		                   <input type="text" id="phone" name="phone" value="${member.phone}" required>
		                   
		                   <label for="email">이메일</label> 
		                   <input type="text" id="email" name="email" value="${member.email}"> 
		               
		                   <input id="infoUpdateBtn" type="button" value="회원 정보 수정" />
		               </form>
		           </div>
		       </div>
		   </div>
		</div>
	</div>
	
	
	<%-- 마이페이지 : 회원정보수정 --%>
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
				<div class="section_wrap">
					<h1 class="myinfo_title">회원 정보 수정</h1>
					<form id="pwCheckForm">
						<div class="section myinfo_update">
							<div class="pw-check">
								<p>
									회원님은 <strong style="color:#513AE4; font-weight: bold;">${member.member_id}</strong> 아이디로 로그인하셨습니다.
								</p>
								<p>회원님의 개인정보보호를 위한 본인 확인절차를 위해 <span style="color:#513AE4;">${member.member_id}</span>  비밀번호를 입력해 주세요.</p>
								<input type="password" placeholder="비밀번호를 입력 해주세요."
									id="pw-check_input" name="pw-check_input" class="pw-check_input" value="">
								<p class="text_here" style="color:red;"></p>
								<div>
									<button class="cancel" type="button">취소</button>
									<button id="confirmButton" type="button" class="confirm button">확인</button>
								</div>
							</div>	
						</div>
					</form>
				</div>
			</div>
		</div>	
	</div>
	<%@ include file="../common/footer.jsp" %>
	<script>
	 $(document).ready(function(){   
		 	
		 	//비밀번호 확인 버튼
            $("#confirmButton").click(function(e){
        	    e.preventDefault();
       	        var password = $("#pw-check_input").val(); // 입력한 비밀번호
       	        console.log(password);
       	        
       	        // 비밀번호 데이터를 JSON 형식으로 변환
       	        var pwData = {
       	            password: password
       	        };
      	        
               $.ajax({
                   url: "${path}/customer/myInfoUpdatePwCheck.do",
                   type: "POST", 
                   contentType: "application/json",
                   data: JSON.stringify(pwData), // JSON 문자열로 변환하여 전송
                   success: function(reseponseData) {
               	  	 if(reseponseData == 1){
                		 alert("비밀번호 확인 성공");
         		 
                		 //팝업창 열기
                		 //$('.modal').css("display","block");
                		 $('#myModal').addClass("modal");
                		 $('.myinfo-modal-content').css("display","block");
		                 
               	   } else{
	           		   $(".text_here").text("비밀번호가 틀렸습니다.");
          	  		}
               	  },
                   error: function(xhr, status, error) {
                       console.error("Error: " + error);
                   }
               });
           }); 
		 	
		 	//회원정보수정 버튼
		 	$("#infoUpdateBtn").click(function(e){
   				console.log("회원정보수정 버튼");
       	        // 수정한 회원 정보 데이터 JSON 형식으로 변환
       	        var myInfoData = {
       	          member_pw : $("#member_pw").val(),
       	          phone : $("#phone").val(),
       	          email : $("#email").val()       	           
       	        };
   	        
               $.ajax({
                   url: "${path}/customer/myInfoUpdateForm",
                   type: "POST", 
                   contentType: "application/json",
                   data: JSON.stringify(myInfoData),
                   success: function(reseponseData) {
                	   if(reseponseData == 1){
                		   alert("회원 정보 수정 성공");

                  		 //팝업창 닫기
                  		 $('#myModal').removeClass("modal");
                  		 $('.myinfo-modal-content').css("display","none");
                		   location.reload();
                		   
                	   }else{
                		   alert("오류가 발생하였습니다. 다시 시도해주세요.");
                	   }
               	  },
                   error: function(xhr, status, error) {
                       console.error("Error: " + error);
                   }
               });
           }); 
		 	 //팝업창 닫기
		 	$('.close').click(function(e) {
		 		 $('#myModal').removeClass("modal");
         		$('.myinfo-modal-content').css("display","none");
			});
		 	
       });
</script>
</body>
</html>