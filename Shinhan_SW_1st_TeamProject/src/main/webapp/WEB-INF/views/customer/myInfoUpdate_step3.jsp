<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<%-- 마이페이지 : 회원정보수정-3 정보입력폼 이 페이지 삭제 예정 --%>
<%-- 팝업창으로 수정중 --%>
<%-- <div class="section_wrap">
	<h1 class="myinfo_title">회원 정보 수정</h1>
	<div class="section myinfo_update">
		<h2>나의 정보 수정</h2>
		<div class="infoForm_wrap">
			<form id="infoForm">
				<label for="user-id">아이디</label> 
				<input type="text"
					id="member_id" name="member_id" placeholder="영문, 숫자, 영문+숫자 6자 이상" value="${member.member_id}"> 
				<label for="password">비밀번호</label> 
				<input type="text" id="member_pw" name="member_pw" value="${member.member_pw}" required> 
				<label for="name">이름 </label> 
				<input type="text" id="member_name" name="member_name" value="${member.member_name}" disabled="disabled"> 
				<label for="phone">휴대폰 번호</label>
				<input type="text" id="phone" name="phone" value="${member.phone}" required>
				<label for="email">이메일</label> 
				<input type="text" id="email" name="email" value="${member.email}"> 
				
				<input id="infoUpdateBtn" type="button" value="회원 정보 수정" />
			</form>
		</div>
	</div>
</div>   
		  
<script>
	 $(document).ready(function(){         
            //$("#infoUpdateBtn").click(function(e){
   
       	        // 수정한 회원 정보 데이터 JSON 형식으로 변환
       	        var myInfoData = {
       	          member_id : $("#member_id").val(),
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
                		   location.href("${path}/custmoer/myPage.do");
                	   }else{
                		   alert("오류가 발생하였습니다. 다시 시도해주세요.");
                	   }
                	   
               	  },
                   error: function(xhr, status, error) {
                       console.error("Error: " + error);
                   }
               });
           //}); 
       });
</script> 

--%>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           