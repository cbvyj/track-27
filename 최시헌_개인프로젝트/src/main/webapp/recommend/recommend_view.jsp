<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "../common_menu.jsp" %> 
<link href="${pageContext.request.contextPath}/css/sub_rec.css" rel="stylesheet">    

<div class="main-container">
    <div class="board-page-container">
        <!-- 상단 타이틀 & 목록 버튼 -->
        <div class="board-header">
            <div class="board-title-group">
                <h2>장소 신청 정보</h2>
                <p>알고 계신 숨은 명소를 추천해 주세요. 관리자 검토 후 지도에 반영됩니다.</p>
            </div>
        </div>

        <!-- 상세보기 카드 영역 -->
        <div class="board-view-card">
            
            <!-- 1. 게시글 헤더 (제목 및 메타 정보) -->
            <div class="view-header">
                <div class="view-title-wrap">
                    <span class="badge-region">
                    	<c:if test="${dto.getRegion() eq 'tokyo'}">도쿄</c:if>
                    	<c:if test="${dto.getRegion() eq 'saitama'}">사이타마</c:if>
                    	<c:if test="${dto.getRegion() eq 'chiba'}">치바</c:if>
                    	<c:if test="${dto.getRegion() eq 'kanagawa'}">카나가와</c:if>
                    </span>
                    <h1 class="view-title">
                        ${dto.getTitle()}
                        <c:if test="${dto.getSecret() eq 'Y'}">
                            <span class="icon-secret">🔒</span>
                        </c:if>
                    </h1>
                </div>
                
                <div class="view-meta-info">
                    <div class="meta-item">
                        <span class="meta-label">작성자</span>
                        <span class="meta-value">${dto.getReg_id()}</span>
                    </div>
                    <span class="meta-divider">|</span>
                    <div class="meta-item">
                        <span class="meta-label">작성일</span>
                        <span class="meta-value">${dto.getReg_date()}</span>
                    </div>
                    <span class="meta-divider">|</span>
                    <div class="meta-item">
                        <span class="meta-label">처리상태</span>
                        <c:choose>
                            <c:when test="${dto.getState() eq 'pending'}">
                                <span class="status-tag status-pending">검토중</span>
                            </c:when>
                            <c:when test="${dto.getState() eq 'approved'}">
                                <span class="status-tag status-complete">승인완료</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-tag status-pending">${dto.getState()}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <span class="meta-divider">|</span>
                    <div class="meta-item">
                        <span class="meta-label">조회수</span>
                        <span class="meta-value">${dto.getHit()}</span>
                    </div>
                </div>
            </div>

			<!-- 2. 주요 분류 및 태그 정보 메인 그리드 -->
			<c:choose>
			    <c:when test="${dto.getCategory() eq '음식' or dto.getCategory() eq 'food'}">
			        <div class="view-info-grid food-grid">
			            <div class="info-cell">
			                <span class="info-label">카테고리</span>
			                <span class="info-value"><c:if test="${dto.getCategory() eq 'food'}">음식</c:if></span>
			            </div>
			            
									
			            
			            <div class="info-cell">
			                <c:if test="${not empty dto.getSub_category()}">
			                    <span class="info-label">세부 카테고리</span>
			                    <span class="info-value">
			                        <c:choose>
			                            <c:when test="${dto.getSub_category() eq 'restaurant'}">식당</c:when>
			                            <c:when test="${dto.getSub_category() eq 'izakaya'}">이자카야 / 주점</c:when>
			                            <c:when test="${dto.getSub_category() eq 'cafe'}">카페 / 디저트 / 베이커리</c:when>
			                            <c:when test="${dto.getSub_category() eq 'bar'}">바 / 펍 / 라운지</c:when>
			                            <c:otherwise>${dto.getSub_category()}</c:otherwise>
			                        </c:choose>
			                    </span>
			                </c:if>
			            </div>
			
			            <div class="info-cell">
			                <c:if test="${not empty dto.getTags()}">
			                    <span class="info-label">특징</span>
			                    <div class="view-tag-list">
			                        <c:forTokens items="${dto.getTags()}" delims="," var="tag">
			                            <c:set var="tag" value="${tag.trim()}" />
			                            <span class="tag-chip"># 
			                                <c:choose>
			                                    <c:when test="${tag eq 'casual'}">일반/캐주얼</c:when>
			                                    <c:when test="${tag eq 'fine_dining'}">고급/파인다이닝</c:when>
			                                    <c:when test="${tag eq 'view'}">뷰/야경/루프탑</c:when>
			                                    <c:when test="${tag eq 'takeout'}">테이크아웃 전용</c:when>
			                                    <c:when test="${tag eq 'reservation'}">예약필수/웨이팅</c:when>
			                                    <c:otherwise>${tag}</c:otherwise>
			                                </c:choose>
			                            </span>
			                        </c:forTokens>
			                    </div>
			                </c:if>
			            </div>
			
			            <div class="info-cell full-width">
			                <span class="info-label">구글맵 링크</span>
			                <span class="info-value">
			                    <a href="${dto.getLink()}" target="_blank" rel="noopener noreferrer" class="link-map">
			                        📍 구글맵에서 위치 보기 ↗
			                    </a>
			                </span>
			            </div>
			        </div>
			    </c:when>
			
			    <%-- [CASE 2] 카테고리가 음식이 아닌 경우 (관광, 숙소, 마츠리 등) : 한 줄에 카테고리 + 구글맵 링크 --%>
			    <c:otherwise>
			        <div class="view-info-grid default-grid">
			            <div class="info-cell">
			                <span class="info-label">카테고리</span>
			                <span class="info-value">
			                	<c:if test="${dto.getCategory() eq 'sights'}">관광</c:if>
								<c:if test="${dto.getCategory() eq 'festival'}">마츠리/하나비</c:if>
								<c:if test="${dto.getCategory() eq 'stay'}">숙소</c:if>
			                </span>
			            </div>
			
			            <div class="info-cell">
			                <span class="info-label">구글맵 링크</span>
			                <span class="info-value">
			                    <a href="${dto.getLink()}" target="_blank" rel="noopener noreferrer" class="link-map">
			                        📍 구글맵에서 위치 보기 ↗
			                    </a>
			                </span>
			            </div>
			        </div>
			    </c:otherwise>
			</c:choose>

            <!-- 3. 추천 이유 및 설명 본문 -->
            <div class="view-content-section">
                <h3 class="section-title">추천 이유 및 상세 설명</h3>
                <div class="view-content">
                    ${dto.getContent()}
                </div>
            </div>

            <!-- 4. 첨부 사진 갤러리 영역 -->
			<c:if test="${not empty dto.getAttach()}">
			    <div class="view-attach-section">
			        <h3 class="section-title">첨부 사진</h3>
			        <div class="attach-gallery">
			            <c:forTokens items="${dto.attach}" delims="," var="file">
			                <c:set var="fileName" value="${file.trim()}" />
			                <c:if test="${not empty fileName and fileName ne 'null'}">
			                    <%-- c:url 사용 시 contextPath가 자동 결합됩니다 --%>
			                    <c:url var="imgUrl" value="/attach/recommend/${fileName}" />
			                    
			                    <div class="gallery-item">
			                        <a href="${imgUrl}" target="_blank">
			                            <img src="${imgUrl}" alt="장소 사진">
			                        </a>
			                    </div>
			                </c:if>
			            </c:forTokens>
			        </div>
			    </div>
			</c:if>

            <!-- 5. 하단 버튼 영역 (작성자/관리자 권한 처리용) -->
            <div class="btn-group-view">
                <div class="btn-left">
                    <a href="javascript:goRec('list')" class="btn-cancel">목록으로</a>
                </div>
                <div class="btn-right">
				    <c:if test="${sessionScope.sessionId eq dto.getReg_id() or sessionScope.sessionLevel eq 'top'}">
				        <a href="javascript:goUpdateForm('${dto.getNo()}')" class="btn-edit">수정</a>
				        <a href="javascript:goDelete('${dto.getNo()}')" class="btn-delete">삭제</a>
				    </c:if>
				</div>
            </div>

        </div>
    </div>
</div>

<script type="text/javascript">
    function goUpdateForm(no) {
        document.work.t_no.value = no;             
        document.work.t_gubun.value = "updateForm";
        document.work.method = "post";
        document.work.action = "Recommend";
        document.work.submit();
    }

    function goDelete(no) {
        if(confirm("정말 이 게시글을 삭제하시겠습니까?")) {
            document.work.t_no.value = no;        
            document.work.t_gubun.value = "delete";
            document.work.action = "Recommend";
            document.work.method = "post";
            document.work.submit();
        }
    }
</script>