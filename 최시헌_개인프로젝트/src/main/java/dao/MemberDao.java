package dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import common.DBConnection;
import dto.MemberDto;

public class MemberDao {
	
	private MemberDao(){}
	static MemberDao dao = new MemberDao();
	public static MemberDao getDao() {
		return dao;
	}
	
	Connection		   con = null;
	PreparedStatement	ps = null;
	ResultSet			rs = null;
	
	//회원 등록
		public int memberSave(MemberDto dto) {
			int result = 0;
			String sql = "insert into my_최시헌_member\r\n"
					+ "(name, id, password, password_length, \r\n"
					+ "email_1, email_2, \r\n"
					+ "phone_1, phone_2, phone_3, region,\r\n"
					+ "reg_date)\r\n"
					+ "values\r\n"
					+ "('"+dto.getName()+"','"+dto.getId()+"','"+dto.getPassword()+"','"+dto.getPassword_length()+"',\r\n"
					+ "'"+dto.getEmail_1()+"','"+dto.getEmail_2()+"',\r\n"
					+ "'"+dto.getPhone_1()+"','"+dto.getPhone_2()+"','"+dto.getPhone_3()+"','"+dto.getRegion()+"',\r\n"
					+ "to_date('"+dto.getReg_date()+"','yyyy-MM-dd hh24:mi:ss'))";
			try {
				con= DBConnection.getConnection();
				ps = con.prepareStatement(sql);
				result = ps.executeUpdate();
			} catch(Exception e) {
				System.out.println("memberSave()오류 : "+sql);
				e.printStackTrace();
			} finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return result;
			}
	
	//비밀번호 암호화
	   public String encryptSHA256(String value) throws NoSuchAlgorithmException{
			String encryptData ="";
			
			MessageDigest sha = MessageDigest.getInstance("SHA-256");
			sha.update(value.getBytes());
			
			byte[] digest = sha.digest();
			for (int i=0; i<digest.length; i++) {
			   encryptData += Integer.toHexString(digest[i] &0xFF).toUpperCase();
			}
			return encryptData;
	    }

	 //로그인  
	   public String getLoginName(String id, String password) {
		   String name ="";
		   String sql="select name \r\n"
		   		+ "from my_최시헌_member\r\n"
		   		+ "where id = '"+id+"'\r\n"
		   		+ "and password = '"+password+"'";
		   try {
			   con = DBConnection.getConnection();
			   ps = con.prepareStatement(sql);
			   rs= ps.executeQuery();
			   if(rs.next()) {
				   name = rs.getString("name");
			   }
		   } catch(Exception e) {
			   System.out.println("getLoginName() 오류 : "+sql);
			   e.printStackTrace();
		   } finally {
			   DBConnection.closeDB(con, ps, rs);
		   }
		   return name;
	   }

	 //회원정보
		public MemberDto getMemberInfo(String id) {
			MemberDto dto = null;
			String sql = "select name, id, password_length, \r\n"
					+ "				email_1, email_2, \r\n"
					+ "                phone_1, phone_2, phone_3, region,\r\n"
					+ "				to_char (reg_date, 'yyyy-MM-dd hh24:mi:ss') as reg_date\r\n"
					+ "from my_최시헌_member\r\n"
					+ "where id = ?";
			try {
				   con = DBConnection.getConnection();
				   ps = con.prepareStatement(sql);
				   ps.setString(1, id);
				   rs= ps.executeQuery();
				   if(rs.next()) {
					  String name = rs.getString("name");
					  //String id = rs.getString("id");
					  String password_length = rs.getString("password_length");
					  String email_1 = rs.getString("email_1");
					  String email_2 = rs.getString("email_2");
					  String phone_1 = rs.getString("phone_1");
					  String phone_2 = rs.getString("phone_2");
					  String phone_3 = rs.getString("phone_3");
					  String region = rs.getString("region");
					  if(region.equals("tokyo")) {
						  region = "도쿄";
					  } else if(region.equals("saitama")) {
						  region = "사이타마";
					  } else if(region.equals("chiba")) {
						  region = "치바";
					  } else if(region.equals("kanagawa")) {
						  region = "카나가와";
					  } else {
						  region ="";
					  }
					  String reg_date = rs.getString("reg_date");
					  
					  dto = new MemberDto(name, id, "password", password_length, email_1, email_2, phone_1, phone_2, phone_3, region, reg_date, "update_date", "exit_date");
				   }
			   } catch(Exception e) {
				   System.out.println("getLoginName() 오류 : "+sql);
				   e.printStackTrace();
			   } finally {
				   DBConnection.closeDB(con, ps, rs);
			   }
			
			return dto;
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
