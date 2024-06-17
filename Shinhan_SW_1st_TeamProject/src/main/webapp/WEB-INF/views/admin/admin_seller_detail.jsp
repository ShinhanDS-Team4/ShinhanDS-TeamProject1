<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>판매자 상세</title>
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
        .table-container {
            margin-top: 20px;
        }
        .btn {
            background-color: #007bff;
            color: white;
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
            <h1>판매자 상세</h1>
            <h2>Unity Pugh (판매자명)</h2>
            <p>금지 상품을 올렸을 경우 관리자가 판매자의 상품을 임의로 삭제 후 판매자에게 통지</p>
            <div class="table-container">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Preview</th>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Sold</th>
                            <th>Revenue</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>24.05.29</td>
                            <td><img src="product1.jpg" alt="Product 1" style="width: 50px;"></td>
                            <td>Ut inventore ipsa voluptas nulla</td>
                            <td>$64</td>
                            <td>124</td>
                            <td>$5,828</td>
                            <td><button class="btn btn-sm btn-danger">삭제</button></td>
                        </tr>
                        <tr>
                            <td>24.05.29</td>
                            <td><img src="product2.jpg" alt="Product 2" style="width: 50px;"></td>
                            <td>Exercitationem similique doloremque</td>
                            <td>$46</td>
                            <td>98</td>
                            <td>$4,508</td>
                            <td><button class="btn btn-sm btn-danger">삭제</button></td>
                        </tr>
                        <tr>
                            <td>24.05.29</td>
                            <td><img src="product3.jpg" alt="Product 3" style="width: 50px;"></td>
                            <td>Doloribus nisi exercitationem</td>
                            <td>$59</td>
                            <td>74</td>
                            <td>$4,366</td>
                            <td><button class="btn btn-sm btn-danger">삭제</button></td>
                        </tr>
                        <tr>
                            <td>24.05.29</td>
                            <td><img src="product4.jpg" alt="Product 4" style="width: 50px;"></td>
                            <td>Officiis quaerat sint rerum error</td>
                            <td>$32</td>
                            <td>63</td>
                            <td>$2,016</td>
                            <td><button class="btn btn-sm btn-danger">삭제</button></td>
                        </tr>
                        <tr>
                            <td>24.05.29</td>
                            <td><img src="product5.jpg" alt="Product 5" style="width: 50px;"></td>
                            <td>Sit unde debitis delectus repellendus</td>
                            <td>$79</td>
                            <td>41</td>
                            <td>$3,239</td>
                            <td><button class="btn btn-sm btn-danger">삭제</button></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>
