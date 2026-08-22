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
                        <li><label>▶ <input type="checkbox" class="region-check"> 도쿄</label></li>
                        <li><label>▶ <input type="checkbox" class="region-check"> 사이타마</label></li>
                        <li><label>▶ <input type="checkbox" class="region-check"> 치바</label></li>
                        <li><label>▶ <input type="checkbox" class="region-check"> 카나가와</label></li>
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
                                <li><label>▶ <input type="checkbox" class="food-check"> 식당</label></li>
                                <li><label>▶ <input type="checkbox" class="food-check"> 이자카야</label></li>
                                <li><label>▶ <input type="checkbox" class="food-check"> 테이크아웃</label></li>
                                <li><label>▶ <input type="checkbox" class="food-check"> 카페 & 바</label></li>
                            </ul>
                        </li>
                        <li><label>▶ <input type="checkbox" class="category-check"> 관광</label></li>
                        <li><label>▶ <input type="checkbox" class="category-check"> 마츠리/하나비</label></li>
                        <li><label>▶ <input type="checkbox" class="category-check"> 숙소</label></li>
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
        document.work.method = "post";
        document.work.action = "Recommend";
        document.work.submit();
    }

    // 1. 지역 및 카테고리 토글
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

    // 2. 지역별 필터
    const checkAll = document.getElementById('region-check-all');
    const regionChecks = document.querySelectorAll('.region-check');

    if (checkAll) {
        checkAll.addEventListener('change', function(e) {
            regionChecks.forEach(cb => cb.checked = e.target.checked);
        });
    }

    regionChecks.forEach(cb => {
        cb.addEventListener('change', function() {
            const totalCount = regionChecks.length;
            const checkedCount = document.querySelectorAll('.region-check:checked').length;
            if (checkAll) checkAll.checked = (totalCount === checkedCount);
        });
    });

    // 3. 카테고리별 필터
    const categoryCheckAll = document.getElementById('category-check-all');
    const foodCheckAll = document.querySelector('.food-check-all');
    const foodChecks = document.querySelectorAll('.food-check');
    const otherCategoryChecks = document.querySelectorAll('.category-check:not(.food-check-all)');

    if (categoryCheckAll) {
        categoryCheckAll.addEventListener('change', function() {
            const isChecked = categoryCheckAll.checked;
            if (foodCheckAll) foodCheckAll.checked = isChecked;
            foodChecks.forEach(cb => cb.checked = isChecked);
            otherCategoryChecks.forEach(cb => cb.checked = isChecked);
        });
    }

    if (foodCheckAll) {
        foodCheckAll.addEventListener('change', function() {
            const isChecked = foodCheckAll.checked;
            foodChecks.forEach(cb => cb.checked = isChecked);
            checkCategoryAllState();
        });
    }

    foodChecks.forEach(cb => {
        cb.addEventListener('change', function() {
            const checkedCount = document.querySelectorAll('.food-check:checked').length;
            if (foodCheckAll) foodCheckAll.checked = (checkedCount === foodChecks.length);
            checkCategoryAllState();
        });
    });

    otherCategoryChecks.forEach(cb => {
        cb.addEventListener('change', function() {
            checkCategoryAllState();
        });
    });

    function checkCategoryAllState() {
        if (!categoryCheckAll) return;
        const isFoodAllChecked = foodCheckAll ? foodCheckAll.checked : true;
        const otherCheckedCount = document.querySelectorAll('.category-check:not(.food-check-all):checked').length;
        const isOthersAllChecked = (otherCheckedCount === otherCategoryChecks.length);

        categoryCheckAll.checked = isFoodAllChecked && isOthersAllChecked;
    }

    // 4. 구글 맵 초기화 및 SVG 마커 생성
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

     // 1. 마커 스케일 및 테두리 선 두께 강화 (배경 분리 효과)
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
                    title: "${dto.getTitle()}", 
                    category: "${dto.getCategory()}",
                    subCategory: "${dto.getSub_category()}",
                    tags: "${dto.getTags()}",
                    region: "${dto.getRegion()}",
                    content: "${dto.getContent()}",
                    lat: parseFloat("${dto.getLat()}"), 
                    lng: parseFloat("${dto.getLng()}") 
                }${!status.last ? ',' : ''}
            </c:forEach>
        ];

        allMarkers = [];

        locations.forEach(loc => {
            if (!isNaN(loc.lat) && !isNaN(loc.lng) && loc.lat !== 0 && loc.lng !== 0) {
                
                // 카테고리 색상 결정 (키워드 부분 일치 검사)
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
                    icon: {
                        ...pinSymbol,
                        fillColor: color
                    }
                });

                // 통합 검색용 텍스트 데이터 바인딩 (제목, 카테고리, 태그, 지역, 내용 전체 결합)
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
    }

    // 로그인 모달 제어
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

    window.addEventListener('DOMContentLoaded', function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('login') === 'true') {
            openLoginModal();
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
    
    // 클라이언트 통합 검색 함수
    function goSearch() {
        const searchInput = document.querySelector('input[name="t_search"]');
        const keyword = searchInput ? searchInput.value.trim().toLowerCase() : "";

        allMarkers.forEach(marker => {
            if (keyword === "") {
                marker.setVisible(true);
                return;
            }

            if (marker.searchData && marker.searchData.includes(keyword)) {
                marker.setVisible(true);
            } else {
                marker.setVisible(false);
            }
        });
    }
</script>
</body>
</html>