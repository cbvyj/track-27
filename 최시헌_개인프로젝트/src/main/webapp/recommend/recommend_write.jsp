<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "../common_menu.jsp" %>    
<link href="${pageContext.request.contextPath}/css/sub_rec.css" rel="stylesheet">    

<div class="main-container">
    <div class="board-page-container">
        <!-- 상단 타이틀 -->
        <div class="board-header">
            <div class="board-title-group">
                <h2>장소 신청하기</h2>
                <p>알고 계신 숨은 명소를 추천해 주세요. 관리자 검토 후 지도에 반영됩니다.</p>
            </div>
        </div>

        <!-- 글쓰기 폼 카드 영역 -->
        <div class="board-write-card">
            <form name="mem">
       			<input type="hidden" name="t_gubun" value="write">
                
                <!-- 장소명 (제목) -->
                <div class="form-group">
                    <label for="place_name">장소명 (제목) <span class="required">*</span></label>
                    <input type="text" id="place_name" name="place_name" placeholder="예: 이치카츠 아사쿠사바시점" required>
                </div>

                <!-- 카테고리 & 지역 선택 (2열 배치) -->
                <div class="form-group">
				    <label for="category-main">카테고리 <span class="required">*</span></label>
				    <select id="category-main" name="t_category_main" onchange="changeCategory(this.value)">
				        <option value="">선택하세요</option>
				        <option value="food">음식</option>
				        <option value="tour">관광</option>
				        <option value="stay">숙소</option>
				    </select>
				</div>
				
				<!-- 세부 카테고리 (기본은 숨김 처리) -->
				<div class="form-group" id="sub-category-group" style="display: none;">
				    <label for="category-sub">세부 카테고리</label>
				    <select id="category-sub" name="t_category_sub">
				        <!-- JS로 동적 생성됨 -->
				    </select>
				</div>
				<div class="form-group">
                        <label for="region">지역 <span class="required">*</span></label>
                        <select id="region" name="region" required>
                            <option value="">선택하세요</option>
                            <option value="도쿄">도쿄</option>
                            <option value="오사카">오사카</option>
                            <option value="후쿠오카">후쿠오카</option>
                            <option value="삿포로">삿포로</option>
                            <option value="오키나와">오키나와</option>
                            <option value="기타">기타</option>
                        </select>
                    </div>
                <!-- 상세 주소 / 위치 정보 -->
                <div class="form-group">
                    <label for="address">상세 주소 또는 구글맵 링크</label>
                    <input type="text" id="address" name="address" placeholder="예: 東京都台東区浅草橋... 또는 구글맵 주소 입력">
                </div>

                <!-- 추천 이유 및 내용 -->
                <div class="form-group">
                    <label for="content">추천 이유 및 설명 <span class="required">*</span></label>
                    <textarea id="content" name="content" rows="8" placeholder="장소의 특징, 추천 메뉴, 방문 팁 등을 자유롭게 적어주세요." required></textarea>
                </div>

                <!-- 이미지 첨부 -->
                <div class="form-group">
                    <label for="file">사진 첨부</label>
                    <input type="file" id="file" name="file" accept="image/*" class="file-input">
                    <p class="field-tip">※ 장소 관련 사진(외관, 음식, 메뉴판 등)을 첨부해 주세요.</p>
                </div>

                <!-- 비밀글 여부 -->
                <div class="form-group checkbox-group">
                    <label class="custom-checkbox">
                        <input type="checkbox" name="is_secret" value="Y">
                        <span class="checkmark"></span>
                        비밀글로 등록하기 🔒 <span class="secret-tip">(작성자와 관리자만 조회 가능합니다)</span>
                    </label>
                </div>

                <!-- 하단 버튼 그룹 -->
                <div class="btn-group-write">
                    <a href="recommend_list.jsp" class="btn-cancel">취소</a>
                    <button type="submit" class="btn-submit">신청하기</button>
                </div>

            </form>
        </div>
    </div>
</div>

<script>
	function changeCategory(mainCategory) {
	    const subGroup = document.getElementById('sub-category-group');
	    const subSelect = document.getElementById('category-sub');
	    
	    // 세부 옵션 데이터 정의
	    const subOptions = {
	        food: ['식당', '이자카야', '테이크아웃', '카페 & 바'],
	        tour: ['명소/관광', '마츠리/하나비'],
	        stay: ['호텔/료칸', '게스트하우스']
	    };
	
	    // 선택을 해제했거나 데이터가 없으면 숨김
	    if (!mainCategory || !subOptions[mainCategory]) {
	        subGroup.style.display = 'none';
	        subSelect.innerHTML = '';
	        return;
	    }
	
	    // 세부 옵션 생성
	    let html = '<option value="">선택하세요</option>';
	    subOptions[mainCategory].forEach(item => {
	        html += `<option value="${item}">${item}</option>`;
	    });
	
	    subSelect.innerHTML = html;
	    subGroup.style.display = 'block'; // 화면에 표시
	}
</script>