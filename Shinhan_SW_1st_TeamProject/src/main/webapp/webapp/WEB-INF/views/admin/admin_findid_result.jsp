<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기 결과</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/views/admin/css/admin_login.css" rel="stylesheet">
</head>
<body>

    <div class="login-container">
        <h2>아이디 찾기 결과</h2>
        <p>${findIdResult}</p>
        <a href="admin_login" class="btn btn-primary btn-block">로그인 페이지로 돌아가기</a>
    </div>

</body>
</html>
