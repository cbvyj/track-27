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
		
		// 세션 체크 로직 추가
		HttpSession session = request.getSession(false); // 기존 세션 가져오기 (없으면 null)
		String sessionName = (session != null) ? (String) session.getAttribute("sessionName") : null;

		// 세션이 없거나 만료된 경우 alert 후 Index로 이동
		if (sessionName == null) {
			if (session != null) {
				session.invalidate(); // 남은 세션 정리
			}
			
			request.setAttribute("t_msg", "세션정보가 만료되었습니다. 다시 로그인하세요.");
			request.setAttribute("t_url", "Index");
					
			RequestDispatcher rd = request.getRequestDispatcher("common_alert.jsp");
			rd.forward(request, response);
			return; // 아래 목록 조회 로직 실행 중단
		}
		
		String gubun = request.getParameter("t_gubun");
		String viewPage ="";
		
		
		if(gubun == null) gubun = "list";
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
