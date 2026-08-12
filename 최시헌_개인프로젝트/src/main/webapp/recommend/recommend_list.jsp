<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "../common_menu.jsp" %>    
<link href="${pageContext.request.contextPath}/css/sub_rec.css" rel="stylesheet">    

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
                        <th class="col-num">번호</th>
                        <th class="col-title">제목</th>
                        <th class="col-author">작성자</th>
                        <th class="col-date">작성일</th>
                        <th class="col-status">처리상태</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>4</td>
                        <td class="title-cell">
                            <a href="recommend_view.html">이치카츠 아사쿠사바시점</a>
                            <span class="icon-secret">🔒</span>
                        </td>
                        <td>김태현</td>
                        <td>2026.07.28</td>
                        <td><span class="status-tag status-pending">검토중</span></td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td class="title-cell">
                            <a href="recommend_view.html">Mermaid Coffee Roasters Ikebukuro</a>
                            <span class="icon-secret">🔒</span>
                        </td>
                        <td>강선구</td>
                        <td>2026.07.25</td>
                        <td><span class="status-tag status-complete">등록완료</span></td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td class="title-cell">
                            <a href="recommend_view.html">KISSA 092</a>
                            <span class="icon-secret">🔒</span>
                        </td>
                        <td>임정규</td>
                        <td>2026.06.20</td>
                        <td><span class="status-tag status-complete">등록완료</span></td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td class="title-cell">
                            <a href="recommend_view.html">Lily's Cafe</a>
                            <span class="icon-secret">🔒</span>
                        </td>
                        <td>최시헌</td>
                        <td>2026.06.18</td>
                        <td><span class="status-tag status-complete">등록완료</span></td>
                    </tr>
                </tbody>
            </table>

            <!-- 하단 페이징 영역 -->
            <div class="board-pagination">
                <a href="#" class="page-btn">&laquo;</a>
                <a href="#" class="page-btn active">1</a>
                <a href="#" class="page-btn">2</a>
                <a href="#" class="page-btn">3</a>
                <a href="#" class="page-btn">&raquo;</a>
            </div>
        </div>
    </div>