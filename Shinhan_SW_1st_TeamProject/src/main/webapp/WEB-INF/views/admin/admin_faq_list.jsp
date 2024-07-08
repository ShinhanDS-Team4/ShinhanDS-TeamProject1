<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>문의 게시판</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<style>
.modal-body {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
}

#inquiryForm {
	width: 100%;
	max-width: 500px;
}

#inquiryForm .form-group {
	width: 100%;
	margin-bottom: 15px;
}

#inquiryForm label {
	width: 100%;
	text-align: center;
}

#inquiryForm input, #inquiryForm textarea {
	width: 100%;
}
</style>
</head>
<body>
	<jsp:include page="common.jsp" />
	<div class="content">
		<div class="container-fluid">
			<h1>문의 게시판</h1>
			<div class="form-group">
				<label for="boardType">게시판 선택</label> <select id="boardType"
					class="form-control" onchange="searchInquiries()">
					<option value="seller">판매자 문의 게시판</option>
					<option value="customer">고객 문의 게시판</option>
				</select>
			</div>

			<form id="searchForm" class="form-inline mb-3">
				<input type="text" name="searchQuery" id="searchQuery"
					placeholder="검색어 입력" class="form-control mr-2"> <input
					type="button" class="btn btn-primary" onclick="searchInquiries()"
					value="검색" /> <input type="button" class="btn btn-secondary ml-2"
					onclick="resetSearch()" value="초기화" />
			</form>

			<div class="table-container">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>문의 번호</th>
							<th>문의 제목</th>
							<th>문의 내용</th>
							<th>작성 일자</th>
							<th>답변 상태</th>
							<th>회원 ID</th>
							<th>회원 유형</th>
						</tr>
					</thead>
					<tbody id="inquiryList">
						<c:forEach var="inquiry" items="${Seller}">
							<tr>
								<td>${inquiry.admin_inq_id}</td>
								<td><a href="#"
									onclick="openDetailPopup(${inquiry.admin_inq_id})">${inquiry.admin_inq_title}</a></td>
								<td>${inquiry.admin_inq_content}</td>
								<td>${inquiry.admin_inq_date}</td>
								<td><c:choose>
										<c:when test="${inquiry.admin_reply != null}">
                                                답변 완료
                                                </c:when>
										<c:otherwise>
                                                    미답변
                                                </c:otherwise>
									</c:choose></td>
								<td>${inquiry.member_id}</td>
								<td>${inquiry.member_type}</td>
							</tr>
						</c:forEach>
						<c:forEach var="inquiry" items="${Customer}">
							<tr>
								<td>${inquiry.admin_inq_id}</td>
								<td><a href="#"
									onclick="openDetailPopup(${inquiry.admin_inq_id})">${inquiry.admin_inq_title}</a></td>
								<td>${inquiry.admin_inq_content}</td>
								<td>${inquiry.admin_inq_date}</td>
								<td><c:choose>
										<c:when test="${inquiry.admin_reply != null}">
                                                답변 완료
                                                </c:when>
										<c:otherwise>
                                                    미답변
                                                </c:otherwise>
									</c:choose></td>
								<td>${inquiry.member_id}</td>
								<td>${inquiry.member_type}</td>
							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>
		</div>
	</div>

	<!-- Inquiry Detail Popup Modal -->
	<div class="modal fade" id="inquiryDetailModal" tabindex="-1"
		role="dialog" aria-labelledby="inquiryDetailModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="inquiryDetailModalLabel">문의 상세</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="inquiryForm">
						<input type="hidden" id="admin_inq_id" name="admin_inq_id">
						<div class="form-group">
							<label for="admin_inq_title">제목</label> <input type="text"
								class="form-control" id="admin_inq_title" name="admin_inq_title"
								readonly>
						</div>
						<div class="form-group">
							<label for="admin_inq_content">내용</label>
							<textarea class="form-control" id="admin_inq_content"
								name="admin_inq_content" rows="5" readonly></textarea>
						</div>
						<div class="form-group">
							<label for="admin_inq_date">작성 일자</label> <input type="date"
								class="form-control" id="admin_inq_date" name="admin_inq_date"
								readonly>
						</div>
						<div class="form-group">
							<label for="admin_reply">답변</label>
							<textarea class="form-control" id="admin_reply"
								name="admin_reply" rows="5"></textarea>
						</div>
						<button type="submit" class="btn btn-success" id="saveButton">답변
							저장</button>
						<button type="button" class="btn btn-warning" id="updateButton"
							onclick="updateInquiry()">수정</button>
						<button type="button" class="btn btn-danger ml-auto" id="deleteButton"
							onclick="deleteInquiry()">삭제</button>
					</form>
				</div>
			</div>
		</div>
	</div>



	<script>
        function searchInquiries() {
            var searchQuery = $('#searchQuery').val();
            var boardType = $('#boardType').val() == 'customer' ? 1 : 2;
            $.ajax({
                url: 'admin_faq_search',
                type: 'GET',
                data: { searchQuery: searchQuery, boardType: boardType },
                success: function(response) {
                    $('#inquiryList').html(response);
                },
                error: function() {
                    alert('검색에 실패했습니다.');
                }
            });
        }

        function resetSearch() {
            $('#searchQuery').val('');
            searchInquiries();
        }
        
        function openDetailPopup(admin_inq_id) {
            $.ajax({
                url: 'admin_faq_detail',
                type: 'GET',
                data: { admin_inq_id: admin_inq_id },
                success: function(data) {
                    $('#inquiryDetailModalLabel').text('문의 상세');
                    $('#admin_inq_id').val(data.admin_inq_id);
                    $('#admin_inq_title').val(data.admin_inq_title);
                    $('#admin_inq_content').val(data.admin_inq_content);
                    $('#admin_inq_date').val(new Date(data.admin_inq_date).toISOString().split('T')[0]);
                    $('#admin_reply').val(data.admin_reply);

                    if (data.admin_reply) {
                        $('#saveButton').hide();
                        $('#updateButton').show();
                        $('#deleteButton').show();
                    } else {
                        $('#saveButton').show();
                        $('#updateButton').hide();
                        $('#deleteButton').hide();
                    }

                    $('#inquiryDetailModal').modal('show');
                },
                error: function() {
                    alert('문의 세부 정보를 불러오는 데 실패했습니다.');
                }
            });
        }

        $('#inquiryForm').submit(function(event) {
            event.preventDefault();
            var formData = $(this).serialize();
           	console.log(formData);
            $.ajax({
                url: 'admin_faq_insert',
                type: 'POST',
                data: formData,
                content: 'application/x-www-form-urlencoded; charset=UTF-8',
                success: function() {
                    alert('답변이 저장되었습니다.');
                    $('#inquiryDetailModal').modal('hide');
                    searchInquiries();
                },
                error: function() {
                    alert('답변 저장에 실패했습니다.');
                }
            });
        });

        function updateInquiry() {
            var formData = $('#inquiryForm').serialize();
            console.log(formData);
            $.ajax({
                url: 'admin_faq_reply_update',
                type: 'POST',
                data: formData,
                content: 'application/x-www-form-urlencoded; charset=UTF-8',
                success: function() {
                    alert('답변이 수정되었습니다.');
                    $('#inquiryDetailModal').modal('hide');
                    searchInquiries();
                },
                error: function() {
                    alert('답변 수정에 실패했습니다.');
                }
            });
        }

        function deleteInquiry() {
            var admin_inq_id = $('#admin_inq_id').val();
            $.ajax({
                url: 'admin_faq_reply_delete',
                type: 'POST',
                data: { admin_inq_id: admin_inq_id },
                success: function() {
                    alert('문의가 삭제되었습니다.');
                    $('#inquiryDetailModal').modal('hide');
                    searchInquiries();
                },
                error: function() {
                    alert('문의 삭제에 실패했습니다.');
                }
            });
        }

    </script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
