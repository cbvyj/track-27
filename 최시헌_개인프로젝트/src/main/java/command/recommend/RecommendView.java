package command.recommend;

import javax.servlet.http.HttpServletRequest;

import common.CommonExecute;
import dao.RecommendDao;
import dto.RecommendDto;


public class RecommendView implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		RecommendDao dao = RecommendDao.getDao();
		String no = request.getParameter("t_no");
		String gubun = request.getParameter("t_gubun"); 
		
		if(gubun.equals("view")) {
			int result = dao.setRecHit(no);
			if(result != 1) System.out.println("조회수 증가오류");
			
		}
		
		RecommendDto dto = dao.recommendView(no);
		request.setAttribute("dto", dto);
		
	}

}

