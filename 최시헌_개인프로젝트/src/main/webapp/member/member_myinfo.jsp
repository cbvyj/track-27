<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "../common_menu.jsp" %>    

    <div class="main-container">
        <div class="auth-page-container">
            <div class="auth-card">
                
                <div class="auth-hero">
                    <div class="hero-content">
                        <h3>穴場 一都三県</h3>
                        <p>내 정보를 확인 & 수정하세요.</p>
                    </div>
                </div>

                <div class="auth-form-section">
                    <div class="form-header">
                        <h2>내 정보</h2>
                        <p>서비스 이용을 위해 현재 회원 정보가 맞는지 확인하세요.</p>
                    </div>

                    <form name = "mem" class="auth-form">
                        <input type="hidden" name="t_gubun" value="member_updateForm">

                        <div class="input-group">
                            <label for="user-name">이름</label>
                            <p id="user-name">${sessionName}</p>
                        </div>
                        
                        <div class="input-group">
                            <label for="user-id">아이디</label>
                            <p id="user-id">${sessionId}</p>
                        </div>


                        <div class="input-group">
						    <label for="user-email-1">이메일</label>
						    <p id="user-email">${dto.getEmail_1()}@${dto.getEmail_2()}</p>
						</div>
                        
                        <div class="input-group">
						    <label for="user-ph1">전화번호</label>
						    <div class="phone-inputs">
						       <p id="user-phone">${dto.getPhone_1()}-${dto.getPhone_2()}-${dto.getPhone_3()}</p>
						    </div>
						</div>

                        <div class="input-group">
                            <label for="user-region">선호 지역</label>
                            <p id="user-region">${dto.getRegion()}</p>
                        </div>
                        <div class="input-group">
						        <label for="user-reg-date">회원가입일</label>
						        <p id="user-reg-date">${dto.getReg_date()}</p>
						    </div>
                        <c:if test="${not empty dto.getUpdate_date()}">
						    <div class="input-group">
						        <label for="user-update-date">최종 정보 수정일</label>
						        <p id="user-update-date">${dto.getUpdate_date()}</p>
						    </div>         
						</c:if>
                        <div class="member-update">
						    <button type="button" onclick="openPasswordModal()" class="btn-primary">내 정보 수정</button>
						</div>
						<div class="member-exit">
						    <button type="button" onclick="goDelete()" class="btn-primary-exit">탈퇴하기</button>
						</div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 모달 어두운 배경 오버레이 -->
    <div id="modal-overlay" class="modal-overlay" onclick="closeModal()"></div>

    <!-- 모달 컨테이너 -->
    <div id="modal-card" class="modal-card"></div>

	<script type="text/javascript">
	// 1. 비밀번호 확인 모달 열기
		function openPasswordModal() {
	    const overlay = document.getElementById('modal-overlay');
	    const modalCard = document.getElementById('modal-card');
	
	    if (!overlay || !modalCard) return;
	
	    modalCard.innerHTML = `
	        <div class="pw-modal-content">
	            <h3 class="pw-modal-title">비밀번호 확인</h3>
	            <p class="pw-modal-desc">
	                회원님의 정보를 안전하게 보호하기 위해<br>비밀번호를 다시 한번 입력해 주세요.
	            </p>
	            <div class="pw-modal-input-group">
	                <input type="password" id="modal-pw" class="pw-modal-input" placeholder="비밀번호 입력" 
	                       onkeypress="if(event.keyCode==13) checkPassword();">
	            </div>
	            <div class="pw-modal-btn-group">
	                <button type="button" onclick="checkPassword()" class="btn-primary pw-modal-btn-confirm">확인</button>
	                <button type="button" onclick="closeModal()" class="pw-modal-btn-cancel">취소</button>
	            </div>
	        </div>
	    `;
	
	    overlay.style.display = 'block';
	    modalCard.style.display = 'block';
	
	    setTimeout(() => {
	        const pwInput = document.getElementById('modal-pw');
	        if (pwInput) pwInput.focus();
	    }, 100);
	}

	// 2. Ajax 비밀번호 일치 검증
	function checkPassword() {
	    const pw = document.getElementById('modal-pw').value;
	    if (!pw.trim()) {
	        alert("비밀번호를 입력해 주세요.");
	        document.getElementById('modal-pw').focus();
	        return;
	    }

	    fetch('Member?t_gubun=checkPw&t_password=' + encodeURIComponent(pw))
	        .then(response => response.text())
	        .then(result => {
	            if (result.trim() === "true") {
	                closeModal();
	                goPage('memberUpdateForm'); // 비밀번호 통과 시 정보 수정 페이지로 이동
	            } else {
	                alert("비밀번호가 일치하지 않습니다.");
	                const pwInput = document.getElementById('modal-pw');
	                pwInput.value = '';
	                pwInput.focus();
	            }
	        })
	        .catch(error => {
	            console.error('Error:', error);
	            alert("비밀번호 확인 중 오류가 발생했습니다.");
	        });
	}
	
	function goDelete() {
	    if (confirm("정말 탈퇴하시겠습니까? 탈퇴 후에는 계정을 복구할 수 없습니다.")) {
	        goPage('exit');
	    }
	}
	</script>
    
</body>
</html>