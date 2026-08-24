<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "../common_menu.jsp" %>    
<link href="${pageContext.request.contextPath}/css/sub_rec.css" rel="stylesheet">    

<script type="text/javascript">
    // 1. 게시글 이동 처리
    function goView(no){
        view.t_gubun.value = "view";
        view.t_no.value = no;
        view.t_nowPage.value = "${t_nowPage}";
        view.method = "post";
        view.action = "Recommend";
        view.submit();
    }

    // 2. 비밀글 여부, 관리자 권한 및 작성자 본인 여부 확인
    function checkSecretAndView(no, secret, regId) {
        const sessionLevel = "${sessionScope.sessionLevel}";
        const sessionId = "${sessionScope.sessionId}"; // 현재 로그인한 사용자 ID

        // 1) 일반글이거나 관리자(top)인 경우 바로 이동
        if (secret !== 'Y' || sessionLevel === 'top') {
            goView(no);
            return;
        }

        // 2) 비밀글인 경우 본인 글인지 확인
        if (sessionId && sessionId === regId) {
            // 본인 글인 경우 비밀번호 확인 모달 열기
            openSecretPwModal(no);
        } else {
            // 다른 사람의 비밀글인 경우 차단
            alert("작성자 본인만 열람할 수 있는 비밀글입니다.");
        }
    }

    // 3. 비밀번호 입력 모달 열기
    function openSecretPwModal(no) {
        const overlay = document.getElementById('modal-overlay');
        const modalCard = document.getElementById('modal-card');

        if (!overlay || !modalCard) return;

        modalCard.innerHTML = `
            <div class="pw-modal-content">
                <h3 class="pw-modal-title">비밀글 접근 확인</h3>
                <p class="pw-modal-desc">
                    비밀글 열람을 위해<br>로그인 비밀번호를 다시 한번 입력해 주세요.
                </p>
                <div class="pw-modal-input-group">
                    <input type="password" id="secret-modal-pw" class="pw-modal-input" placeholder="비밀번호 입력" 
                           onkeypress="if(event.keyCode==13) checkSecretPassword('\${no}');">
                </div>
                <div class="pw-modal-btn-group">
                    <button type="button" onclick="checkSecretPassword('\${no}')" class="btn-primary pw-modal-btn-confirm">확인</button>
                    <button type="button" onclick="closeSecretModal()" class="pw-modal-btn-cancel">취소</button>
                </div>
            </div>
        `;

        overlay.style.display = 'block';
        modalCard.style.display = 'block';

        setTimeout(() => {
            const pwInput = document.getElementById('secret-modal-pw');
            if (pwInput) pwInput.focus();
        }, 100);
    }

    // 4. Ajax 비밀번호 일치 검증
    function checkSecretPassword(no) {
        const pw = document.getElementById('secret-modal-pw').value;
        if (!pw.trim()) {
            alert("비밀번호를 입력해 주세요.");
            document.getElementById('secret-modal-pw').focus();
            return;
        }

        fetch('Member?t_gubun=checkPw&t_password=' + encodeURIComponent(pw))
            .then(response => response.text())
            .then(result => {
                if (result.trim() === "true") {
                    closeSecretModal();
                    goView(no); // 비밀번호 통과 시 해당 게시글로 이동
                } else {
                    alert("비밀번호가 일치하지 않습니다.");
                    const pwInput = document.getElementById('secret-modal-pw');
                    pwInput.value = '';
                    pwInput.focus();
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("비밀번호 확인 중 오류가 발생했습니다.");
            });
    }

    // 5. 모달 닫기
    function closeSecretModal() {
        const overlay = document.getElementById('modal-overlay');
        const modalCard = document.getElementById('modal-card');

        if (overlay) overlay.style.display = 'none';
        if (modalCard) modalCard.style.display = 'none';
    }
</script>

<form name="view">
    <input type="hidden" name="t_gubun">
    <input type="hidden" name="t_no">
    <input type="hidden" name="t_nowPage">
</form>

<div class="main-container">
    <div class="board-page-container">
        <!-- 상단 타이틀 & 글쓰기 버튼 -->
        <div class="board-header">
            <div class="board-title-group">
                <h2>장소 신청 게시판</h2>
                <p>알고 계신 숨은 명소를 추천해 주세요. 관리자 검토 후 지도에 반영됩니다.</p>
            </div>
            <a href="javascript:goRec('write')" class="btn-board-write">글쓰기</a>
        </div>

        <!-- 공지사항 스타일 테이블 -->
        <table class="board-table">
            <thead>
                <tr>
                    <th class="col-no">번호</th>
                    <th class="col-title">제목</th>
                    <th class="col-category">카테고리</th>
                    <th class="col-reg_id">작성자</th>
                    <th class="col-reg_date">작성일</th>
                    <th class="col-state">처리상태</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="number" value="${order}"></c:set>
                <c:forEach items="${dtos}" var="dto">
                    <tr>
                        <td>
                            ${number}
                            <c:set var="number" value="${number-1}"/>
                        </td>
                       <td class="title-cell">
						    <a href="javascript:checkSecretAndView('${dto.getNo()}', '${dto.getSecret()}', '${dto.getReg_id()}')">${dto.getTitle()}</a>
						    <c:if test="${dto.getSecret() eq 'Y'}">
						        <span class="icon-secret">🔒</span>
						    </c:if>
						</td>
                        <td>
                            <c:if test="${dto.getCategory() eq 'food'}">음식</c:if>
                            <c:if test="${dto.getCategory() eq 'sights'}">관광</c:if>
                            <c:if test="${dto.getCategory() eq 'festival'}">마츠리/하나비</c:if>
                            <c:if test="${dto.getCategory() eq 'stay'}">숙소</c:if>
                        </td>
                        <td>${dto.getReg_id()}</td>
                        <td>${dto.getReg_date()}</td>
                        <c:if test="${dto.getState() eq 'pending'}">
                            <td><span class="status-tag status-pending">검토중</span></td>
                        </c:if>
                        <c:if test="${dto.getState() eq 'approved'}">
                            <td><span class="status-tag status-approved">승인완료</span></td>
                        </c:if>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- 하단 페이징 영역 -->
        <div class="board-pagination">
            ${pageDisplay}
        </div>
    </div>
</div>