<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "../common_menu.jsp" %>    
<link href="${pageContext.request.contextPath}/css/sub_mem.css" rel="stylesheet">    
	
	<div class="main-container">
        <div class="auth-page-container">
            <div class="auth-card">
                
                <div class="auth-hero">
                    <div class="hero-content">
                        <h3>穴場 一都三県</h3>
                        <p>회원가입 후 맞춤 추천 서비스를 이용해 보세요.</p>
                    </div>
                </div>

                <div class="auth-form-section">
                    <div class="form-header">
                        <h2>회원가입</h2>
                        <p>서비스 이용을 위해 회원 정보를 입력해주세요.</p>
                    </div>

                    <form name = "mem" class="auth-form">
                        <input type="hidden" name="t_gubun" value="member_save">

                        <div class="input-group">
						    <label for="user-name">이름 <span class="required">*</span></label>
						    <input type="text" id="user-name" name="t_name" placeholder="이름 입력" autofocus>
						</div>
						
						<div class="input-group">
						    <label for="user-id">아이디 <span class="required">*</span></label>
						    <div class="input-with-btn">
						        <input type="text" id="user-id" name="t_id" oninput="setEmpty()" placeholder="아이디 입력(최대 10자)" maxlength="10">
						        <button type="button" onclick="checkId()" class="btn-sub">중복확인</button>
						        <input type="hidden" name="t_id_check">
						    </div>
						    <span id="id-check-msg" style="font-size: 12px; margin-top: 5px; display: block;"></span>
						</div>
						
						<div class="input-group">
						    <label for="user-pw">비밀번호 <span class="required">*</span></label>
						    <input type="password" id="user-pw" name="t_password" placeholder="비밀번호 (8자 이상)">
						</div>
						
						<div class="input-group">
						    <label for="user-pw-confirm">비밀번호 확인 <span class="required">*</span></label>
						    <input type="password" id="user-pw-confirm" name="t_password_confirm" placeholder="비밀번호 재입력">
						</div>
						
						<div class="input-group">
						    <label for="user-email-1">이메일 <span class="required">*</span></label>
						    <div class="email-inputs">
						        <input type="text" id="user-email-1" name="t_email_1" placeholder="example">
						        <span>@</span>
						        <input type="text" id="user-email-2" name="t_email_2" placeholder="email.com">
						    </div>
						</div>
						
						<div class="input-group">
						    <label for="user-ph1">전화번호 <span class="required">*</span></label>
						    <div class="phone-inputs">
						        <input type="text" id="user-ph1" name="t_phone_1" placeholder="010" maxlength="3">
						        <span>-</span>
						        <input type="text" id="user-ph2" name="t_phone_2" placeholder="1234" maxlength="4">
						        <span>-</span>
						        <input type="text" id="user-ph3" name="t_phone_3" placeholder="5678" maxlength="4">
						    </div>
						</div>
						
						<div class="input-group">
						    <label for="user-region">선호 지역 (선택)</label>
						    <select id="user-region" name="t_region">
						        <option value="none">선택</option>
						        <option value="tokyo">도쿄</option>
						        <option value="saitama">사이타마</option>
						        <option value="chiba">치바</option>
						        <option value="kanagawa">카나가와</option>
						    </select>
						</div>

                        <div class="member-join">
                            <button type="button" onclick="javascript:goSave()" class="btn-primary">회원가입 완료</button>
                        </div>

                        <div class="direct-login">
                            <span>이미 계정이 있으신가요? <a href="Index?login=true">로그인하기</a></span>
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

    <form name="work">
        <input type="hidden" name="t_gubun">
    </form>

	<script type="text/javascript">
    function goSave(){
    	if(isEmpty(mem.t_name, "이름을 입력하세요")) return;
    	if(isEmpty(mem.t_id, "아이디를 입력하세요")) return;
    	
    	if(mem.t_id_check.value == ""){
			alert("ID 중복검사 하세요");
			return;
		}
		
  		if(isEmpty(mem.t_password, "비밀번호를 입력하세요")) return;
  		if(isEmpty(mem.t_password_confirm, "비밀번호 확인을 입력하세요")) return;
  		
  		if(mem.t_password.value != mem.t_password_confirm.value){
  			alert("비밀번호가 일치하지 않습니다");
  			mem.t_password_confirm.focus();
  			return;
  		}
  		if(mem.t_password.value.length < 8) {
  		    alert("비밀번호는 8자 이상 입력해야 합니다.");
  		    mem.t_password.focus();
  		    return;
  		}
  		if(isEmpty(mem.t_email_1, "이메일을 입력하세요")) return;
  		if(isEmpty(mem.t_email_2, "이메일을 입력하세요")) return;
  		if(isEmpty(mem.t_phone_1, "전화번호를 입력하세요")) return;
  		if(isEmpty(mem.t_phone_2, "전화번호를 입력하세요")) return;
  		if(isEmpty(mem.t_phone_3, "전화번호를 입력하세요")) return;
  		
  		mem.t_gubun.value = "memberSave";
        mem.method = "post";
        mem.action = "Member";
        mem.submit();
    }
    
    function checkId(){
  		if(isEmpty(mem.t_id, "아이디 입력후 중복검사 하세요")) return;
  		var id=mem.t_id.value;
  		$.ajax({
			type :"POST",
			url : "MemberCheckId",
			data: "t_id="+id,
			async:false,
			dataType : "text",
			error : function(){
				alert("통신실패!!!");
			},
			success : function(data){
				var result = $.trim(data);
				mem.t_id_check.value = result;
				var $msg = $("#id-check-msg");
	            if(result === "사용가능") {
	                $msg.css("color", "green").text("✓ 사용 가능한 아이디입니다.");
	            } else {
	                $msg.css("color", "red").text("✕ 이미 사용 중인 아이디입니다.");
	            }
			}
		});
  	}
    
    function setEmpty(){
    	mem.t_id_check.value = "";
        $("#id-check-msg").text(""); 
  	}
    
	</script>
    
</body>
</html>