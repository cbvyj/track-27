package command.recommend;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import common.CommonExecute;
import dao.RecommendDao;
import dto.RecommendDto;

public class RecommendList implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		RecommendDao dao = RecommendDao.getDao();
		
		List<RecommendDto> dtos = dao.getRecommendList();
		request.setAttribute("dtos", dtos);
		
		
		
		
	}

}
