<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="${pageContext.request.contextPath}/css/sub_mem.css" rel="stylesheet">    

<div class="modal-header">
    <h2>로그인</h2>
    <button class="close-btn" onclick="closeModal()">&times;</button>
</div>

<div class="modal-form">
    <form name="mem">
        <input type="hidden" name="t_gubun" value="memberLogin">
        
        <div class="input-group">
            <label for="login-id">아이디</label>
            <input type="text" id="login-id" name="t_id" placeholder="아이디를 입력하세요" autofocus>
        </div>
        <div class="input-group">
            <label for="login-pw">비밀번호</label>
            <!-- keyup 이벤트로 엔터키 감지 추가 -->
            <input type="password" id="login-pw" name="t_password" placeholder="비밀번호를 입력하세요" onkeyup="if(window.event.keyCode==13){goLogin();}">
        </div>
        
        <button type="button" onclick="goLogin()" class="submit-btn">로그인</button>
    </form>
    
    <div class="modal-footer">
        <span>계정이 없으신가요? <a href="javascript:void(0)" onclick="closeModal(); goPage('join');">회원가입</a></span>
    </div>
</div>