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
                        <p>서비스 이용을 위해 현재 회원 정보로 수정하세요.</p>
                    </div>

                    <form name = "mem" class="auth-form">
                        <input type="hidden" name="t_gubun" value="member_save">
                        <div class="input-group">
                            <label for="user-name">이름</label>
                            <input type="text" id="user-name" name="t_name" value="${sessionName}">
                        </div>
                        
                        <div class="input-group">
                            <label for="user-id">아이디</label>
                            <div class="input-with-btn">
                                <input type="text" id="user-id" name="t_id" oninput="setEmpty()" value="${sessionId}" readonly>
                            </div>
                        </div>

                        <div class="input-group">
						    <label for="user-email-1">이메일</label>
						    <div class="email-inputs">
						        <input type="text" id="user-email-1" name="t_email_1" value="${dto.getEmail_1()}">
						        <span>@</span>
						        <input type="text" id="user-email-2" name="t_email_2" value="${dto.getEmail_2()}">
						    </div>
						</div>
                        
                        <div class="input-group">
						    <label for="user-ph1">전화번호</label>
						    <div class="phone-inputs">
						        <input type="text" id="user-ph1" name="t_phone_1" value="${dto.getPhone_1()}" maxlength="3">
						        <span>-</span>
						        <input type="text" id="user-ph2" name="t_phone_2" value="${dto.getPhone_2()}" maxlength="4">
						        <span>-</span>
						        <input type="text" id="user-ph3" name="t_phone_3" value="${dto.getPhone_3()}" maxlength="4">
						    </div>
						</div>

                        <div class="input-group">
                            <label for="user-region">선호 지역 (선택)</label>
                            <select id="user-region" name="t_region">
                                <option value="none" <c:if test="${dto.getRegion() eq '선택'}">selected</c:if>>선택</option>
                                <option value="tokyo" <c:if test="${dto.getRegion() eq '도쿄'}">selected</c:if>>도쿄</option>
                                <option value="saitama" <c:if test="${dto.getRegion() eq '사이타마'}">selected</c:if>>사이타마</option>
                                <option value="chiba" <c:if test="${dto.getRegion() eq '치바'}">selected</c:if>>치바</option>
                                <option value="kanagawa" <c:if test="${dto.getRegion() eq '카나가와'}">selected</c:if>>카나가와</option>
                            </select>
                        </div>

                        <div class="member-join">
                            <button type="button" onclick="javascript:goUpdate()" class="btn-primary">내 정보 수정</button>
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
    function goUpdate(){
    	if(isEmpty(mem.t_name, "이름을 입력하세요")) return;
  		if(isEmpty(mem.t_email_1, "이메일을 입력하세요")) return;
  		if(isEmpty(mem.t_email_2, "이메일을 입력하세요")) return;
  		if(isEmpty(mem.t_phone_1, "전화번호를 입력하세요")) return;
  		if(isEmpty(mem.t_phone_2, "전화번호를 입력하세요")) return;
  		if(isEmpty(mem.t_phone_3, "전화번호를 입력하세요")) return;
  		
  		mem.t_gubun.value = "memberUpdate";
        mem.method = "post";
        mem.action = "Member";
        mem.submit();
    }
   
    
	</script>
    
</body>
</html>