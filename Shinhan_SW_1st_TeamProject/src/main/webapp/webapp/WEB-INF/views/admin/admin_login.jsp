<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 로그인</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <div class="login-background">
        <div class="login-popup">
            <h2>관리자 로그인</h2>
            <form id="loginForm" action="admin_login" method="post">
                <div class="form-group">
                    <label for="admin_id">사용자 이름</label>
                    <input type="text" class="form-control" id="admin_id" name="admin_id" value="admin" required>
                </div>
                <div class="form-group">
                    <label for="admin_pw">비밀번호</label>
                    <input type="password" class="form-control" id="admin_pw" name="admin_pw" value="admin" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block">로그인</button>
                <div class="form-find">
                    <a href="#" onclick="resetForm()">초기화</a>
                    <a href="#" onclick="openFindIdPopup()">아이디 찾기</a>
                    <a href="#" onclick="openFindPwPopup()">비밀번호 찾기</a>
                </div>
            </form>
        </div>
    </div>

    <!-- ID 찾기 팝업 -->
    <div id="findIdPopup" class="popup">
        <div class="popup-content">
            <span class="close" onclick="closeFindIdPopup()">&times;</span>
            <h2>아이디 찾기</h2>
            <form action="admin_findid" method="post">
                <div class="form-group">
                    <label for="find_admin_email">이메일</label>
                    <input type="email" class="form-control" id="find_admin_email" name="admin_email" required>
                </div>
                <div class="form-group">
                    <label for="find_admin_name">이름</label>
                    <input type="text" class="form-control" id="find_admin_name" name="admin_name" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block">아이디 찾기</button>
            </form>
        </div>
    </div>

    <!-- PW 찾기 팝업 -->
    <div id="findPwPopup" class="popup">
        <div class="popup-content">
            <span class="close" onclick="closeFindPwPopup()">&times;</span>
            <h2>비밀번호 찾기</h2>
            <form action="admin_findpw" method="post">
                <div class="form-group">
                    <label for="find_pw_admin_id">아이디</label>
                    <input type="text" class="form-control" id="find_pw_admin_id" name="admin_id" required>
                </div>
                <div class="form-group">
                    <label for="find_pw_admin_name">이름</label>
                    <input type="text" class="form-control" id="find_pw_admin_name" name="admin_name" required>
                </div>
                <div class="form-group">
                    <label for="find_pw_admin_phone">연락처</label>
                    <input type="text" class="form-control" id="find_pw_admin_phone" name="admin_phone" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block">비밀번호 찾기</button>
            </form>
        </div>
    </div>

    <script>
        function openFindIdPopup() {
            document.getElementById("findIdPopup").style.display = "block";
        }

        function closeFindIdPopup() {
            document.getElementById("findIdPopup").style.display = "none";
        }

        function openFindPwPopup() {
            document.getElementById("findPwPopup").style.display = "block";
        }

        function closeFindPwPopup() {
            document.getElementById("findPwPopup").style.display = "none";
        }

        function resetForm() {
            document.getElementById("loginForm").reset();
        }
    </script>

    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #343a40;
        }

        .login-background {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
        }

        .login-popup {
            background-color: #212529;
            color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.5);
            width: 400px;
            max-width: 100%;
            text-align: center;
        }

        .popup {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }

        .popup-content {
            background-color: #212529;
            color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.5);
            width: 400px;
            max-width: 100%;
            text-align: center;
            margin: 10% auto;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        h2 {
            margin-bottom: 20px;
            color: #007bff;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }

        .form-group label {
            float: left;
        }

        .form-group input {
            background-color: #495057;
            color: #fff;
            border: none;
        }

        .form-group input:focus {
            background-color: #495057;
            color: #fff;
            border: 1px solid #007bff;
        }

        .form-find {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }

        .form-find a {
            color: #007bff;
            text-decoration: none;
            cursor: pointer;
        }

        .form-find a:hover {
            text-decoration: underline;
        }
    </style>

</body>
</html>
