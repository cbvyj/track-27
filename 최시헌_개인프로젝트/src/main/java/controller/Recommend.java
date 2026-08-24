package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.recommend.RecommendList;
import command.recommend.RecommendSave;
import command.recommend.RecommendUpdate;
import command.recommend.RecommendView;

/**
 * Servlet implementation class Recommend
 */
@WebServlet("/Recommend")
public class Recommend extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Recommend() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // 세션 체크 로직
        HttpSession session = request.getSession(false); // 기존 세션 가져오기 (없으면 null)
        String sessionName = (session != null) ? (String) session.getAttribute("sessionName") : null;
        
        // 마커 클릭 접속 여부 확인
        String from = request.getParameter("t_from");

        // 세션이 없거나 만료된 경우
        if (sessionName == null) {
            if (session != null) {
                session.invalidate(); // 남은 세션 정리
            }
            
            // 지도의 마커를 눌러서 바로 들어온 경우와 일반 접속 구분
            if ("map".equals(from)) {
                request.setAttribute("t_msg", "로그인 후 이용 가능합니다.");
            } else {
                request.setAttribute("t_msg", "세션정보가 만료되었습니다. 다시 로그인하세요.");
            }
            
            request.setAttribute("t_url", "Index");
                    
            RequestDispatcher rd = request.getRequestDispatcher("common_alert.jsp");
            rd.forward(request, response);
            return; // 아래 목록 및 상세보기 로직 실행 중단
        }
        
        String gubun = request.getParameter("t_gubun");
        String viewPage = "";
		
		
		if(gubun == null || gubun.equals("")) gubun = "list";
		request.setAttribute("gubun", "recommend");
		
		//목록
		if(gubun.equals("list")) {
			RecommendList rec = new RecommendList();
			rec.execute(request);
			viewPage="recommend/recommend_list.jsp";
		}	
		
		//게시글 작성 페이지
		else if(gubun.equals("write")) {
			viewPage="recommend/recommend_write.jsp";
		}
		
		//게시글 저장
		else if(gubun.equals("save")) {
			RecommendSave rec = new RecommendSave();
			rec.execute(request);
			viewPage="common_alert.jsp";
		}
		
		//게시글 상세보기
		else if(gubun.equals("view")) {
			RecommendView rec = new RecommendView();
			rec.execute(request);
			viewPage="recommend/recommend_view.jsp";
		}
		
		//게시글 상세보기
		else if(gubun.equals("updateForm")) {
			RecommendView rec = new RecommendView();
			rec.execute(request);
			viewPage="recommend/recommend_update.jsp";
		}
		
		//게시글 수정
		else if(gubun.equals("update")) {
			RecommendUpdate rec = new RecommendUpdate();
			rec.execute(request);
			viewPage="common_alert_view.jsp";
		}
		
		
		
		
		
		
		RequestDispatcher rd = request.getRequestDispatcher(viewPage);
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
