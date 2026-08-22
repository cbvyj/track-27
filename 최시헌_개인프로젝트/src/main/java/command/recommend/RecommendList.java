package command.recommend;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import common.CommonExecute;
import common.CommonUtil;
import dao.RecommendDao;
import dto.RecommendDto;

public class RecommendList implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		RecommendDao dao = RecommendDao.getDao();
		String search = request.getParameter("t_search");
		
		/* paging 설정 start*/
		int totalCount = dao.getTotalCount(search);
		int list_setup_count = 10;  //한페이지당 출력 행수 
		int pageNumber_count = 5;  //한페이지당 출력 페이지 갯수
		
		String nowPage = request.getParameter("t_nowPage");
		int current_page = 0; // 현재페이지 번호
		int total_page = 0;    // 전체 페이지 수
		
		if(nowPage == null || nowPage.equals("")) current_page = 1; 
		else current_page = Integer.parseInt(nowPage);
		
		total_page = totalCount / list_setup_count;  // 몫 : 2
		int rest = 	totalCount % list_setup_count;   // 나머지:1
		if(rest !=0) total_page = total_page + 1;     // 3
		
		int start = (current_page -1) * list_setup_count + 1;
		int end   = current_page * list_setup_count;
		/* paging 설정 end*/
		int order = totalCount - (start - 1); //
		
		List<RecommendDto> dtos = dao.getRecommendList(search, start, end);
		String pageDisplay = CommonUtil.getPageSetting(current_page, total_page, pageNumber_count);
		
		
		request.setAttribute("dtos", dtos);
		request.setAttribute("search", search);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("order", order);
		request.setAttribute("pageDisplay", pageDisplay);

		
	}

}
