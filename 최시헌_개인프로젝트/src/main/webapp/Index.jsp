<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Track27 최시헌</title>
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
            <input type="text" class="search-box" placeholder="검색어를 입력하세요">
            &nbsp;
            <button type="button" class="search-button">🔍</button>
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
    </div>
    
    <!-- 모달 어두운 배경 오버레이 -->
    <div id="modal-overlay" class="modal-overlay" onclick="closeModal()"></div>

    <!-- 로그인 전용 모달 컨테이너 -->
    <div id="modal-card" class="modal-card"></div>

    <form name="work">
        <input type="hidden" name="t_gubun">
    </form>

    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB85lO0bCRzB3RXAGD1UTS7NK2VQLg8DeI&callback=initMap" async defer></script>
    <script type="text/javascript">
        // 페이지 이동 함수
        function goPage(gubun) {
            document.work.t_gubun.value = gubun;
            document.work.method = "post";
            document.work.action = "Member";
            document.work.submit();
        }

     // ==========================================
        // 1. 지역 및 카테고리 목록 열고 닫기 (화살표 전용)
        // ==========================================
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

        // ==========================================
        // 2. 지역별 필터 로직
        // ==========================================
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

        // ==========================================
        // 3. 카테고리별 필터 로직
        // ==========================================
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

        // ==========================================
        // 4. 구글 맵 초기화 함수
        // ==========================================
        function initMap() {
            const centerLatLng = { lat: 35.6895, lng: 139.6917 }; 
            const mapElement = document.getElementById('map');
            
            if (!mapElement) return;

            const map = new google.maps.Map(mapElement, {
                zoom: 10, 
                center: centerLatLng,
                mapTypeControl: false 
            });

            const locations = [
                { title: "도쿄 (Tokyo)", lat: 35.681317002098005, lng: 139.7663684224545 },
                { title: "사이타마 (Saitama)", lat: 35.86190692619087, lng: 139.6453769889718 },
                { title: "치바 (Chiba)", lat: 35.6074, lng: 140.1063 },
                { title: "가나가와 (Kanagawa)", lat: 35.4478, lng: 139.6425 }
            ];

            locations.forEach(loc => {
                new google.maps.Marker({
                    position: { lat: loc.lat, lng: loc.lng },
                    map: map,
                    title: loc.title
                });
            });
        }

     // 로그인 전용 비동기(Fetch) 모달 로직
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
                    
                    // [추가] 모달이 화면에 출력된 후 아이디 입력창에 자동 포커스
                    const loginInput = document.getElementById('login-id');
                    if (loginInput) {
                        loginInput.focus();
                    }

                    // 주소창에는 파라미터 없이 깔끔하게 'Member'만 노출
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
            
            // 모달을 닫으면 메인 주소인 Index로 복귀
            if (!isPopState) {
                history.pushState(null, "", "Index");
            }
        }

        // 뒤로가기/앞으로가기 및 초기 로드 처리
        window.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            
            if (urlParams.get('login') === 'true') {
                openLoginModal();
            }
        });

        // ESC 키 닫기
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