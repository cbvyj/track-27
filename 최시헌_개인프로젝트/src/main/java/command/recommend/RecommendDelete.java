package command.recommend;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import common.CommonExecute;
import common.CommonUtil;
import dao.RecommendDao;

public class RecommendDelete implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		RecommendDao dao = RecommendDao.getDao();
		String no = request.getParameter("t_no");
		String delAttach = request.getParameter("t_attach");
		
		int result = dao.recommendDelete(no);
		if(result == 1 && delAttach != null && !delAttach.trim().isEmpty()) {
            File file = new File(CommonUtil.getRecommendDir(request), delAttach);
            boolean tf = file.delete();
            if(!tf) System.out.println("추천장소 첨부파일 삭제 오류");
        }
		
		String msg = result == 1? "정상적으로 삭제 되었습니다.":"삭제 실패하였습니다. 관리자에게 문의하세요.";
		request.setAttribute("t_msg", msg);
		request.setAttribute("t_url", "Recommend");
	}

}
