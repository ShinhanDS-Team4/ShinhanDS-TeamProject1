<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<%-- 마이페이지 : 회원정보수정-2 비밀번호확인 후 회원정보 수정 폼 열기 --%>

<%-- 입력 폼 팝업창으로 수정중 --%>

<%--
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
	
	
	
	
	<%-- Modal content --%>
	<div id="myModal" class="modal">
	<div class="myinfo-modal-content">
	   <span class="close">&times;</span>
	   <div class="modal-content">
	       <div class="section myinfo_update">
	           <h2>회원 정보 수정</h2>
	           <div class="infoForm_wrap">
	               <form id="infoForm">
	                   <label for="member_id">아이디</label> 
	                   <input type="text" id="member_id" name="member_id" placeholder="영문, 숫자, 영문+숫자 6자 이상" value="${member.member_id}"> 
	                   
	                   <label for="member_pw">비밀번호</label> 
	                   <input type="text" id="member_pw" name="member_pw" value="${member.member_pw}" required> 
	                   
	                   <label for="member_name">이름</label> 
	                   <input type="text" id="member_name" name="member_name" value="${member.member_name}" disabled="disabled"> 
	                   
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
                		 
                		 $('.modal').css("display","block");
                		 $('.myinfo-modal-content').css("display","block");
                		 
                		 //팝업창 열기
                		 //$().show();
                		 
	                	 //비밀번호 체크 후 맞으면 다음 스탭(step3)
	                    /*  $.ajax({
	                           url: "${path}/customer/myInfoUpdate_step3.do", // 로드할 JSP 페이지의 경로
	                           type: "GET",
	                           success: function(htmlContent) {
	                               $(".mypage_here").html(htmlContent);
	                           },
	                           error: function(xhr, status, error) {
	                               console.error("Error loading step 3: " + error);
	                           }
	                       });  */
	                       //JS
	                   
		                 
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
		 	
		 	
		 	
		 	
		 	
       });
</script>
--%>