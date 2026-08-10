package command.member;

import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;

import common.CommonExecute;
import common.CommonUtil;
import dao.MemberDao;
import dto.MemberDto;

public class MemberUpdate implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		MemberDao dao = MemberDao.getDao();
		
		String name = request.getParameter("t_name");
		String id = request.getParameter("t_id");
		String email_1 = request.getParameter("t_email_1");
		String email_2 = request.getParameter("t_email_2");
		String phone_1 = request.getParameter("t_phone_1");
		String phone_2 = request.getParameter("t_phone_2");
		String phone_3 = request.getParameter("t_phone_3");
		String region = request.getParameter("t_region");
		String update_date = CommonUtil.getTodayTime();
		
		MemberDto dto = new MemberDto(name, id, "password", "password_length", 
								email_1, email_2, 
								phone_1, phone_2, phone_3, region,
								"reg_date", update_date, "exit_date");
		int result = dao.memberUpdate(dto);
		String msg = result == 1? name+"님의 정보가 수정되었습니다.":"정보 수정에 실패하였습니다.";
		
		request.setAttribute("t_msg", msg);
		request.setAttribute("t_url", "Member");
		request.setAttribute("t_gubun", "myinfo");
		request.setAttribute("t_id", id);

	}

}
