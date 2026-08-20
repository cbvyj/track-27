<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "../common_menu.jsp" %>    
<link href="${pageContext.request.contextPath}/css/sub_rec.css" rel="stylesheet">    

<div class="main-container">
    <div class="board-page-container">
        <!-- 상단 타이틀 -->
        <div class="board-header">
            <div class="board-title-group">
                <h2>장소 신청 수정하기</h2>
                <p>알고 계신 숨은 명소 정보를 수정합니다. 관리자 검토 후 지도에 반영됩니다.</p>
            </div>
        </div>

        <!-- 글쓰기 폼 카드 영역 -->
        <div class="board-write-card">
            <form name="rec">
                <input type="hidden" name="t_gubun">
                <input type="hidden" name="t_no" value="${dto.getNo()}">
                
                <!-- 1. 장소명 (제목) - 단독 행 -->
                <div class="form-group">
                    <label for="title">장소명 (제목) <span class="required">*</span></label>
                    <input type="text" id="title" name="t_title" value="${dto.getTitle()}" placeholder="예: 이치카츠 아사쿠사바시점">
                </div>

                <!-- 2. 카테고리 | 세부 카테고리 (1행 2열) -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="category">카테고리 <span class="required">*</span></label>
                        <select id="category" name="t_category" onchange="changeCategory(this.value)">
                            <option value="">선택하세요</option>
                            <option value="food" <c:if test="${dto.getCategory() eq 'food'}">selected</c:if>>음식</option>
                            <option value="sights" <c:if test="${dto.getCategory() eq 'sights'}">selected</c:if>>관광</option>
                            <option value="festival" <c:if test="${dto.getCategory() eq 'festival'}">selected</c:if>>마츠리/하나비</option>
                            <option value="stay" <c:if test="${dto.getCategory() eq 'stay'}">selected</c:if>>숙소</option>
                        </select>
                    </div>
                    
                    <div class="form-group" id="sub-category-group" style="visibility: hidden;">
                        <label for="sub_category">세부 카테고리 <span class="required">*</span></label>
                        <select id="sub_category" name="t_sub_category">
                            <option value="">선택하세요</option>
                            <option value="restaurant">식당</option>
                            <option value="izakaya">이자카야 / 주점</option>
                            <option value="cafe">카페 / 디저트 / 베이커리</option>
                            <option value="bar">바 / 펍 / 라운지</option>
                        </select>
                    </div>
                </div>

                <!-- 2-1. 장소 특징 태그 영역 -->
                <div class="form-group" id="tag-group" style="display: none;">
                    <label>장소 특징 <span class="required">* (최소 1개 선택)</span></label>
                    <div class="tag-grid">
                        <label class="tag-item">
                            <input type="checkbox" name="t_tags" value="casual"> 일반/캐주얼
                        </label>
                        <label class="tag-item">
                            <input type="checkbox" name="t_tags" value="fine_dining"> 고급/파인다이닝
                        </label>
                        <label class="tag-item">
                            <input type="checkbox" name="t_tags" value="view"> 뷰/야경/루프탑
                        </label>
                        <label class="tag-item">
                            <input type="checkbox" name="t_tags" value="takeout"> 테이크아웃 전용
                        </label>
                        <label class="tag-item">
                            <input type="checkbox" name="t_tags" value="reservation"> 예약필수/웨이팅
                        </label>
                    </div>
                </div>

                <!-- 3. 지역 | 구글맵 링크 (1행 2열) -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="region">지역 <span class="required">*</span></label>
                        <select id="region" name="t_region">
                            <option value="">선택하세요</option>
                            <option value="tokyo" <c:if test="${dto.getRegion() eq 'tokyo'}">selected</c:if>>도쿄</option>
                            <option value="saitama" <c:if test="${dto.getRegion() eq 'saitama'}">selected</c:if>>사이타마</option>
                            <option value="chiba" <c:if test="${dto.getRegion() eq 'chiba'}">selected</c:if>>치바</option>
                            <option value="kanagawa" <c:if test="${dto.getRegion() eq 'kanagawa'}">selected</c:if>>카나가와</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="link">구글맵 링크 <span class="required">*</span></label>
                        <input type="text" id="link" name="t_link" value="${dto.getLink()}" placeholder="구글맵 링크">
                    </div>
                </div>
                
                <c:if test="${sessionScope.sessionLevel eq 'top'}">
					<div class="form-row">
	                    <div class="form-group">
	                        <label for="lat">위도</label>
	                        <input type="text" id="lat" name="t_lat">
	                    </div>
	                    <div class="form-group">
	                        <label for="lng">위도</label>
	                        <input type="text" id="llng" name="t_lng">
	                    </div>
	                </div>
                </c:if>
                
                <!-- 4. 추천 이유 및 설명 -->
                <div class="form-group">
                    <label for="content">추천 이유 및 설명 <span class="required">*</span></label>
                    <textarea id="content" name="t_content" rows="8" placeholder="장소의 특징, 추천 메뉴, 방문 팁 등을 자유롭게 적어주세요.">${dto.getContent()}</textarea>
                </div>

                <!-- 5. 등록된 사진 미리보기 영역 (조회전용) -->
                <div class="form-group">
                    <label>첨부된 사진</label>
                    <div id="preview-container" class="preview-container"></div>
                </div>

                <!-- 6. 비밀글 설정 -->
                <input type="hidden" name="t_secret" value="Y">

                <div class="form-group secret-notice-box">
                    <div class="secret-notice-content">
                        <span class="lock-icon">🔒</span>
                        <div>
                            <strong>이 게시글은 비밀글로 자동 등록됩니다.</strong>
                            <p>신청하신 장소 정보는 작성자와 관리자만 조회할 수 있습니다.</p>
                            <p>장소가 지도에 반영되면 해당 게시글은 공개글로 변경됩니다.</p>
                        </div>
                    </div>
                </div>

                <!-- 하단 버튼 영역 -->
                <div class="btn-group-write">
                    <a href="javascript:history.back()" class="btn-cancel">취소</a>
                    <button type="button" onclick="javascript:goUpdate()" class="btn-submit">수정하기</button>
                </div>

            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
    // 카테고리 변경 시 세부 카테고리 / 태그 영역 동적 변환
    function changeCategory(mainCategory) {
        const subGroup = document.getElementById('sub-category-group');
        const subSelect = document.getElementById('sub_category');
        const tagGroup = document.getElementById('tag-group');
        
        const foodSubOptions = [
            { value: 'restaurant', text: '식당' },
            { value: 'izakaya', text: '이자카야 / 주점' },
            { value: 'cafe', text: '카페 / 디저트 / 베이커리' },
            { value: 'bar', text: '바 / 펍 / 라운지' }
        ];

        if (mainCategory === 'food') {
            let html = '<option value="">선택하세요</option>';
            foodSubOptions.forEach(function(item) {
                html += '<option value="' + item.value + '">' + item.text + '</option>';
            });

            subSelect.innerHTML = html;
            subGroup.style.visibility = 'visible';
            tagGroup.style.display = 'block';
        } else {
            subGroup.style.visibility = 'hidden';
            tagGroup.style.display = 'none';
            subSelect.innerHTML = '<option value="">선택하세요</option>';
        }
    }

    // DOM 로드 완료 시 기존 DB 값 복원 및 이미지 미리보기 출력
    window.addEventListener('DOMContentLoaded', function() {
        const categorySelect = document.getElementById('category');
        const currentCategory = categorySelect.value;

        if (currentCategory === 'food') {
            changeCategory('food');

            const subCategory = "${dto.getSub_category()}";
            if (subCategory && subCategory !== "null") {
                document.getElementById('sub_category').value = subCategory;
            }

            const rawTags = "${dto.getTags()}";
            if (rawTags && rawTags !== "null") {
                const tagMap = {
                    '일반/캐주얼': 'casual',
                    '고급/파인다이닝': 'fine_dining',
                    '뷰/야경/루프탑': 'view',
                    '테이크아웃 전용': 'takeout',
                    '예약필수/웨이팅': 'reservation'
                };

                const cleanTags = rawTags.replace(/[\[\]'"]/g, '');
                const tagArray = cleanTags.split(',');
                
                tagArray.forEach(function(tag) {
                    let cleanValue = tag.trim();
                    if (!cleanValue) return;

                    if (tagMap[cleanValue]) cleanValue = tagMap[cleanValue];

                    let checkbox = document.querySelector('input[name="t_tags"][value="' + cleanValue + '"]');

                    if (!checkbox) {
                        const allCheckboxes = document.querySelectorAll('input[name="t_tags"]');
                        allCheckboxes.forEach(function(cb) {
                            if (cb.parentElement && cb.parentElement.textContent.includes(tag.trim())) {
                                checkbox = cb;
                            }
                        });
                    }

                    if (checkbox) checkbox.checked = true;
                });
            }
        }

        // 기존 DB 첨부파일 단순 미리보기 렌더링
        renderImagePreviews();
    });

    // DB에 있는 기존 이미지 미리보기만 출력하는 함수
    function renderImagePreviews() {
        const rawAttach = "${dto.getAttach()}"; 
        const container = document.getElementById('preview-container');
        container.innerHTML = '';

        if (rawAttach && rawAttach !== "null" && rawAttach.trim() !== "") {
            const cleanAttach = rawAttach.replace(/[\[\]'"]/g, '');
            const fileArray = cleanAttach.split(',');

            fileArray.forEach(function(fileName) {
                const name = fileName.trim();
                if (name) {
                    const item = document.createElement('div');
                    item.className = 'preview-item';

                    // 공백/특수문자 파일명 깨짐 방지 (encodeURIComponent)
                    // 프로젝트의 실제 서버 이미지 경로('/attach/recommend/' 또는 '/upload/recommend/') 확인 필요
                    const imgUrl = "${pageContext.request.contextPath}/attach/recommend/" + encodeURIComponent(name);

                    item.innerHTML = '<img src="' + imgUrl + '" class="preview-thumb" alt="thumb">'
                                   + '<span class="preview-name">' + name + '</span>';

                    container.appendChild(item);
                }
            });
        } else {
            container.innerHTML = '<p style="color:#888; font-size:14px;">등록된 첨부사진이 없습니다.</p>';
        }
    }

    // 수정 저장
	function goUpdate() {
	    if (isEmpty(rec.t_title, "장소명(제목)을 입력하세요.")) return;
	    if (isEmpty(rec.t_category, "카테고리를 선택하세요.")) return;
	    
	    if (rec.t_category.value === 'food') {
	        if (isEmpty(rec.t_sub_category, "세부 카테고리를 선택하세요.")) return;
	        
	        const checkedTags = document.querySelectorAll('input[name="t_tags"]:checked');
	        if (checkedTags.length === 0) {
	            alert("장소 특징을 최소 1개 이상 선택하세요.");
	            return;
	        }
	    }
	    
	    if (isEmpty(rec.t_region, "지역을 선택하세요.")) return;
	    if (isEmpty(rec.t_link, "구글맵 링크를 입력하세요.")) return;
	    
	    // 관리자용 필드(t_lat)가 DOM에 존재할 때만 필수값 검증
	    if (rec.t_lat) {
	        if (isEmpty(rec.t_lat, "위도를 입력하세요.")) return;
	        if (isEmpty(rec.t_lng, "경도를 입력하세요.")) return;
	    }
	
	    if (isEmpty(rec.t_content, "추천 이유 및 내용을 입력하세요.")) return;
	
	    rec.t_gubun.value = "update";
	    rec.method = "post";
	    rec.action = "Recommend";
	    rec.submit();
	}
</script>