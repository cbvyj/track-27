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
            <form name="rec" action="Recommend" method="post" enctype="multipart/form-data">
                <input type="hidden" name="t_gubun" value="save">
                
                <!-- 1. 장소명 (제목) - 단독 행 -->
                <div class="form-group">
                    <label for="place_name">장소명 (제목) <span class="required">*</span></label>
                    <input type="text" id="place_name" name="t_title" placeholder="예: 이치카츠 아사쿠사바시점">
                </div>

                <!-- 2. 카테고리 | 세부 카테고리 (1행 2열) -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="category-main">카테고리 <span class="required">*</span></label>
                        <select id="category-main" name="t_category_main" onchange="changeCategory(this.value)">
                            <option value="">선택하세요</option>
                            <option value="food">음식</option>
                            <option value="tour">관광</option>
                            <option value="stay">숙소</option>
                        </select>
                    </div>
                    
                    <div class="form-group" id="sub-category-group" style="visibility: hidden;">
                        <label for="category-sub">세부 카테고리 <span class="required">*</span></label>
                        <select id="category-sub" name="t_category_sub">
                            <option value="">선택하세요</option>
                            <option value="restaurant">식당</option>
                            <option value="alcohol">이자카야</option>
                            <option value="takeout">테이크아웃</option>
                            <option value="drink">카페 & 바</option>
                        </select>
                    </div>
                </div>

                <!-- 3. 지역 | 구글맵 링크 (1행 2열) -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="region">지역 <span class="required">*</span></label>
                        <select id="region" name="t_region">
                            <option value="">선택하세요</option>
                            <option value="도쿄">도쿄</option>
                            <option value="사이타마">사이타마</option>
                            <option value="치바">치바</option>
                            <option value="카나가와">카나가와</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="link">구글맵 링크 <span class="required">*</span></label>
                        <input type="text" id="link" name="t_link" placeholder="구글맵 주소 입력">
                    </div>
                </div>

                <!-- 4. 추천 이유 및 설명 - 단독 행 -->
                <div class="form-group">
                    <label for="content">추천 이유 및 설명 <span class="required">*</span></label>
                    <textarea id="content" name="t_content" rows="8" placeholder="장소의 특징, 추천 메뉴, 방문 팁 등을 자유롭게 적어주세요."></textarea>
                </div>

                <!-- 5. 사진 첨부 - 단독 행 -->
                <div class="form-group">
                    <label for="file">사진 첨부</label>
                    <!-- 💡 중복 입력된 multiple 중 하나 정돈 -->
                    <input type="file" id="file" name="t_attach" accept="image/*" multiple class="file-input" onchange="previewImages(event)">
                    <p class="field-tip">※ 장소 관련 사진(외관, 음식, 메뉴판 등)을 첨부해 주세요. (여러 장 선택 가능)</p>
                    
                    <!-- 💡 네이버 메일 스타일 썸네일 미리보기 리스트 영역 -->
                    <div id="preview-container" class="preview-container"></div>
                </div>

                <!-- 6. 비밀글 체크박스 -->
                <div class="form-group checkbox-group">
                    <label class="custom-checkbox">
                        <input type="checkbox" name="t_secret" value="Y">
                        <span class="checkmark"></span>
                        비밀글로 등록하기 🔒 <span class="secret-tip">(작성자와 관리자만 조회 가능합니다)</span>
                    </label>
                </div>

                <!-- 하단 버튼 영역 -->
                <div class="btn-group-write">
                    <a href="javascript:goRec('list')" class="btn-cancel">취소</a>
                    <button type="button" onclick="goWrite()" class="btn-submit">신청하기</button>
                </div>

            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
    function changeCategory(mainCategory) {
        const subGroup = document.getElementById('sub-category-group');
        const subSelect = document.getElementById('category-sub');
        
        const foodSubOptions = [
            { value: 'restaurant', text: '식당' },
            { value: 'alcohol', text: '이자카야' },
            { value: 'takeout', text: '테이크아웃' },
            { value: 'drink', text: '카페 & 바' }
        ];

        if (mainCategory === 'food') {
            let html = '<option value="">선택하세요</option>';
            foodSubOptions.forEach(function(item) {
                html += '<option value="' + item.value + '">' + item.text + '</option>';
            });

            subSelect.innerHTML = html;
            subGroup.style.visibility = 'visible';
        } else {
            subGroup.style.visibility = 'hidden';
            subSelect.innerHTML = '<option value="">선택하세요</option>';
        }
    }

    function previewImages(event) {
        const container = document.getElementById('preview-container');
        container.innerHTML = '';

        const files = event.target.files;
        if (!files || files.length === 0) return;

        Array.from(files).forEach(function(file) {
            if (!file.type.startsWith('image/')) return;

            const item = document.createElement('div');
            item.className = 'preview-item';

            const sizeKB = (file.size / 1024).toFixed(1) + ' KB';
            const imgUrl = URL.createObjectURL(file);

            item.innerHTML = '<img src="' + imgUrl + '" class="preview-thumb" alt="thumb">'
                           + '<span class="preview-name">' + file.name + '</span>'
                           + '<span class="preview-size">' + sizeKB + '</span>';

            container.appendChild(item);
        });
    }

    function goWrite() {
        if (isEmpty(rec.t_title, "장소명(제목)을 입력하세요.")) return;
        if (isEmpty(rec.t_category_main, "카테고리를 선택하세요.")) return;
        
        if (rec.t_category_main.value === 'food' && isEmpty(rec.t_category_sub, "세부 카테고리를 선택하세요.")) return;
        
        if (isEmpty(rec.t_region, "지역을 선택하세요.")) return;
        if (isEmpty(rec.t_link, "구글맵 링크를 입력하세요.")) return;
        if (isEmpty(rec.t_content, "추천 이유 및 내용을 입력하세요.")) return;

        
        //rec.submit();
    }
</script>