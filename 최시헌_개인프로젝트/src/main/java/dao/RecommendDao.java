package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.time.LocalDateTime;

import common.CommonUtil;
import common.DBConnection;
import dto.RecommendDto;

public class RecommendDao {
	private RecommendDao(){}
	static RecommendDao dao = new RecommendDao();
	public static RecommendDao getDao() {
		return dao;
	}
	
	Connection		   con = null;
	PreparedStatement	ps = null;
	ResultSet	rs		   = null;

	//게시글 번호
	public String getRecNo() {
		String no = "";
		String sql = "select max(no) as no\r\n"
				+ "from my_최시헌_rec";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				String maxNo = rs.getString("no"); // P26-08-015
				String todayYM = CommonUtil.getTodayYYMM(); // 26-08
				
				if(maxNo == null) {
					no = "P"+todayYM+"-001";
				} else {
					if(maxNo.substring(1,6).equals(todayYM)) {
						String n = maxNo.substring(7); // 015
						int newNo = Integer.parseInt(n) + 1 ; // 16
						DecimalFormat df = new DecimalFormat("000"); // 016
						no = "P"+todayYM+"-"+df.format(newNo); // P26-08-016
					} else {
						no = "P"+todayYM+"-001"; // P26-08-001
					}
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("getRecNo() 오류: "+ sql);
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return no;	
	}

	//게시글 조회수
	public int setRecHit() {
		return 0;
	}

	//게시글 저장
	public int recommendSave(RecommendDto dto) {
		int result = 0;
		String sql = "insert into my_최시헌_rec\r\n"
				+ "(no, title, category, sub_category, tags, region, link, content, attach, secret, state, reg_id, reg_name, reg_date)\r\n"
				+ "values\r\n"
				+ "(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			con= DBConnection.getConnection();
			ps = new LogPreparedStatement(con, sql);
			
			ps.setString(1, dto.getNo());
			ps.setString(2, dto.getTitle());
			ps.setString(3, dto.getCategory());
			ps.setString(4, dto.getSub_category());
			ps.setString(5, dto.getTags());
			ps.setString(6, dto.getRegion());
			ps.setString(7, dto.getLink());
			ps.setString(8, dto.getContent());
			ps.setString(9, dto.getAttach());
			ps.setString(10, dto.getSecret());
			ps.setString(11, dto.getState());
			ps.setString(12, dto.getReg_id());
			ps.setString(13, dto.getReg_name());
			LocalDateTime now = LocalDateTime.now();
			Timestamp timestamp = Timestamp.valueOf(now);
			ps.setTimestamp(14,timestamp);
			
			result = ps.executeUpdate();
		} catch(Exception e) {
			System.out.println("recommendSave() 오류:"+ps.toString());
			e.printStackTrace();
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
