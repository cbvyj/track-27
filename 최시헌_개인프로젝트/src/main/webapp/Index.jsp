<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Track27 최시헌</title>
    <!-- 분리된 외부 CSS 불러오기 -->
    <link href="${pageContext.request.contextPath}/css/Main.css" rel="stylesheet">    
    <script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
</head>
<body>
    <header>
        <div class="title">穴場 一都三県</div>
        <div class="my">
            <c:if test="${not empty sessionName}">
                <span class="user-name">${sessionName}님</span>
                &nbsp;
                <a href="javascript:goPage('memberLogout')">Logout</a>
            </c:if>
            <c:if test="${empty sessionName}">
                <a href="Member" onclick="openLoginModal(); return false;">Login</a>
                &nbsp;
                <a href="javascript:goPage('join')">Join</a>
            </c:if>
        </div>
    </header>
    
    <div class="sidebar-container">
        <div class="search-container">
            <input type="text" class="search-box" name="t_search" placeholder="검색어를 입력하세요" value="${search}" onfocus="this.value=''" onkeydown="if(event.keyCode == 13){ goSearch(); return false; }">
            &nbsp;
            <button type="button" class="search-button" onclick="goSearch()">🔍</button>
        </div>
        
        <div class="filter">
            <p class="filter-title">지역별 필터</p>
            <ul class="filter-list">
                <li>
                    <div class="region">
                        <span class="regionArrow" onclick="RegionList()">▶</span>
                        <label><input type="checkbox" id="region-check-all"> 전체</label>
                    </div>
                    <ul id="sub-region-list" class="sub-list">
                        <li><label>▶ <input type="checkbox" class="region-check" value="도쿄"> 도쿄</label></li>
                        <li><label>▶ <input type="checkbox" class="region-check" value="사이타마"> 사이타마</label></li>
                        <li><label>▶ <input type="checkbox" class="region-check" value="치바"> 치바</label></li>
                        <li><label>▶ <input type="checkbox" class="region-check" value="카나가와"> 카나가와</label></li>
                    </ul>
                </li>
            </ul>
        </div>

        <div class="filter">
            <p class="filter-title">카테고리별 필터</p>
            <ul class="filter-list">
                <li>
                    <div class="category">
                        <span class="categoryArrow" onclick="CategoryList()">▶</span>
                        <label><input type="checkbox" id="category-check-all"> 전체</label>
                    </div>
                    <ul id="sub-category-list" class="sub-list">
                        <li>
                            <span class="foodArrow" onclick="FoodList()">▶</span>
                            <label><input type="checkbox" class="category-check food-check-all"> 음식</label>
							<ul id="sub-food-list" class="sub-list">
							    <li><label>▶ <input type="checkbox" class="food-check" value="식당"> 식당</label></li>
							    <li><label>▶ <input type="checkbox" class="food-check" value="이자카야"> 이자카야 / 주점</label></li>
							    <li><label>▶ <input type="checkbox" class="food-check" value="카페"> 카페 / 디저트 / 베이커리</label></li>
							    <li><label>▶ <input type="checkbox" class="food-check" value="바"> 바 / 펍 / 라운지</label></li>
							</ul>
                        </li>
                        <li><label>▶ <input type="checkbox" class="category-check" value="관광"> 관광</label></li>
                        <li><label>▶ <input type="checkbox" class="category-check" value="마츠리"> 마츠리/하나비</label></li>
                        <li><label>▶ <input type="checkbox" class="category-check" value="숙소"> 숙소</label></li>
                    </ul>
                </li>
            </ul>
        </div>
        
        <c:if test="${not empty sessionName}">
        <div class="filter mypage-section">		
            <span class="mypage-title">마이페이지</span>
            <ul class="mypage-list">
                <li><a href="javascript:goPage('myinfo')">▶ &nbsp;내 정보</a></li>
                <li><a href="">▶ &nbsp;북마크</a></li>
                <li><a href="Recommend">▶ &nbsp;장소 신청하기</a></li>
            </ul>
        </div>
        </c:if>

        <div class="footer">
            <address class="address">
                <p class="title">본사</p>
                (우)12345 대전광역시 중구 계룡로 825<br>
                고객센터: 042-242-4412
            </address>
            <p class="copyright">Copyright &copy; JSL. All rights reserved.</p>
        </div>
    </div>

    <!-- 메인 지도 영역 -->
    <div class="main-container">
        <div id="map"></div>
        
        <div class="map-message" id="map-message">
        원하는 지역 또는 카테고리를 선택해 주세요.
   	 	</div>
        
        <!-- 지도 상단 카테고리 범례 (Legend) -->
        <div class="map-legend">
            <div class="legend-item">
                <span class="legend-dot" style="background: #e03131;"></span>
                <span>음식</span>
            </div>
            <div class="legend-item">
                <span class="legend-dot" style="background: #7048e8;"></span>
                <span>관광</span>
            </div>
            <div class="legend-item">
                <span class="legend-dot" style="background: #00b8d4;"></span>
                <span>숙소</span>
            </div>
            <div class="legend-item">
                <span class="legend-dot" style="background: #f59f00;"></span>
                <span>마츠리/하나비</span>
            </div>
        </div>
    </div>
    
    <!-- 모달 오버레이 & 컨테이너 -->
    <div id="modal-overlay" class="modal-overlay" onclick="closeModal()"></div>
    <div id="modal-card" class="modal-card"></div>

    <form name="work">
        <input type="hidden" name="t_gubun">
        <input type="hidden" name="t_nowPage">
        <input type="hidden" name="t_no">
    </form>

    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB85lO0bCRzB3RXAGD1UTS7NK2VQLg8DeI&callback=initMap" async defer></script>
    
	<script type="text/javascript">
	    function goPage(gubun) {
	        document.work.t_gubun.value = gubun;
	        document.work.method = "post";
	        document.work.action = "Member";
	        document.work.submit();
	    }
	
	    function goView(no) {
	        document.work.t_gubun.value = "view";
	        document.work.t_no.value = no;
	        
	        // ✨ 지도의 마커를 통해 상세보기로 접근했음을 알리는 파라미터 생성/전달
	        let fromInput = document.work.querySelector('input[name="t_from"]');
	        if (!fromInput) {
	            fromInput = document.createElement('input');
	            fromInput.type = 'hidden';
	            fromInput.name = 't_from';
	            document.work.appendChild(fromInput);
	        }
	        fromInput.value = "map";

	        document.work.method = "post";
	        document.work.action = "Recommend";
	        document.work.submit();
	    }
	
	    // 1. 지역 및 카테고리 아코디언 토글
	    function RegionList() {
	        const subList = document.getElementById('sub-region-list');
	        const arrow = document.querySelector('.regionArrow');
	        if (subList && arrow) {
	            subList.classList.toggle('open');
	            arrow.classList.toggle('open');
	        }
	    }
	
	    function CategoryList() {
	        const subList = document.getElementById('sub-category-list');
	        const arrow = document.querySelector('.categoryArrow');
	        const subFoodList = document.getElementById('sub-food-list');
	        const foodArrow = document.querySelector('.foodArrow');
	
	        if (subList && arrow) {
	            const isOpen = subList.classList.toggle('open');
	            arrow.classList.toggle('open');
	
	            if (subFoodList && foodArrow) {
	                if (isOpen) {
	                    subFoodList.classList.add('open');
	                    foodArrow.classList.add('open');
	                } else {
	                    subFoodList.classList.remove('open');
	                    foodArrow.classList.remove('open');
	                }
	            }
	        }
	    }
	
	    function FoodList() {
	        const subFoodList = document.getElementById('sub-food-list');
	        const arrow = document.querySelector('.foodArrow');
	        if (subFoodList && arrow) {
	            subFoodList.classList.toggle('open');
	            arrow.classList.toggle('open');
	        }
	    }
	
	    // 2. 상위/하위 체크박스 동기화 로직
	    function updateRegionCheckState() {
	        const checkAll = document.getElementById('region-check-all');
	        const regionChecks = document.querySelectorAll('.region-check');
	        if (checkAll && regionChecks.length > 0) {
	            checkAll.checked = Array.from(regionChecks).every(cb => cb.checked);
	        }
	    }
	
	    function updateFoodCheckState() {
	        const foodCheckAll = document.querySelector('.food-check-all');
	        const foodChecks = document.querySelectorAll('.food-check');
	        if (foodCheckAll && foodChecks.length > 0) {
	            foodCheckAll.checked = Array.from(foodChecks).every(cb => cb.checked);
	        }
	    }
	
	    function syncParentCheckboxes() {
	        updateFoodCheckState(); 
	
	        const categoryCheckAll = document.getElementById('category-check-all');
	        const foodCheckAll = document.querySelector('.food-check-all');
	        const otherCategoryChecks = document.querySelectorAll('.category-check:not(.food-check-all)');
	
	        if (!categoryCheckAll) return;
	
	        const isFoodAllChecked = foodCheckAll ? foodCheckAll.checked : true;
	        const isOthersAllChecked = otherCategoryChecks.length > 0 && Array.from(otherCategoryChecks).every(cb => cb.checked);
	
	        categoryCheckAll.checked = isFoodAllChecked && isOthersAllChecked;
	    }
	
	    // 3. 지역별 필터 이벤트 (수정됨: 전체 선택 시 아코디언 열기 추가)
	    const checkAll = document.getElementById('region-check-all');
	    const regionChecks = document.querySelectorAll('.region-check');
	
	    if (checkAll) {
	        checkAll.addEventListener('change', function(e) {
	            const isChecked = e.target.checked;
	            regionChecks.forEach(cb => cb.checked = isChecked);
	            
	            // ✨ 전체 체크 시 아코디언 강제 오픈
	            if (isChecked) {
	                const subList = document.getElementById('sub-region-list');
	                const arrow = document.querySelector('.regionArrow');
	                if (subList) subList.classList.add('open');
	                if (arrow) arrow.classList.add('open');
	            }
	            
	            filterMarkers();
	        });
	    }
	
	    regionChecks.forEach(cb => {
	        cb.addEventListener('change', function() {
	            updateRegionCheckState();
	            filterMarkers();
	        });
	    });
	
	    // 4. 카테고리별 필터 이벤트 (수정됨: 전체 선택 시 아코디언 열기 추가)
	    const categoryCheckAll = document.getElementById('category-check-all');
	    const foodCheckAll = document.querySelector('.food-check-all');
	    const foodChecks = document.querySelectorAll('.food-check');
	    const otherCategoryChecks = document.querySelectorAll('.category-check:not(.food-check-all)');
	
	    if (categoryCheckAll) {
	        categoryCheckAll.addEventListener('change', function(e) {
	            const isChecked = e.target.checked;
	            if (foodCheckAll) foodCheckAll.checked = isChecked;
	            foodChecks.forEach(cb => cb.checked = isChecked);
	            otherCategoryChecks.forEach(cb => cb.checked = isChecked);
	            
	            // ✨ 카테고리 전체 체크 시 하위 아코디언 모두 강제 오픈
	            if (isChecked) {
	                const subCategoryList = document.getElementById('sub-category-list');
	                const categoryArrow = document.querySelector('.categoryArrow');
	                if (subCategoryList) subCategoryList.classList.add('open');
	                if (categoryArrow) categoryArrow.classList.add('open');

	                const subFoodList = document.getElementById('sub-food-list');
	                const foodArrow = document.querySelector('.foodArrow');
	                if (subFoodList) subFoodList.classList.add('open');
	                if (foodArrow) foodArrow.classList.add('open');
	            }
	            
	            filterMarkers();
	        });
	    }
	
	    if (foodCheckAll) {
	        foodCheckAll.addEventListener('change', function(e) {
	            const isChecked = e.target.checked;
	            foodChecks.forEach(cb => cb.checked = isChecked);
	            syncParentCheckboxes();
	            
	            // ✨ 음식 전체 체크 시 음식 하위 아코디언 강제 오픈
	            if (isChecked) {
	                const subFoodList = document.getElementById('sub-food-list');
	                const foodArrow = document.querySelector('.foodArrow');
	                if (subFoodList) subFoodList.classList.add('open');
	                if (foodArrow) foodArrow.classList.add('open');
	            }
	            
	            filterMarkers();
	        });
	    }
	
	    foodChecks.forEach(cb => {
	        cb.addEventListener('change', function() {
	            syncParentCheckboxes();
	            filterMarkers();
	        });
	    });
	
	    otherCategoryChecks.forEach(cb => {
	        cb.addEventListener('change', function() {
	            syncParentCheckboxes();
	            filterMarkers();
	        });
	    });
	
	    // 5. 구글 맵 초기화 및 마커 생성 (기존 유지)
	    let allMarkers = [];
	
	    function initMap() {
	        const centerLatLng = { lat: 35.6895, lng: 139.6917 }; 
	        const mapElement = document.getElementById('map');
	        
	        if (!mapElement) return;

	        const map = new google.maps.Map(mapElement, {
	            zoom: 10, 
	            center: centerLatLng,
	            disableDefaultUI: true
	        });

	        const pinSymbol = {
	            path: "M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7z",
	            fillOpacity: 1,
	            scale: 1.5,
	            strokeColor: "#000000", 
	            strokeWeight: 1.5,   
	            anchor: new google.maps.Point(12, 22)
	        };

	        const categoryColors = {
	            'food': '#e03131',      
	            'sights': '#7048e8',   
	            'stay': '#00b8d4',      
	            'festival': '#f59f00'  
	        };
	        const defaultColor = '#495057';

	        const locations = [
	            <c:forEach items="${dtos}" var="dto" varStatus="status">
	                { 
	                    no: "${dto.getNo()}",
	                    title: `${dto.getTitle()}`.replace(/[\n\r]+/g, ' ').replace(/"/g, '\\"'), 
	                    category: "${dto.getCategory()}",
	                    subCategory: "${dto.getSub_category()}",
	                    tags: "${dto.getTags()}",
	                    region: "${dto.getRegion()}",
	                    content: `${dto.getContent()}`.replace(/[\n\r]+/g, ' ').replace(/"/g, '\\"'),
	                    lat: parseFloat("${dto.getLat()}"), 
	                    lng: parseFloat("${dto.getLng()}") 
	                }${!status.last ? ',' : ''}
	            </c:forEach>
	        ];

	        allMarkers = [];

	        locations.forEach(loc => {
	            if (!isNaN(loc.lat) && !isNaN(loc.lng) && loc.lat !== 0 && loc.lng !== 0) {
	                
	                let color = defaultColor;
	                if (loc.category) {
	                    const lowerCat = loc.category.toLowerCase();
	                    for (const key in categoryColors) {
	                        if (lowerCat.includes(key)) {
	                            color = categoryColors[key];
	                            break;
	                        }
	                    }
	                }

	                const marker = new google.maps.Marker({
	                    position: { lat: loc.lat, lng: loc.lng },
	                    map: map,
	                    title: loc.title,
	                    visible: true,
	                    icon: {
	                        ...pinSymbol,
	                        fillColor: color
	                    }
	                });

	                marker.markerRegion = loc.region || "";
	                marker.markerCategory = loc.category || "";
	                marker.markerSubCategory = loc.subCategory || "";
	                marker.markerTags = loc.tags || ""; 
	                
	                marker.searchData = [
	                    loc.title,
	                    loc.category,
	                    loc.subCategory,
	                    loc.tags,
	                    loc.region,
	                    loc.content
	                ].join(' ').toLowerCase();

	                marker.addListener('click', function() {
	                    goView(loc.no);
	                });

	                allMarkers.push(marker);
	            }
	        });

	        filterMarkers();
	    }
	
	 // 6. 통합 필터 및 검색 처리 함수
	 function filterMarkers() {
		    const mapMessage = document.getElementById('map-message');
		    const searchInput = document.querySelector('input[name="t_search"]');
		    const keyword = searchInput ? searchInput.value.trim().toLowerCase() : "";
		    const selectedRegions = Array.from(
		        document.querySelectorAll('.region-check:checked')
		    ).map(cb => cb.value);
		    const selectedFoodSubs = Array.from(
		        document.querySelectorAll('.food-check:checked')
		    ).map(cb => cb.value);
		    const selectedOtherCats = Array.from(
		        document.querySelectorAll('.category-check:not(.food-check-all):checked')
		    ).map(cb => cb.value);
		    const hasRegionFilter = selectedRegions.length > 0;
		    const hasCategoryFilter =
		        selectedFoodSubs.length > 0 || selectedOtherCats.length > 0;
		    const hasKeyword = keyword.length > 0;
		
		    // 아무것도 선택하지 않은 최초 상태
		    if (!hasRegionFilter && !hasCategoryFilter && !hasKeyword) {
		        allMarkers.forEach(marker => marker.setVisible(false));
		        if (mapMessage) {
		            mapMessage.textContent =
		                "원하는 지역 또는 카테고리를 선택해 주세요.";
		            mapMessage.style.display = "block";
		        }
		        return;
		    }
		
		    // 필터가 하나라도 선택되면 안내문 숨김
		    if (mapMessage) {
		        mapMessage.style.display = "none";
		    }
		    allMarkers.forEach(marker => {
		        let show = true;

		        // 체크된 지역이 있을 때만 필터링
		        if (hasRegionFilter) {
		            const matchRegion = selectedRegions.some(
		                reg => marker.markerRegion.includes(reg)
		            );
		            if (!matchRegion) show = false;
		        }
		
		        // 체크된 카테고리가 있을 때만 필터링
		        if (hasCategoryFilter) {
		            let matchCategory = false;
		            if (
		                selectedFoodSubs.length > 0 &&
		                selectedFoodSubs.some(sub =>
		                    marker.markerSubCategory.includes(sub) ||
		                    marker.markerTags.includes(sub)
		                )
		            ) {
		                matchCategory = true;
		            }
		            if (
		                selectedOtherCats.length > 0 &&
		                selectedOtherCats.some(cat =>
		                    marker.markerCategory.includes(cat)
		                )
		            ) {
		                matchCategory = true;
		            }
		            if (!matchCategory) show = false;
		        }
		        if (hasKeyword) {
		            if (!marker.searchData.includes(keyword)) {
		                show = false;
		            }
		        }
		        marker.setVisible(show);
		    });
		}
	
	    function goSearch() {
	        filterMarkers();
	    }
	
	    // 7. 로그인 모달 제어 (기존 유지)
	    function openLoginModal(isPopState = false) {
	        const overlay = document.getElementById('modal-overlay');
	        const modalCard = document.getElementById('modal-card');
	
	        if (!overlay || !modalCard) return;
	
	        fetch('Member?ajax=true&t_gubun=login')
	            .then(response => {
	                if (!response.ok) throw new Error('페이지를 불러오지 못했습니다.');
	                return response.text();
	            })
	            .then(html => {
	                modalCard.innerHTML = html;
	                overlay.style.display = 'block';
	                modalCard.style.display = 'block';
	                
	                const loginInput = document.getElementById('login-id');
	                if (loginInput) loginInput.focus();
	
	                if (!isPopState) {
	                    history.pushState({ modal: 'login' }, "", "Member");
	                }
	            })
	            .catch(error => console.error('Error loading modal:', error));
	    }
	
	    function closeModal(isPopState = false) {
	        const overlay = document.getElementById('modal-overlay');
	        const modalCard = document.getElementById('modal-card');
	
	        if (overlay) overlay.style.display = 'none';
	        if (modalCard) modalCard.style.display = 'none';
	        
	        if (!isPopState) {
	            history.pushState(null, "", "Index");
	        }
	    }
	
	    // 8. DOM 로드 완료 후 파라미터 복원 및 상위 체크박스 동기화 (기존 유지)
	    window.addEventListener('DOMContentLoaded', function() {
	        const urlParams = new URLSearchParams(window.location.search);
	        
	        document.querySelectorAll('.sidebar-container input[type="checkbox"]').forEach(cb => cb.checked = false);
	
	        const regionsParam = urlParams.get('regions');
	        const categoriesParam = urlParams.get('categories');
	
	        if (regionsParam || categoriesParam) {
	            const regions = regionsParam ? regionsParam.split(',') : [];
	            const categories = categoriesParam ? categoriesParam.split(',') : [];
	
	            if (regions.length > 0) {
	                document.querySelectorAll('.region-check').forEach(cb => {
	                    if (regions.includes(cb.value)) cb.checked = true;
	                });
	                const subRegionList = document.getElementById('sub-region-list');
	                const regionArrow = document.querySelector('.regionArrow');
	                if (subRegionList) subRegionList.classList.add('open');
	                if (regionArrow) regionArrow.classList.add('open');
	            }
	
	            if (categories.length > 0) {
	                document.querySelectorAll('.food-check, .category-check:not(.food-check-all)').forEach(cb => {
	                    if (categories.includes(cb.value)) cb.checked = true;
	                });
	
	                const subCategoryList = document.getElementById('sub-category-list');
	                const categoryArrow = document.querySelector('.categoryArrow');
	                if (subCategoryList) subCategoryList.classList.add('open');
	                if (categoryArrow) categoryArrow.classList.add('open');
	
	                const foodChecked = document.querySelectorAll('.food-check:checked').length > 0;
	                if (foodChecked) {
	                    const subFoodList = document.getElementById('sub-food-list');
	                    const foodArrow = document.querySelector('.foodArrow');
	                    if (subFoodList) subFoodList.classList.add('open');
	                    if (foodArrow) foodArrow.classList.add('open');
	                }
	            }
	
	            updateRegionCheckState();
	            syncParentCheckboxes();
	        }
	
	        if (urlParams.get('login') === 'true') {
	            openLoginModal();
	        }
	
	        if (typeof filterMarkers === 'function') {
	            filterMarkers();
	        }
	        
	        if (window.location.search) {
	            window.history.replaceState({}, document.title, window.location.pathname);
	        }
	    });
	    
	    
	
	    document.addEventListener('keydown', function(e) {
	        if (e.key === 'Escape') closeModal();
	    });
	    
	    function goLogin() {
	        if (isEmpty(mem.t_id, "아이디를 입력하세요")) return;
	        if (isEmpty(mem.t_password, "비밀번호를 입력하세요")) return;
	        mem.t_gubun.value = "memberLogin";
	        mem.method = "post";
	        mem.action = "Member";
	        mem.submit();
	    }
	</script>
</body>
</html>