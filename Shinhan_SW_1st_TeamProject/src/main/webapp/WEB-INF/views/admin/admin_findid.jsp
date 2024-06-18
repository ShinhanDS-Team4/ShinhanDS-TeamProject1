<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/views/admin/css/admin_login.css" rel="stylesheet">
</head>
<body>

    <div class="login-container">
        <h2>아이디 찾기</h2>
        <form action="admin_findid" method="post">
            <div class="form-group">
                <label for="admin_email">이메일</label>
                <input type="email" class="form-control" id="admin_email" name="admin_email" required>
            </div>
            <div class="form-group">
                <label for="admin_name">이름</label>
                <input type="text" class="form-control" id="admin_name" name="admin_name" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block">아이디 찾기</button>
        </form>
    </div>

</body>
</html>
