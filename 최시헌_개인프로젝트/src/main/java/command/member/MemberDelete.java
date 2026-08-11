package command.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.CommonExecute;
import dao.MemberDao;

public class MemberDelete implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberDao dao = MemberDao.getDao();
		String id = (String)request.getSession().getAttribute("sessionId");
		
		int result = dao.memberDelete(id);
		if(result == 1) session.invalidate();
		
		String msg = result == 1? "탈퇴처리가 완료되었습니다. 지금까지 이용해주셔서 감사합니다.":"탈퇴 처리에 실패하였습니다. 관리자에게 문의바랍니다.";
		
		request.setAttribute("t_msg", msg);
		request.setAttribute("t_url", "Member");
		
	}	
}
