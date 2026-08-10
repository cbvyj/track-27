package command.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.CommonExecute;
import dao.MemberDao;

public class MemberMyinfoPw implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		try {
            HttpSession session = request.getSession();
            String id = (String) session.getAttribute("sessionId");
            String password = request.getParameter("t_password");

            MemberDao dao = MemberDao.getDao();
            boolean isMatched = dao.checkPassword(id, password);

            // Ajax 응답으로 text 반환 (true / false)
            request.setAttribute("t_result", isMatched ? "true" : "false");
        } catch (Exception e) {
            e.printStackTrace();
        }
	}

}
