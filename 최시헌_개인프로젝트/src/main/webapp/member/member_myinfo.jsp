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

                        <div class="member-join">
                            <button type="button" onclick="javascript:goSave()" class="btn-primary">회원가입</button>
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
    function goSave(){
    	if(isEmpty(mem.t_name, "이름을 입력하세요")) return;
    	if(isEmpty(mem.t_id, "아이디를 입력하세요")) return;
    	/*
    	if(mem.t_id_check.value == ""){
			alert("ID 중복검사 하세요");
			return;
		}
		if(mem.t_id_check.value == "사용불가"){
			alert("사용할 수 없는 ID입니다");
			mem.t_id.focus();
			return;
		}
		*/
  		if(isEmpty(mem.t_password, "비밀번호를 입력하세요")) return;
  		if(isEmpty(mem.t_password_confirm, "비밀번호 확인을 입력하세요")) return;
  		
  		if(mem.t_password.value != mem.t_password_confirm.value){
  			alert("비밀번호가 일치하지 않습니다");
  			mem.t_password_confirm.focus();
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
  		if(checkEmpty(mem.t_id, "아이디 입력후 중복검사 하세요")) return;
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
				//alert("=="+result+"==");
			}
		});
  	}
	</script>
    
</body>
</html>