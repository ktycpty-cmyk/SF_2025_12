<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/WEB-INF/views/includes/header.jsp" %>

        <div class="container py-5">
            <div class="row justify-content-center text-center mb-5">
                <div class="col-lg-8">
                    <h1 class="display-4 fw-bold text-indigo mb-3">학습 대시보드</h1>
                    <p class="lead text-secondary">오늘 공부할 노트를 선택해 주세요. 꾸준한 오답 분석이 실력을 만듭니다.</p>
                </div>
            </div>

            <div class="row g-4 justify-content-center">
                <!-- 코딩노트 카드 -->
                <div class="col-md-5">
                    <div class="card h-100 border-0 shadow-sm hover-shadow-lg transition-all rounded-4 overflow-hidden">
                        <div class="card-body p-5 d-flex flex-column align-items-center text-center">
                            <div class="bg-indigo-subtle text-indigo rounded-circle p-4 mb-4">
                                <i class="bi bi-code-slash display-4"></i>
                            </div>
                            <h2 class="fw-bold mb-3">코딩 오답노트</h2>
                            <p class="text-muted mb-4">프로그래밍 개념, 알고리즘 실수, <br>에러 로그 분석을 위한 개발자 전용 노트</p>
                            <a href="/project/list?category=CODING"
                                class="btn btn-indigo btn-lg px-5 rounded-pill mt-auto shadow-sm">
                                노트 펼치기 <i class="bi bi-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- 일본어노트 카드 -->
                <div class="col-md-5">
                    <div class="card h-100 border-0 shadow-sm hover-shadow-lg transition-all rounded-4 overflow-hidden">
                        <div class="card-body p-5 d-flex flex-column align-items-center text-center">
                            <div class="bg-warning-subtle text-warning rounded-circle p-4 mb-4">
                                <i class="bi bi-translate display-4"></i>
                            </div>
                            <h2 class="fw-bold mb-3">일본어 오답노트</h2>
                            <p class="text-muted mb-4">헷갈리는 한자, 문법, 청해,<br>단어 암기 및 복습을 위한 어학용 노트</p>
                            <a href="/project/list?category=JAPANESE"
                                class="btn btn-warning btn-lg px-5 rounded-pill mt-auto shadow-sm text-white">
                                노트 펼치기 <i class="bi bi-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <style>
            .hover-shadow-lg:hover {
                transform: translateY(-10px);
                box-shadow: 0 1rem 3rem rgba(0, 0, 0, .1) !important;
            }

            .btn-indigo {
                background-color: var(--primary-color);
                color: white;
            }

            .btn-indigo:hover {
                background-color: var(--primary-hover);
                color: white;
            }

            .bg-indigo-subtle {
                background-color: rgba(67, 97, 238, 0.1);
            }
        </style>

        <%@ include file="/WEB-INF/views/includes/footer.jsp" %>