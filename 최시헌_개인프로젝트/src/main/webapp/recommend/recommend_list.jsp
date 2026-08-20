<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "../common_menu.jsp" %>    
<link href="${pageContext.request.contextPath}/css/sub_rec.css" rel="stylesheet">    
<script type="text/javascript">
	function goView(no){
		view.t_gubun.value = "view";
		view.t_no.value = no;
		view.method = "post";
		view.action = "Recommend";
		view.submit();
	}
</script>

<form name="view">
	<input type="hidden" name="t_gubun">
	<input type="hidden" name="t_no">
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
		                            <a href="javascript:goView('${dto.getNo()}')">${dto.getTitle()}</a>
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
		                    </tr>
	                    </c:forEach>
	                </tbody>
                
            </table>

            <!-- 하단 페이징 영역 (Command에서 생성한 pageDisplay 사용) -->
			<div class="board-pagination">
			    ${pageDisplay}
			</div>
        </div>
    </div>