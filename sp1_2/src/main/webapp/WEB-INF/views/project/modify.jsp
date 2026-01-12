<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ include file="/WEB-INF/views/includes/header.jsp" %>

      <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

          <div class="row">
            <div class="col-lg-12">
              <div class="card border-0 shadow-sm mb-4">
                <div class="card-header border-0 bg-white pt-4 px-4">
                  <h3 class="fw-bold text-indigo mb-0">오답 노트 수정</h3>
                </div>
                <div class="card-body p-4">
                  <form id="actionForm" action="/project/modify" method="post" class="row g-4">
                    <input type="hidden" name="category" value="${category}">
                    <input type="hidden" name="writer" value="${project.writer}">
                    <div class="col-md-6">
                      <label class="form-label small fw-bold text-uppercase">오답 번호</label>
                      <input type="text" name="bno" class="form-control bg-light"
                        value="<c:out value='${project.bno}'/>" readonly>
                    </div>
                    <div class="col-md-6">
                      <label class="form-label small fw-bold text-uppercase">작성자 (수강생)</label>
                      <input type="text" name="writer" class="form-control bg-light"
                        value="<c:out value='${project.writer}'/>" readonly>
                    </div>
                    <div class="col-12">
                      <label class="form-label small fw-bold text-uppercase">문제 제목 / 주제</label>
                      <input type="text" name="title" class="form-control" value="<c:out value='${project.title}'/>">
                    </div>
                    <div class="col-12">
                      <label class="form-label small fw-bold text-uppercase">오답 상세 분석 및 풀이</label>
                      <textarea class="form-control" name="content"
                        rows="6"><c:out value="${project.content}"/></textarea>
                    </div>
                    <div class="col-md-6">
                      <label class="form-label small fw-bold text-uppercase">최초 기록 일시</label>
                      <input type="text" class="form-control bg-light" value="<c:out value='${project.createdDate}'/>"
                        readonly>
                    </div>

                    <div class="col-12 d-flex justify-content-between border-top pt-4 mt-4">
                      <c:url var="listUrl" value="/project/list">
                        <c:param name="page" value="${page}" />
                        <c:param name="size" value="${size}" />
                        <c:param name="types" value="${types}" />
                        <c:param name="keyword" value="${keyword}" />
                        <c:param name="category" value="${category}" />
                      </c:url>
                      <a href="${listUrl}" class="btn btn-outline-secondary px-4 rounded-3">
                        <i class="bi bi-arrow-left me-2"></i> 목록으로
                      </a>
                      <div class="gap-2 d-flex">
                        <sec:authentication property="principal" var="secInfo" />
                        <sec:authorize access="hasRole('ROLE_ADMIN')" var="isAdmin" />
                        <c:if test="${secInfo.username == project.writer || isAdmin}">
                          <button type="button" class="btn btn-outline-danger btnRemove px-4 rounded-3">오답 삭제</button>
                          <button type="submit" class="btn btn-primary px-4 rounded-3 shadow-sm">수정 완료</button>
                        </c:if>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>

          <script type="text/javascript">
            const formObj = document.querySelector("#actionForm");

            // Functional Fix: Added null checks to prevent TypeError
            const btnModify = document.querySelector(".btnModify");
            if (btnModify) {
              btnModify.addEventListener("click", () => {
                formObj.action = "/project/modify";
                formObj.method = "post";
                formObj.submit();
              });
            }

            const btnRemove = document.querySelector(".btnRemove");
            if (btnRemove) {
              btnRemove.addEventListener("click", () => {
                if (!confirm("이 오답 노트를 정말 삭제하시겠습니까?")) {
                  return;
                }
                // 카테고리 유지를 위해 폼에 카테고리 파라미터가 이미 히든으로 존재함
                formObj.action = "/project/remove";
                formObj.method = "post";
                formObj.submit();
              });
            }
          </script>

          <%@ include file="/WEB-INF/views/includes/footer.jsp" %>