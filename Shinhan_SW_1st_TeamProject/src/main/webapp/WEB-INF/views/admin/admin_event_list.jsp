<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이벤트 목록</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>    
    <style>
        .modal-body {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }
        #eventForm {
            width: 100%;
            max-width: 500px;
        }
        #eventForm .form-group {
            width: 100%;
            margin-bottom: 15px;
        }
        #eventForm label {
            width: 100%;
            text-align: center;
        }
        #eventForm input, #eventForm textarea {
            width: 100%;
        }
    </style>
</head>
<body>
    <jsp:include page="common.jsp" />
    <div class="content">
        <div class="container-fluid">
            <h1>이벤트 목록</h1>

            <form id="searchForm" class="form-inline mb-3">
                <input type="text" name="searchEvent" id="searchEvent" placeholder="이벤트 제목 검색" class="form-control mr-2">
                <input type="button" class="btn btn-primary" onclick="searchEvents()" value="검색" />
                <input type="button" class="btn btn-secondary ml-2" onclick="resetSearch()" value="초기화" />
                <input type="button" class="btn btn-success ml-auto" onclick="openCreatePopup()" value="등록" />                
            </form>

            <div class="table-container">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>이벤트 번호</th>
                            <th>이벤트 제목</th>
                            <th>이벤트 내용</th>
                            <th>이벤트 작성일자</th>
                        </tr>
                    </thead>
                    <tbody id="eventList">
                        <c:forEach var="event" items="${events}">
                            <tr>
                                <td>${event.event_id}</td>
                                <td><a href="#" onclick="openDetailPopup(${event.event_id})">${event.event_title}</a></td>
                                <td>${event.event_content}</td>
                                <td>${event.event_date}</td>                                
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Event Detail Popup Modal -->
    <div class="modal fade" id="eventDetailModal" tabindex="-1" role="dialog" aria-labelledby="eventDetailModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="eventDetailModalLabel">이벤트 상세</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>                
                <div class="modal-body">
                    <form id="eventForm">
                        <input type="hidden" id="event_id" name="event_id">
                        <div class="form-group">
                            <label for="event_title">제목</label>
                            <input type="text" class="form-control" id="event_title" name="event_title" required>
                        </div>
                        <div class="form-group">
                            <label for="event_content">내용</label>
                            <textarea class="form-control" id="event_content" name="event_content" rows="5" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="event_date">작성 일자</label>
                            <input type="date" class="form-control" id="event_date" name="event_date" required>
                        </div>
                        <button type="submit" class="btn btn-success" id="saveButton">저장</button>
                        <button type="button" class="btn btn-danger" id="deleteButton" onclick="deleteEvent()">삭제</button>
                    </form>
                </div>                
            </div>
        </div>
    </div>

    <script>
        function searchEvents() {
            var searchEvent = $('#searchEvent').val();
            $.ajax({
                url: 'admin_event_search',
                type: 'GET',
                data: { searchEvent: searchEvent },
                success: function(response) {
                    $('#eventList').html(response);
                },
                error: function() {
                    alert('이벤트 검색에 실패했습니다.');
                }
            });
        }

        function resetSearch() {
            $('#searchEvent').val('');
            location.reload();
        }
        
        function openDetailPopup(event_id) {
            $.ajax({
                url: 'admin_event_detail',
                type: 'GET',
                data: { event_id: event_id },
                success: function(data) {
                    $('#eventDetailModalLabel').text('이벤트 상세');
                    $('#event_id').val(data.event_id);
                    $('#event_title').val(data.event_title);
                    $('#event_content').val(data.event_content);
                    $('#event_date').val(new Date(data.event_date).toISOString().split('T')[0]);
                    $('#eventDetailModal').modal('show');
                },
                error: function() {
                    alert('이벤트 세부 정보를 불러오는 데 실패했습니다.');
                }
            });
        }

        function deleteEvent() {
            var event_id = $('#event_id').val();
            if (confirm('이벤트를 삭제하시겠습니까?')) {
                $.ajax({
                    url: 'admin_event_delete',
                    type: 'POST',
                    data: { event_id: event_id },
                    success: function() {
                        alert('이벤트가 삭제되었습니다.');
                        $('#eventDetailModal').modal('hide');
                        location.reload();
                    },
                    error: function() {
                        alert('이벤트 삭제에 실패했습니다.');
                    }
                });
            }
        }

        function openCreatePopup() {
            $('#eventDetailModalLabel').text('이벤트 등록');
            $('#event_id').val('');
            $('#event_title').val('');
            $('#event_content').val('');
            $('#event_date').val(new Date().toISOString().split('T')[0]);
            $('#deleteButton').hide();
            $('#eventDetailModal').modal('show');
        }
        
        $('#eventForm').submit(function(event) {
            event.preventDefault();
            var action = $('#event_id').val() ? 'admin_event_update' : 'admin_event_insert';
            var formData = $(this).serialize();
            $.ajax({
                url: action,
                type: 'POST',
                data: formData,
                success: function() {
                    alert('이벤트가 저장되었습니다.');
                    $('#eventDetailModal').modal('hide');
                    location.reload();
                },
                error: function() {
                    alert('이벤트 저장에 실패했습니다.');
                }
            });
        });
    </script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
