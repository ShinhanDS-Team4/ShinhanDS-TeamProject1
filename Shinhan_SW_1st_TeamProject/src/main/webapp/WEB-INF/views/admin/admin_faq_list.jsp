<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>F.A.Q</title>
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
        .btn-section {
            margin-bottom: 20px;
        }
        .filter-container, .table-container {
            margin-bottom: 20px;
        }
        .btn {
            background-color: #007bff;
            color: white;
        }
        .hidden {
            display: none;
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
            <h1>자주 묻는 질문 (F.A.Q)</h1>
            <div class="btn-section">
                <button id="sellerBtn" class="btn btn-primary">판매자 문의</button>
                <button id="customerBtn" class="btn btn-secondary">고객 문의</button>
            </div>

            <div id="sellerSection" class="hidden">
                <div class="filter-container">
                    <h3>판매자 문의</h3>
                    <form id="sellerForm">
                        <div class="form-row align-items-center">
                            <div class="col-auto">
                                <label for="sellerChannel">상담 채널</label>
                                <select class="form-control mb-2" id="sellerChannel" name="sellerChannel">
                                    <option value="all">전체</option>
                                    <option value="phone">전화</option>
                                    <option value="email">이메일</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <label for="sellerUse">사용 여부</label>
                                <select class="form-control mb-2" id="sellerUse" name="sellerUse">
                                    <option value="all">전체</option>
                                    <option value="yes">사용</option>
                                    <option value="no">미사용</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <label for="sellerSearch">검색</label>
                                <input type="text" class="form-control mb-2" id="sellerSearch" name="sellerSearch" placeholder="검색어 입력">
                            </div>
                            <div class="col-auto">
                                <button type="button" class="btn btn-primary mb-2" onclick="searchSellerInquiries()">검색</button>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="table-container">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>문의 제목</th>
                                <th>문의 내용</th>
                                <th>등록일</th>
                                <th>상태</th>
                                <th>액션</th>
                            </tr>
                        </thead>
                        <tbody id="sellerTableBody">
                            <!-- 판매자 문의 목록 예시 -->
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="customerSection" class="hidden">
                <div class="filter-container">
                    <h3>고객 문의</h3>
                    <form id="customerForm">
                        <div class="form-row align-items-center">
                            <div class="col-auto">
                                <label for="customerChannel">상담 채널</label>
                                <select class="form-control mb-2" id="customerChannel" name="customerChannel">
                                    <option value="all">전체</option>
                                    <option value="phone">전화</option>
                                    <option value="email">이메일</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <label for="customerUse">사용 여부</label>
                                <select class="form-control mb-2" id="customerUse" name="customerUse">
                                    <option value="all">전체</option>
                                    <option value="yes">사용</option>
                                    <option value="no">미사용</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <label for="customerSearch">검색</label>
                                <input type="text" class="form-control mb-2" id="customerSearch" name="customerSearch" placeholder="검색어 입력">
                            </div>
                            <div class="col-auto">
                                <button type="button" class="btn btn-primary mb-2" onclick="searchCustomerInquiries()">검색</button>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="table-container">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>문의 제목</th>
                                <th>문의 내용</th>
                                <th>등록일</th>
                                <th>상태</th>
                                <th>액션</th>
                            </tr>
                        </thead>
                        <tbody id="customerTableBody">
                            <!-- 고객 문의 목록 예시 -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#sellerBtn').on('click', function() {
                $('#sellerSection').removeClass('hidden');
                $('#customerSection').addClass('hidden');
                $(this).addClass('btn-primary').removeClass('btn-secondary');
                $('#customerBtn').addClass('btn-secondary').removeClass('btn-primary');
                searchSellerInquiries(); // 판매자 문의 검색 실행
            });

            $('#customerBtn').on('click', function() {
                $('#customerSection').removeClass('hidden');
                $('#sellerSection').addClass('hidden');
                $(this).addClass('btn-primary').removeClass('btn-secondary');
                $('#sellerBtn').addClass('btn-secondary').removeClass('btn-primary');
                searchCustomerInquiries(); // 고객 문의 검색 실행
            });

            // 페이지 로드 시 기본으로 고객 문의 섹션을 표시
            $('#customerBtn').click();
        });

        function searchSellerInquiries() {
            var data = $('#sellerForm').serialize();
            $.ajax({
                url: 'searchInquiries.jsp', // 서버 측 검색 처리 JSP 파일
                type: 'GET',
                data: data + '&type=seller',
                success: function(response) {
                    $('#sellerTableBody').html(response);
                }
            });
        }

        function searchCustomerInquiries() {
            var data = $('#customerForm').serialize();
            $.ajax({
                url: 'searchInquiries.jsp', // 서버 측 검색 처리 JSP 파일
                type: 'GET',
                data: data + '&type=customer',
                success: function(response) {
                    $('#customerTableBody').html(response);
                }
            });
        }
    </script>
</body>
</html>
