<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
      <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


        <%@ include file="/WEB-INF/views/includes/header.jsp" %>

          <div class="row">
            <div class="col-lg-12">
              <!-- Project Details Card -->
              <div class="card border-0 shadow-sm mb-4">
                <div class="card-header border-0 bg-white pt-4 px-4">
                  <div class="d-flex justify-content-between align-items-center">
                    <h3 class="fw-bold text-indigo mb-0">오답 상세 분석</h3>
                    <span class="badge bg-indigo-subtle text-indigo px-3 py-2 rounded-pill">노트 번호 #
                      <c:out value="${project.bno}" />
                    </span>
                  </div>
                </div>
                <div class="card-body p-4">
                  <div class="row g-4">
                    <div class="col-md-9">
                      <div class="mb-5">
                        <label class="text-indigo small fw-bold text-uppercase mb-2 d-flex align-items-center gap-2">
                          <i class="bi bi-patch-question"></i> 문제명 / 주제
                        </label>
                        <h2 class="fw-bold tracking-tight">
                          <c:out value="${project.title}" />
                        </h2>
                      </div>
                      <div class="mb-4">
                        <label class="text-indigo small fw-bold text-uppercase mb-2 d-flex align-items-center gap-2">
                          <i class="bi bi-journal-text"></i> 오답 원인 및 상세 풀이
                        </label>
                        <div class="p-4 bg-white border border-indigo-subtle rounded-4 shadow-sm min-vh-25"
                          style="white-space: pre-wrap; font-size: 1.1rem; line-height: 1.7; color: #333;">
                          <c:out value="${project.content}" />
                        </div>
                        <p class="text-muted small mt-2"><i class="bi bi-info-circle me-1"></i> 분석 내용이 길어지면 칸이 자동으로
                          확장됩니다.</p>
                      </div>
                    </div>
                    <div class="col-md-3">
                      <div class="p-3 border rounded-4 bg-light shadow-sm mb-3">
                        <label class="text-secondary small fw-bold text-uppercase mb-2 d-block">학습 정보</label>
                        <div class="d-flex flex-column gap-3">
                          <div class="d-flex align-items-center gap-3">
                            <div
                              class="bg-indigo text-white rounded-circle d-flex align-items-center justify-content-center"
                              style="width: 32px; height: 32px;">
                              <i class="bi bi-person-badge"></i>
                            </div>
                            <div>
                              <div class="small text-muted">학습자 (작성자)</div>
                              <div class="fw-semibold">
                                <c:out value="${project.writer}" />
                              </div>
                            </div>
                          </div>
                          <div class="d-flex align-items-center gap-3">
                            <div
                              class="bg-secondary text-white rounded-circle d-flex align-items-center justify-content-center"
                              style="width: 32px; height: 32px;">
                              <i class="bi bi-clock-history"></i>
                            </div>
                            <div>
                              <div class="small text-muted">기록 일시</div>
                              <div class="small font-monospace">
                                <c:out value="${project.createdDate}" />
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>

                      <div class="d-grid gap-2">
                        <c:url var="listUrl" value="/project/list">
                          <c:param name="page" value="${page}" />
                          <c:param name="size" value="${size}" />
                          <c:param name="types" value="${types}" />
                          <c:param name="keyword" value="${keyword}" />
                          <c:param name="category" value="${category}" />
                        </c:url>
                        <a href='${listUrl}' class="btn btn-outline-secondary rounded-3">목록으로</a>

                        <sec:authentication property="principal" var="secInfo" />
                        <sec:authorize access="hasRole('ROLE_ADMIN')" var="isAdmin" />

                        <c:if test="${!project.delFlag && (secInfo.username == project.writer || isAdmin)}">
                          <c:url var="modifyUrl" value="/project/modify/${project.bno}">
                            <c:param name="category" value="${category}" />
                            <c:param name="page" value="${page}" />
                            <c:param name="size" value="${size}" />
                            <c:param name="types" value="${types}" />
                            <c:param name="keyword" value="${keyword}" />
                          </c:url>
                          <a href='${modifyUrl}' class="btn btn-primary rounded-3 shadow-sm">오답 노트 수정</a>
                        </c:if>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Comments Section (Secondary) -->
              <div class="card border-0 bg-transparent mb-4">
                <div class="card-header border-0 bg-transparent pt-4 px-0">
                  <h5 class="fw-bold mb-0 text-secondary"><i class="bi bi-chat-left-dots me-2"></i>복습 메모</h5>
                </div>
                <div class="card-body px-0">
                  <!-- Add Comment Form -->
                  <form id="replyForm" class="bg-light p-4 rounded-4 mb-5 border shadow-sm">
                    <input type="hidden" name="bno" value="${project.bno}" />
                    <div class="row g-3">
                      <div class="col-md-4">
                        <label class="form-label small fw-bold">작성자</label>
                        <input type="text" name="replyer" class="form-control" placeholder="성함을 입력하세요" required />
                      </div>
                      <div class="col-12">
                        <label class="form-label small fw-bold">복습 메모 / 한마디</label>
                        <textarea name="replyText" class="form-control" rows="3" placeholder="기억해야 할 내용이나 추가 메모를 남기세요"
                          required></textarea>
                      </div>
                      <div class="col-12 text-end">
                        <button type="submit" class="btn btn-primary px-4 addReplyBtn rounded-3">메모 추가</button>
                      </div>
                    </div>
                  </form>

                  <!-- Comment List -->
                  <div class="replyList d-flex flex-column gap-3">
                    <!-- Loaded dynamically via JS -->
                    <div class="text-center py-5 text-muted">
                      <div class="spinner-border text-primary spinner-border-sm mb-2" role="status"></div>
                      <p class="small">Loading interactions...</p>
                    </div>
                  </div>

                  <!-- Pagination -->
                  <nav class="mt-5 border-top pt-4">
                    <ul class="pagination pagination-sm justify-content-center gap-1"></ul>
                  </nav>
                </div>
              </div>
            </div>
          </div>






          <!-- Modal for Edit/Delete Comment -->
          <div class="modal" id="replyModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
              <div class="modal-content border-0 shadow-lg rounded-4">
                <div class="modal-header border-0">
                  <h5 class="modal-title fw-bold">메모 관리</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                  <form id="replyModForm">
                    <input type="hidden" name="rno">
                    <input type="hidden" name="replyer">
                    <div class="mb-3">
                      <label class="form-label small fw-bold">내용 수정</label>
                      <textarea name="replyText" class="form-control" rows="4"></textarea>
                    </div>
                  </form>
                </div>
                <div class="modal-footer border-0 p-4 pt-0 gap-2">
                  <button type="button" class="btn btn-primary btnReplyMod px-4 rounded-3">수정하기</button>
                  <button type="button" class="btn btn-danger btnReplyDel px-4 rounded-3">삭제</button>
                  <button type="button" class="btn btn-light rounded-3" data-bs-dismiss="modal">닫기</button>
                </div>
              </div>
            </div>
          </div>

          <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

          <script type="text/javascript">
            const replyForm = document.querySelector("#replyForm");
            const currentBno = '${project.bno}';
            const currentUser = '${secInfo.username}';
            <sec:authorize access="hasRole('ROLE_ADMIN')" var="isAdminUser" />
            const isAdmin = ${ isAdminUser ?'true': 'false'};
            const replyList = document.querySelector(".replyList");
            const pagination = document.querySelector(".pagination");
            const modalEl = document.querySelector("#replyModal");
            const replyModal = new bootstrap.Modal(modalEl);
            const replyModForm = document.querySelector("#replyModForm");

            let currentPage = 1;
            let currentSize = 10;

            // Add Reply
            document.querySelector(".addReplyBtn").addEventListener("click", e => {
              e.preventDefault();
              e.stopPropagation();

              const formData = new FormData(replyForm);
              const data = Object.fromEntries(formData.entries());
              const jsonData = JSON.stringify(data);

              axios.post("/replies", jsonData, {
                headers: { 'Content-Type': 'application/json' }
              })
                .then(res => {
                  replyForm.reset();
                  getReplies(1, true);
                })
                .catch(err => {
                  console.error("Error posting reply:", err);
                  alert("Failed to post comment. Check server logs.");
                });
            }, false);

            function getReplies(pageNum, goLast) {
              axios.get(`/replies/\${currentBno}/list`, {
                params: { page: pageNum || currentPage, size: currentSize }
              }).then(res => {
                const data = res.data;
                const { totalCount, page, size } = data;

                if (goLast && (totalCount > (page * size))) {
                  getReplies(Math.ceil(totalCount / size));
                } else {
                  currentPage = page;
                  currentSize = size;
                  printReplies(data);
                }
              });
            }

            function printReplies(data) {
              const { replyDTOList, page, prev, next, start, end, pageNums } = data;
              let liStr = "";

              if (!replyDTOList || replyDTOList.length === 0) {
                replyList.innerHTML = `<div class="text-center py-4 text-secondary italic small">No comments yet. Start the conversation!</div>`;
                return;
              }

              for (let replyDTO of replyDTOList) {
                liStr += `
                <div class="p-3 border rounded-3 bg-white shadow-sm hover-shadow transition-all" style="cursor: pointer" data-rno="\${replyDTO.rno}">
                    <div class="d-flex justify-content-between mb-2">
                        <div class="d-flex align-items-center gap-2">
                            <div class="bg-indigo-subtle text-indigo rounded-circle d-flex align-items-center justify-content-center" style="width: 24px; height: 24px; font-size: 0.7rem;">
                                \${replyDTO.replyer ? replyDTO.replyer.charAt(0).toUpperCase() : '?'}
                            </div>
                            <span class="fw-bold small">\${replyDTO.replyer}</span>
                        </div>
                        <span class="small text-muted font-monospace">\${replyDTO.replyDate}</span>
                    </div>
                    <p class="mb-0 text-secondary" style="font-size: 0.95rem;">\${replyDTO.replyText}</p>
                </div>`;
              }
              replyList.innerHTML = liStr;

              let paginStr = "";
              if (prev) paginStr += `<li class="page-item"><a class="page-link border-0 shadow-sm rounded-2 mx-1" href="\${start-1}">Prev</a></li>`;
              for (let i of pageNums) {
                paginStr += `<li class="page-item \${i===page ? 'active' : ''}"><a class="page-link border-0 shadow-sm rounded-2 mx-1" href="\${i}">\${i}</a></li>`;
              }
              if (next) paginStr += `<li class="page-item"><a class="page-link border-0 shadow-sm rounded-2 mx-1" href="\${end + 1}">Next</a></li>`;
              pagination.innerHTML = paginStr;
            }

            pagination.addEventListener("click", e => {
              e.preventDefault();
              const target = e.target.closest('a');
              if (!target) return;
              getReplies(target.getAttribute("href"));
            }, false);

            replyList.addEventListener("click", e => {
              const targetDiv = e.target.closest("[data-rno]");
              if (!targetDiv) return;
              const rno = targetDiv.getAttribute("data-rno");

              axios.get(`/replies/\${rno}`).then(res => {
                const targetReply = res.data;
                if (!targetReply.delflag) {
                  // Permission check before showing modal
                  if (targetReply.replyer !== currentUser && !isAdmin) {
                    alert("You can only manage your own comments.");
                    return;
                  }

                  replyModForm.querySelector("input[name='rno']").value = targetReply.rno;
                  replyModForm.querySelector("input[name='replyer']").value = targetReply.replyer;
                  replyModForm.querySelector("textarea[name='replyText']").value = targetReply.replyText;
                  setTimeout(() => {
                    replyModal.show();
                  }, 100);
                } else {
                  alert("Deleted comment cannot be viewed.");
                }
              });
            }, false);

            document.querySelector(".btnReplyDel").addEventListener("click", () => {
              const rno = replyModForm.querySelector("input[name='rno']").value;
              const replyer = replyModForm.querySelector("input[name='replyer']").value;

              if (!confirm("Delete this comment?")) return;

              axios.delete(`/replies/\${rno}`, { params: { replyer } }).then(() => {
                replyModal.hide();
                getReplies(currentPage);
              }).catch(err => {
                alert("Failed to delete. Check permissions.");
              });
            });

            document.querySelector(".btnReplyMod").addEventListener("click", () => {
              const rno = replyModForm.querySelector("input[name='rno']").value;
              const replyer = replyModForm.querySelector("input[name='replyer']").value;
              const text = replyModForm.querySelector("textarea[name='replyText']").value;

              axios.put(`/replies/\${rno}`, { rno, replyText: text, replyer }).then(() => {
                replyModal.hide();
                getReplies(currentPage);
              }).catch(err => {
                alert("Failed to modify. Check permissions.");
              });
            });

            getReplies(1, true);
          </script>
          <%@ include file="/WEB-INF/views/includes/footer.jsp" %>