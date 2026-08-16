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
            <form name="rec" enctype="multipart/form-data">
                <input type="hidden" name="t_gubun">
                
                <!-- 1. 장소명 (제목) - 단독 행 -->
                <div class="form-group">
                    <label for="title">장소명 (제목) <span class="required">*</span></label>
                    <input type="text" id="title" name="t_title" placeholder="예: 이치카츠 아사쿠사바시점">
                </div>

                <!-- 2. 카테고리 | 세부 카테고리 (1행 2열) -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="category">카테고리 <span class="required">*</span></label>
                        <select id="category" name="t_category" onchange="changeCategory(this.value)">
                            <option value="">선택하세요</option>
                            <option value="food">음식</option>
                            <option value="sights">관광</option>
                            <option value="festival">마츠리/하나비</option>
                            <option value="stay">숙소</option>
                        </select>
                    </div>
                    
                    <div class="form-group" id="sub-category-group" style="visibility: hidden;">
                        <label for="category-sub">세부 카테고리 <span class="required">*</span></label>
                        <select id="category-sub" name="t_category_sub">
                            <option value="">선택하세요</option>
                            <option value="restaurant">식당</option>
                            <option value="izakaya">이자카야 / 주점</option>
                            <option value="cafe">카페 / 디저트 / 베이커리</option>
                            <option value="bar">바 / 펍 / 라운지</option>
                        </select>
                    </div>
                </div>

                <!-- 2-1. 장소 특징 태그 영역 (음식 선택 시 노출, 2행 3열 그리드) -->
                <div class="form-group" id="tag-group" style="display: none;">
                    <label>장소 특징 <span class="required">* (최소 1개 선택)</span></label>
                    <div class="tag-grid">
                        <label class="tag-item">
                            <input type="checkbox" name="t_tags" value="casual" checked> 일반/캐주얼
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
                            <option value="tokyo">도쿄</option>
                            <option value="saitama">사이타마</option>
                            <option value="chiba">치바</option>
                            <option value="kanagawa">카나가와</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="link">구글맵 링크 <span class="required">*</span></label>
                        <input type="text" id="link" name="t_link" placeholder="구글맵 링크">
                    </div>
                </div>

                <!-- 4. 추천 이유 및 설명 - 단독 행 -->
                <div class="form-group">
                    <label for="content">추천 이유 및 설명 <span class="required">*</span></label>
                    <textarea id="content" name="t_content" rows="8" placeholder="장소의 특징, 추천 메뉴, 방문 팁 등을 자유롭게 적어주세요."></textarea>
                </div>

                <!-- 5. 사진 첨부 - 단독 행 -->
                <div class="form-group">
                    <label for="file">사진 첨부<span class="required">*</span></label>
                    <input type="file" id="file" name="t_attach" accept="image/*" multiple class="file-input" onchange="previewImages(event)">
                    <p class="field-tip">※ 본인이 찍은 장소 관련 사진(풍경, 음식 등)을 첨부해 주세요. (여러 장 선택 가능)</p>
                    <p class="field-tip">※ 타인의 사진 무단 도용 시 사전 통보 없이 삭제될 수 있으며 저작권 및 초상권 침해에 따른 법적 책임은 작성자 본인에게 있습니다.</p>
                    <!-- 네이버 메일 스타일 썸네일 미리보기 리스트 영역 -->
                    <div id="preview-container" class="preview-container"></div>
                </div>

                <!-- 6. 비밀글 체크박스 -->
                <input type="hidden" name="t_secret" value="Y">

                <div class="form-group secret-notice-box">
                    <div class="secret-notice-content">
                        <span class="lock-icon">🔒</span>
                        <div>
                            <strong>이 게시글은 비밀글로 자동 등록됩니다.</strong>
                            <p>신청하신 장소 정보는 작성자와 관리자만 조회할 수 있습니다.</p>
                        </div>
                    </div>
                </div>

                <!-- 하단 버튼 영역 -->
                <div class="btn-group-write">
                    <a href="javascript:goRec('list')" class="btn-cancel">취소</a>
                    <button type="button" onclick="javascript:goSave()" class="btn-submit">신청하기</button>
                </div>

            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
    function changeCategory(mainCategory) {
        const subGroup = document.getElementById('sub-category-group');
        const subSelect = document.getElementById('category-sub');
        const tagGroup = document.getElementById('tag-group');
        
        // 세부 카테고리 4개로 수정 적용
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
            tagGroup.style.display = 'block'; // 음식 선택 시 태그 체크박스 출력
        } else {
            subGroup.style.visibility = 'hidden';
            tagGroup.style.display = 'none'; // 음식 아닐 시 태그 영역 숨김
            subSelect.innerHTML = '<option value="">선택하세요</option>';
        }
    }

    // 누적된 파일들을 담아둘 전역 DataTransfer 객체 생성
    const dataTransfer = new DataTransfer();

    function previewImages(event) {
        const input = event.target;
        const newFiles = input.files;

        if (newFiles && newFiles.length > 0) {
            // 새로 선택한 파일들을 기존 dataTransfer 목록에 누적 추가
            Array.from(newFiles).forEach(function(file) {
                if (file.type.startsWith('image/')) {
                    dataTransfer.items.add(file);
                }
            });

            // input태그의 files 속성을 누적된 DataTransfer 목록으로 교체
            input.files = dataTransfer.files;
        }

        // 미리보기 화면 다시 그리기
        renderPreviews();
    }

    // 미리보기 화면 출력 및 개별 삭제 처리 전용 함수
    function renderPreviews() {
        const container = document.getElementById('preview-container');
        container.innerHTML = ''; // 화면 초기화

        const files = dataTransfer.files;

        Array.from(files).forEach(function(file, index) {
            const item = document.createElement('div');
            item.className = 'preview-item';

            const sizeKB = (file.size / 1024).toFixed(1) + ' KB';
            const imgUrl = URL.createObjectURL(file);

            // 네이버 메일 스타일 HTML + 개별 삭제(X) 버튼 추가
            item.innerHTML = '<img src="' + imgUrl + '" class="preview-thumb" alt="thumb">'
                           + '<span class="preview-name">' + file.name + '</span>'
                           + '<span class="preview-size">' + sizeKB + '</span>'
                           + '<button type="button" class="btn-remove-file" onclick="removeFile(' + index + ')">×</button>';

            container.appendChild(item);
        });
    }

    // 특정 순서의 파일을 목록에서 삭제하는 함수
    function removeFile(index) {
        dataTransfer.items.remove(index); // 해당 인덱스 파일 삭제
        document.getElementById('file').files = dataTransfer.files; // input태그 files 갱신
        renderPreviews(); // 화면 갱신
    }
    
    function goSave() {
        if (isEmpty(rec.t_title, "장소명(제목)을 입력하세요.")) return;
        if (isEmpty(rec.t_category, "카테고리를 선택하세요.")) return;
        
        if (rec.t_category.value === 'food') {
            if (isEmpty(rec.t_category_sub, "세부 카테고리를 선택하세요.")) return;
            
            const checkedTags = document.querySelectorAll('input[name="t_tags"]:checked');
            if (checkedTags.length === 0) {
                alert("장소 특징 태그를 최소 1개 이상 선택하세요.");
                return;
            }
        }
        
        if (isEmpty(rec.t_region, "지역을 선택하세요.")) return;
        if (isEmpty(rec.t_link, "구글맵 링크를 입력하세요.")) return;
        if (isEmpty(rec.t_content, "추천 이유 및 내용을 입력하세요.")) return;

        // 1. 파일 첨부 여부 체크
        const files = dataTransfer.files;
        if (files.length === 0) {
            alert("1개 이상의 사진 파일을 업로드하세요.");
            return;
        }

        // 2. 용량 및 확장자 제한 검사
        const maxFileSize = 50 * 1024 * 1024; // 50MB
        const allowedExtensions = ['png', 'jpg', 'jpeg'];

        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            const fileName = file.name;
            const fileSize = file.size;

            const ext = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();

            if (!allowedExtensions.includes(ext)) {
                alert(`'${fileName}'은(는) 업로드할 수 없는 형식입니다.\n(png, jpg, jpeg 파일만 가능합니다.)`);
                return;
            }

            if (fileSize > maxFileSize) {
                alert(`'${fileName}' 파일 용량이 50MB를 초과합니다.`);
                return;
            }
        }

        // 3. 다중 파일 개별 파라미터화 (COS 라이브러리 다중 저장 오류 해결)
        const fileInput = document.getElementById('file');
        fileInput.removeAttribute('name'); // 기존 single input name 제거

        for (let i = 0; i < files.length; i++) {
            const dt = new DataTransfer();
            dt.items.add(files[i]);

            const newInput = document.createElement('input');
            newInput.type = 'file';
            newInput.name = 't_attach_' + i; // t_attach_0, t_attach_1 형태로 각각 다른 name 부여
            newInput.style.display = 'none';
            newInput.files = dt.files;
            rec.appendChild(newInput);
        }

        rec.method = "post";
        rec.action = "Recommend?t_gubun=save";
        rec.submit();
    }
</script>