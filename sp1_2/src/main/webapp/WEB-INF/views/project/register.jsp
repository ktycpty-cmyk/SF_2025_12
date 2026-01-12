<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
		<%@ include file="/WEB-INF/views/includes/header.jsp" %>

			<div class="row">
				<div class="col-lg-12">
					<div class="card border-0 shadow-sm mb-4">
						<div class="card-header border-0 bg-white pt-4 px-4">
							<h3 class="fw-bold text-indigo mb-0">새로운 오답 등록</h3>
							<p class="text-secondary small">틀린 문제의 제목과 상세한 오답 원인을 기록하세요</p>
						</div>
						<div class="card-body p-4">
							<form action="/project/register" method="post" enctype="application/x-www-form-urlencoded"
								class="row g-4">
								<input type="hidden" name="category" value="${param.category}">
								<div class="col-12">
									<label class="form-label small fw-bold text-uppercase">문제 제목 / 과목</label>
									<input type="text" name="title" class="form-control" placeholder="틀린 문제를 기입해 주세요"
										required>
								</div>

								<div class="col-12">
									<label class="form-label small fw-bold text-uppercase">오답 상세 분석 및 풀이</label>
									<textarea class="form-control" name="content" rows="6"
										placeholder="틀린 이유(개념 부족, 계산 실수 등)와 올바른 풀이 과정을 자세히 기록하세요..."
										required></textarea>
								</div>

								<div class="col-md-6">
									<label class="form-label small fw-bold text-uppercase">작성자 (수강생)</label>
									<div class="input-group">
										<span class="input-group-text"><i class="bi bi-person-badge"></i></span>
										<input type="text" name="writer" class="form-control"
											value='<sec:authentication property="principal.uid"/>' readonly>
									</div>
								</div>

								<div class="col-12 border-top pt-4 mt-4 d-flex justify-content-end gap-2">
									<a href="/project/list" class="btn btn-light px-4 rounded-3">취소</a>
									<button type="submit" class="btn btn-primary px-5 rounded-3 fw-bold shadow-sm">오답 노트
										등록</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

			<%@ include file="/WEB-INF/views/includes/footer.jsp" %>