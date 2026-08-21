package command.recommend;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.CommonExecute;
import common.CommonUtil;
import dao.RecommendDao;
import dto.RecommendDto;

public class RecommendUpdate implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		RecommendDao dao = RecommendDao.getDao();
		String no = request.getParameter("t_no");
		String title = CommonUtil.getSingleQuot(request.getParameter("t_title"));
		String category = request.getParameter("t_category");
		String sub_category = request.getParameter("t_sub_category");
		String[] tagsArr = request.getParameterValues("t_tags");
		String tags = (tagsArr != null) ? String.join(",", tagsArr) : "";
		if (!"food".equals(category)) tags = null;

		String region = request.getParameter("t_region");
		String link = request.getParameter("t_link");
		String content = CommonUtil.getSingleQuot(request.getParameter("t_content"));
		String secret = request.getParameter("t_secret"); // 기본값 'Y'

		HttpSession session = request.getSession();
		String sessionLevel = (String) session.getAttribute("sessionLevel");

		String reqLat = request.getParameter("t_lat");
		String reqLng = request.getParameter("t_lng");
		Double lat = null; 
		Double lng = null;

		if ("top".equals(sessionLevel) 
		        && reqLat != null && !reqLat.trim().isEmpty() 
		        && reqLng != null && !reqLng.trim().isEmpty()) {
		    
		    try {
		        lat = Double.parseDouble(reqLat.trim());
		        lng = Double.parseDouble(reqLng.trim());
		        secret = "N";       
		        state = "complete"; 
		    } catch (NumberFormatException e) {
		        lat = null;
		        lng = null;
		    }
		}
		
		
        String update_date = CommonUtil.getTodayTime();
		
        RecommendDto dto = new RecommendDto(no, title, category, sub_category, tags, region, link, content, "attach", secret, state, "reg_id", "reg_name", "reg_date", update_date, 0, lat, lng);
        int result = dao.recommendUpdate(dto);
        
        String msg = (result == 1) ? "정상적으로 수정되었습니다" : "수정 실패하였습니다";
	
        request.setAttribute("t_msg", msg);
		request.setAttribute("t_url", "Recommend");
		request.setAttribute("t_gubun", "view");
		request.setAttribute("t_no", no);
	
	}

}
