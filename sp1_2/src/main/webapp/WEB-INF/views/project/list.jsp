<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

			<%@ include file="/WEB-INF/views/includes/header.jsp" %>

				<div class="row">
					<div class="col-lg-12">
						<div class="d-flex justify-content-between align-items-end mb-4">
							<div>
								<h2 class="fw-bold mb-1">오답노트 리스트</h2>
								<p class="text-secondary small mb-0">틀린 문제를 기록하고 주기적으로 복습하세요</p>
							</div>
							<a href="/project/register?category=${dto.category}"
								class="btn btn-primary d-flex align-items-center gap-2 rounded-3 shadow-sm">
								<i class="bi bi-pencil-square"></i> 새 오답 등록
							</a>
						</div>

						<!-- Search Section -->
						<div class="card mb-4 border-0 shadow-sm">
							<div class="card-body">
								<form action="/project/list" method="get" class="row g-3 align-items-center">
									<input type="hidden" name="category" value="${dto.category}">
									<div class="col-md-3">
										<select name="types" class="form-select border-0 bg-light rounded-3">
											<option value="">검색 조건 선택...</option>
											<option value="T" ${dto.types=='T' ? 'selected' : '' }>문제 제목</option>
											<option value="C" ${dto.types=='C' ? 'selected' : '' }>오답 분석</option>
											<option value="W" ${dto.types=='W' ? 'selected' : '' }>작성자</option>
											<option value="TC" ${dto.types=='TC' ? 'selected' : '' }>제목 + 분석</option>
											<option value="TW" ${dto.types=='TW' ? 'selected' : '' }>제목 + 작성자</option>
											<option value="TCW" ${dto.types=='TCW' ? 'selected' : '' }>전체 검색</option>
										</select>
									</div>
									<div class="col-md-7">
										<div class="input-group">
											<input type="text" class="form-control border-0 bg-light rounded-start-3"
												name="keyword" placeholder="문제 또는 키워드를 입력하세요"
												value="<c:out value='${dto.keyword}'/>" />
											<button class="btn btn-primary searchBtn px-4 rounded-end-3"
												type="submit">검색</button>
										</div>
									</div>
								</form>
							</div>
						</div>

						<!-- Table Card -->
						<div class="card border-0 shadow-sm overflow-hidden">
							<div class="card-body p-0">
								<table class="table mb-0">
									<thead>
										<tr>
											<th class="ps-4">번호</th>
											<th>문제명 (주제)</th>
											<th>학습자</th>
											<th>기록일</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="project" items="${dto.projectDTOList}">
											<tr style="cursor: pointer;"
												onclick="window.location.href='/project/read/${project.bno}?category=${dto.category}&page=${dto.page}&size=${dto.size}&types=${dto.types}&keyword=${dto.keyword}'">
												<td class="ps-4"><span
														class="badge bg-light text-secondary">#${project.bno}</span>
												</td>
												<td>
													<div
														class="fw-semibold text-primary d-flex align-items-center gap-2">
														<c:out value="${project.title}" />
														<c:if test="${project.replyCnt > 0}">
															<span
																class="badge rounded-pill bg-indigo-subtle text-indigo px-2"
																style="font-size: 0.7rem;">
																${project.replyCnt}
															</span>
														</c:if>
													</div>
												</td>
												<td>
													<div class="d-flex align-items-center gap-2">
														<div class="rounded-circle bg-indigo-subtle text-indigo d-flex align-items-center justify-content-center"
															style="width: 24px; height: 24px; font-size: 0.75rem;">
															<i class="bi bi-person-fill"></i>
														</div>
														<span class="small">${project.writer}</span>
													</div>
												</td>
												<td class="small text-secondary font-monospace">
													<c:out value="${project.createdDate}" />
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>

						<!-- Pagination -->
						<nav class="mt-4">
							<ul class="pagination justify-content-center gap-1">
								<c:if test="${dto.prev}">
									<li class="page-item">
										<a class="page-link border-0 rounded-3 shadow-sm" href="${dto.start - 1 }"
											tabindex="-1">Previous</a>
									</li>
								</c:if>

								<c:forEach var="num" items="${dto.pageNums}">
									<li class="page-item ${dto.page == num ? 'active' : ''}">
										<a class="page-link border-0 rounded-3 shadow-sm mx-1" href="${num}">${num}</a>
									</li>
								</c:forEach>

								<c:if test="${dto.next}">
									<li class="page-item">
										<a class="page-link border-0 rounded-3 shadow-sm" href="${dto.end + 1}">Next</a>
									</li>
								</c:if>
							</ul>
						</nav>
					</div>
				</div>





				<!-- Welcome Modal -->
				<div class="modal" id="myModal" tabindex="-1" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content border-0 shadow-lg rounded-4">
							<div class="modal-header border-0 pb-0">
								<h5 class="modal-title fw-bold">성공</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body text-center py-4">
								<div class="display-4 text-success mb-3"><i class="bi bi-journal-check"></i></div>
								<p class="mb-0 fs-5">오답노트 <strong>#<span id="modalResult"></span></strong>번이 성공적으로
									등록되었습니다.</p>
							</div>
							<div class="modal-footer border-0 pt-0 justify-content-center">
								<button type="button" class="btn btn-light px-4 rounded-3"
									data-bs-dismiss="modal">닫기</button>
							</div>
						</div>
					</div>
				</div>

				<script type="text/javascript">
					const result = '${result}';
					const modalEl = document.getElementById('myModal');
					const myModal = new bootstrap.Modal(modalEl);

					if (result) {
						document.getElementById('modalResult').innerText = result;
						// Small timeout to ensure DOM movement and animations are settled
						setTimeout(() => {
							myModal.show();
							history.replaceState({}, null, null);
						}, 100);
					}

					// Pagination logic
					const pagingDiv = document.querySelector(".pagination");
					if (pagingDiv) {
						pagingDiv.addEventListener("click", (e) => {
							e.preventDefault();
							e.stopPropagation();

							const target = e.target.closest('a');
							if (!target) return;

							const targetPage = target.getAttribute("href");
							const size = '${dto.size}' || 10;

							const params = new URLSearchParams({
								page: targetPage,
								size: size,
								category: '${dto.category}'
							});

							const types = '${dto.types}';
							const keyword = '${dto.keyword}';

							if (keyword && keyword.trim() !== "") {
								params.set("keyword", keyword);
								if (types && types.trim() !== "") {
									params.set("types", types);
								}
							}

							self.location = `/project/list?\${params.toString()}`;
						}, false);
					}

					// Search logic
					const searchForm = document.querySelector(".card-body form");
					if (searchForm) {
						searchForm.addEventListener("submit", (e) => {
							// Form will submit naturally with category, types, and keyword
							// No need for custom location change unless we want to filter empty keyword
							const keyword = searchForm.querySelector("input[name='keyword']").value;
							if (!keyword || keyword.trim() === "") {
								e.preventDefault();
								self.location = `/project/list?category=${dto.category}`;
							}
						});
					}
				</script>

				<%@ include file="/WEB-INF/views/includes/footer.jsp" %>