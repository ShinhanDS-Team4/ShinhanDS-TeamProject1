<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>판매자 목록</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .sidebar {
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            background-color: #343a40;
            color: #fff;
            padding-top: 20px;
        }
        .sidebar a {
            color: #fff;
            text-decoration: none;
            display: block;
            padding: 10px 20px;
        }
        .sidebar a:hover {
            background-color: #495057;
        }
        .content {
            margin-left: 250px;
            padding: 20px;
        }
    </style>
</head>
<body>

    <div class="sidebar">
        <h2 class="text-center"><a href="adminpage">NiceAdmin</a></h2>
        <a href="adminpage">Dashboard</a>
        <a href="admin_seller_list">판매자 목록</a>
        <a href="admin_seller_register">판매자 등록</a>
        <a href="admin_seller_detail">판매자 상세</a>
        <a href="admin_faq">F.A.Q</a>
    </div>

    <div class="content">
        <div class="container-fluid">
            <h1>판매자 목록</h1>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Brand</th>
                            <th>Ext.</th>
                            <th>City</th>
                            <th>Status</th>
                            <th>Start Date</th>
                            <th>수정/삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><a href="admin_seller_detail?userid">Unity Pugh</a></td>
                            <td>adidas</td>
                            <td>9958</td>
                            <td>Curicó</td>
                            <td>access</td>
                            <td>2005/02/11</td>
                            <td><button class="btn btn-sm btn-primary" onclick="window.location.href='seller_detail.html'">수정</button> <button class="btn btn-sm btn-danger">삭제</button></td>
                        </tr>              
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>

