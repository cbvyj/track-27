package command.member;

import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;

import common.CommonExecute;
import common.CommonUtil;
import dao.MemberDao;
import dto.MemberDto;

public class MemberSave implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		MemberDao dao = MemberDao.getDao();
		
		String name = request.getParameter("t_name");
		String id = request.getParameter("t_id");
		String password = request.getParameter("t_password");
		String password_length = Integer.toString(password.length()); 
		try {
			password = dao.encryptSHA256(password);	
		} catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		String email_1 = request.getParameter("t_email_1");
		String email_2 = request.getParameter("t_email_2");
		String phone_1 = request.getParameter("t_phone_1");
		String phone_2 = request.getParameter("t_phone_2");
		String phone_3 = request.getParameter("t_phone_3");
		String region = request.getParameter("t_region");
		String reg_date = CommonUtil.getTodayTime();
		
		MemberDto dto = new MemberDto(name, id, password, password_length, 
								email_1, email_2, 
								phone_1, phone_2, phone_3, region,
								reg_date, "update_date", "exit_date");
		int result = dao.memberSave(dto);
		String msg = result == 1? name+"님 회원가입 되었습니다.":"회원가입 실패하였습니다.";
		
		request.setAttribute("t_msg", msg);
		request.setAttribute("t_url", "Member");

	}

}
