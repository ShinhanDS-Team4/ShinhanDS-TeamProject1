<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 목록</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>    
    <style>
        .modal-body {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }
        #noticeForm {
            width: 100%;
            max-width: 500px;
        }
        #noticeForm .form-group {
            width: 100%;
            margin-bottom: 15px;
        }
        #noticeForm label {
            width: 100%;
            text-align: center;
        }
        #noticeForm input, #noticeForm textarea {
            width: 100%;
        }
    </style>
</head>
<body>
    <jsp:include page="common.jsp" />
    <div class="content">
        <div class="container-fluid">
            <h1>공지사항 목록</h1>

            <form id="searchForm" class="form-inline mb-3">
                <input type="text" name="searchNotice" id="searchNotice" placeholder="공지사항 제목 검색" class="form-control mr-2">
                <input type="button" class="btn btn-primary" onclick="searchNotices()" value="검색" />
                <input type="button" class="btn btn-secondary ml-2" onclick="resetSearch()" value="초기화" />
                <input type="button" class="btn btn-success ml-auto" onclick="openCreatePopup()" value="등록" />                
            </form>

            <div class="table-container">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>공지사항 번호</th>
                            <th>공지사항 제목</th>
                            <th>공지사항 내용</th>
                            <th>작성 일자</th>
                        </tr>
                    </thead>
                    <tbody id="noticeList">
                        <c:forEach var="notice" items="${notices}">
                            <tr>
                                <td>${notice.not_id}</td>
                                <td><a href="#" onclick="openDetailPopup(${notice.not_id})">${notice.not_title}</a></td>
                                <td>${notice.not_content}</td>
                                <td>${notice.not_date}</td>                                
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Notice Detail Popup Modal -->
    <div class="modal fade" id="noticeDetailModal" tabindex="-1" role="dialog" aria-labelledby="noticeDetailModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="noticeDetailModalLabel">공지사항 상세</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>                
                <div class="modal-body">
                    <form id="noticeForm">
                        <input type="hidden" id="not_id" name="not_id">
                        <div class="form-group">
                            <label for="not_title">제목</label>
                            <input type="text" class="form-control" id="not_title" name="not_title" required>
                        </div>
                        <div class="form-group">
                            <label for="not_content">내용</label>
                            <textarea class="form-control" id="not_content" name="not_content" rows="5" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="not_date">작성 일자</label>
                            <input type="date" class="form-control" id="not_date" name="not_date" required>
                        </div>
                        <button type="submit" class="btn btn-success" id="saveButton">저장</button>
                        <button type="button" class="btn btn-danger" id="deleteButton" onclick="deleteNotice()">삭제</button>
                    </form>
                </div>                
            </div>
        </div>
    </div>

    <script>
        function searchNotices() {
            var searchNotice = $('#searchNotice').val();
            $.ajax({
                url: 'admin_notice_search',
                type: 'GET',
                data: { search_notice: searchNotice },
                success: function(response) {
                    $('#noticeList').html(response);
                },
                error: function() {
                    alert('공지사항 검색에 실패했습니다.');
                }
            });
        }

        function resetSearch() {
            $('#searchNotice').val('');
            location.reload();
        }
        
        function openDetailPopup(not_id) {
            $.ajax({
                url: 'admin_notice_detail',
                type: 'GET',
                data: { not_id: not_id },
                success: function(data) {
                    $('#noticeDetailModalLabel').text('공지사항 상세');
                    $('#not_id').val(data.not_id);
                    $('#not_title').val(data.not_title);
                    $('#not_content').val(data.not_content);
                    $('#not_date').val(new Date(data.not_date).toISOString().split('T')[0]);
                    $('#deleteButton').show();
                    $('#noticeDetailModal').modal('show');
                },
                error: function() {
                    alert('공지사항 세부 정보를 불러오는 데 실패했습니다.');
                }
            });
        }

        function deleteNotice() {
            var not_id = $('#not_id').val();
            if (confirm('공지사항을 삭제하시겠습니까?')) {
                $.ajax({
                    url: 'admin_notice_delete',
                    type: 'POST',
                    data: { not_id: not_id },
                    success: function() {
                        alert('공지사항이 삭제되었습니다.');
                        $('#noticeDetailModal').modal('hide');
                        location.reload();
                    },
                    error: function() {
                        alert('공지사항 삭제에 실패했습니다.');
                    }
                });
            }
        }

        function openCreatePopup() {
            $('#noticeDetailModalLabel').text('공지사항 등록');
            $('#not_id').val('');
            $('#not_title').val('');
            $('#not_content').val('');
            $('#not_date').val(new Date().toISOString().split('T')[0]);
            $('#deleteButton').hide();
            $('#noticeDetailModal').modal('show');
        }
        
        $('#noticeForm').submit(function(event) {
            event.preventDefault();
            var action = $('#not_id').val() ? 'admin_notice_update' : 'admin_notice_insert';
            var formData = $(this).serialize();
            $.ajax({
                url: action,
                type: 'POST',
                data: formData,
                success: function() {
                    alert('공지사항이 저장되었습니다.');
                    $('#noticeDetailModal').modal('hide');
                    location.reload();
                },
                error: function() {
                    alert('공지사항 저장에 실패했습니다.');
                }
            });
        });
    </script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
