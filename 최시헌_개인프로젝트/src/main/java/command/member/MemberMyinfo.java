package command.member;

import javax.servlet.http.HttpServletRequest;

import common.CommonExecute;
import dao.MemberDao;
import dto.MemberDto;

public class MemberMyinfo implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		MemberDao dao = MemberDao.getDao();
//		HttpSession session = request.getSession();
//		String id = (String)session.getAttribute("sessionId");
		String id = (String)request.getSession().getAttribute("sessionId");
		
		MemberDto dto = dao.getMemberInfo(id);
		request.setAttribute("dto", dto);
		
	}

}
