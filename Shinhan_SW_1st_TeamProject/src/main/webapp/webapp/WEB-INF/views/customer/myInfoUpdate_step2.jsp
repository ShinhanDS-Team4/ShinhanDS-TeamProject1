<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<%-- 마이페이지 : 회원정보수정-2 비밀번호확인 --%>

<div class="mypage_here">
	<div class="section_wrap">
		<h1 class="myinfo_title">회원 정보 수정</h1>
		<div class="section myinfo_update">
			<!-- "비밀번호 확인" 버튼 클릭: myinfo_update에서 페이지 업데이트 -->
			<div class="pw-check">
				<p>
					회원님은 <strong>saren123</strong> 아이디로 로그인하셨습니다.
				</p>
				<p>회원님의 개인정보보호를 위한 본인 확인절차를 위해 SAREN 비밀번호를 입력해 주세요.</p>
				<input type="password" placeholder="비밀번호를 입력 해주세요."
					id="pw-check_input" class="pw-check_input">
				<div>
					<button class="cancel">취소</button>
					<button id="confirmButton" class="confirm button">확인</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	 $(document).ready(function(){         
           //확인 버튼 클릭하면 비밀번호 검토 없이 바로 넘어감 -> 로직 수정 필요
            $("#confirmButton").click(function(){
        	   var password = $("#pw-check_input").val(); //입력한 비밀번호
               $.ajax({
                   url: "${path}/customer/myInfoUpdatePwCheck.do",
                   type: "get",
                   data: { password: password },
                   success: function(data) {
                	   //비밀번호 체크 후 맞으면 다음 스탭(step3)
                	   alert("비밀번호 확인 성공");
                       $(".mypage_here").html(data);
                   },
                   error: function(xhr, status, error) {
                       console.error("Error: " + error);
                   }
               });
           }); 
       });
</script>