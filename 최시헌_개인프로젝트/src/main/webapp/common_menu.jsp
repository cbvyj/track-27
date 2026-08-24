<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Track27 최시헌</title>
    <link href="css/sub.css" rel="stylesheet">
    <script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
</head>
<body>
    <form name="work" action="Member" method="post">
        <input type="hidden" name="t_gubun">
        <input type="hidden" name="t_nowPage">
        <input type="hidden" name="t_no">
        
    <script type="text/javascript">
        function goSearch() {
            document.work.t_nowPage.value = "1";
            document.work.t_gubun.value = "list";
            document.work.action = "Recommend";
            document.work.method = "post";
            document.work.submit();
        }        
    
        function goListPage(page) {
            document.work.t_nowPage.value = page;
            document.work.t_gubun.value = "list"; 
            document.work.action = "Recommend"; 
            document.work.method = "post";
            document.work.submit();
        }
        
        function goPage(gubun) {
            document.work.t_gubun.value = gubun;
            document.work.method = "post";
            document.work.action = "Member";
            document.work.submit();
        }
        
        function goRec(gubun) {
            document.work.t_gubun.value = gubun;
            document.work.method = "post";
            document.work.action = "Recommend"; 
            document.work.submit();
        }

        function goLogin() {
            if (isEmpty(mem.t_id, "아이디를 입력하세요")) return;
            if (isEmpty(mem.t_password, "비밀번호를 입력하세요")) return;
            mem.t_gubun.value = "memberLogin";
            mem.method = "post";
            mem.action = "Member";
            mem.submit();
        }

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

        // 체크박스 클릭 시 선택한 파라미터와 함께 Index 페이지로 이동
        function redirectToIndex() {
            const selectedRegions = Array.from(document.querySelectorAll('.region-check:checked')).map(cb => cb.value);
            const selectedFood = Array.from(document.querySelectorAll('.food-check:checked')).map(cb => cb.value);
            const selectedOther = Array.from(document.querySelectorAll('.category-check:not(.food-check-all):checked')).map(cb => cb.value);

            const allCategories = [...selectedFood, ...selectedOther];

            const params = new URLSearchParams();
            if (selectedRegions.length > 0) params.append('regions', selectedRegions.join(','));
            if (allCategories.length > 0) params.append('categories', allCategories.join(','));

            window.location.href = 'Index?' + params.toString();
        }

        window.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('login') === 'true') {
                openLoginModal();
            }

            const checkAll = document.getElementById('region-check-all');
            const regionChecks = document.querySelectorAll('.region-check');

            if (checkAll) {
                checkAll.addEventListener('change', function(e) {
                    regionChecks.forEach(cb => cb.checked = e.target.checked);
                    redirectToIndex();
                });
            }

            regionChecks.forEach(cb => {
                cb.addEventListener('change', function() {
                    const totalCount = regionChecks.length;
                    const checkedCount = document.querySelectorAll('.region-check:checked').length;
                    if (checkAll) checkAll.checked = (totalCount === checkedCount);
                    redirectToIndex();
                });
            });

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
                    redirectToIndex();
                });
            }

            if (foodCheckAll) {
                foodCheckAll.addEventListener('change', function() {
                    const isChecked = foodCheckAll.checked;
                    foodChecks.forEach(cb => cb.checked = isChecked);
                    checkCategoryAllState();
                    redirectToIndex();
                });
            }

            foodChecks.forEach(cb => {
                cb.addEventListener('change', function() {
                    const checkedCount = document.querySelectorAll('.food-check:checked').length;
                    if (foodCheckAll) foodCheckAll.checked = (checkedCount === foodChecks.length);
                    checkCategoryAllState();
                    redirectToIndex();
                });
            });

            otherCategoryChecks.forEach(cb => {
                cb.addEventListener('change', function() {
                    checkCategoryAllState();
                    redirectToIndex();
                });
            });

            function checkCategoryAllState() {
                if (!categoryCheckAll) return;
                const isFoodAllChecked = foodCheckAll ? foodCheckAll.checked : true;
                const otherCheckedCount = document.querySelectorAll('.category-check:not(.food-check-all):checked').length;
                const isOthersAllChecked = (otherCheckedCount === otherCategoryChecks.length);

                categoryCheckAll.checked = isFoodAllChecked && isOthersAllChecked;
            }
        });

        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') closeModal();
        });
    </script>

    <!-- 모달 오버레이 및 카드 -->
    <div id="modal-overlay" class="modal-overlay" onclick="closeModal()"></div>
    <div id="modal-card" class="modal-card"></div>

    <header>
        <div class="title"><a href="Index">穴場 一都三県</a></div>
        <div class="my">
            <c:if test="${not empty sessionName}">
                <span class="user-name">${sessionName}님</span>
                &nbsp;
                <a href="javascript:goPage('memberLogout')">Logout</a>
            </c:if>
            <c:if test="${empty sessionName}">
                <a href="Index?login=true">Login</a>
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
    </form>