package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

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

	// 게시글 번호
	public String getRecNo() {
	    String no = "";
	    String sql = "select max(no) as no\r\n"
	            + "from my_최시헌_rec";
	    try {
	        con = DBConnection.getConnection();
	        ps = con.prepareStatement(sql);
	        rs = ps.executeQuery();
	        if(rs.next()) {
	            String maxNo = rs.getString("no"); // 예: P2026-08-001
	            String todayYM = CommonUtil.getTodayYYMM(); // 예: 2026-08 (7자)
	            
	            if(maxNo == null) {
	                no = "P"+todayYM+"-001";
	            } else {
	                if(maxNo.length() >= 8 && maxNo.substring(1, 8).equals(todayYM)) {
	                    String n = maxNo.substring(9); // "001" 추출
	                    int newNo = Integer.parseInt(n) + 1 ; // 2
	                    DecimalFormat df = new DecimalFormat("000"); // 002
	                    no = "P"+todayYM+"-"+df.format(newNo); // P2026-08-002
	                } else {
	                    no = "P"+todayYM+"-001"; 
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

	// 게시글 저장
	public int recommendSave(RecommendDto dto) {
	    int result = 0;
	    String sql = "insert into my_최시헌_rec\r\n"
	            + "(no, title, category, sub_category, tags, region, link, content, attach, secret, state, reg_id, reg_name, reg_date)\r\n"
	            + "values\r\n"
	            + "(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	    try {
	        con = DBConnection.getConnection();
	        ps = new LogPreparedStatement(con, sql);
	        
	        ps.setString(1, dto.getNo());
	        ps.setNString(2, dto.getTitle());       
	        ps.setString(3, dto.getCategory());
	        ps.setString(4, dto.getSub_category());
	        ps.setString(5, dto.getTags());
	        ps.setString(6, dto.getRegion());
	        ps.setString(7, dto.getLink());
	        ps.setNString(8, dto.getContent());     
	        ps.setString(9, dto.getAttach());      
	        ps.setString(10, dto.getSecret());
	        ps.setString(11, dto.getState());
	        ps.setString(12, dto.getReg_id());
	        ps.setString(13, dto.getReg_name());
	        
	        LocalDateTime now = LocalDateTime.now();
	        Timestamp timestamp = Timestamp.valueOf(now);
	        ps.setTimestamp(14, timestamp);
	        
	        result = ps.executeUpdate();
	    } catch(Exception e) {
	        System.out.println("recommendSave() 오류:"+ps.toString());
	        e.printStackTrace();
	    } finally {
	        DBConnection.closeDB(con, ps, rs);
	    }
	    return result;
	}

	//게시판 목록
	public List<RecommendDto> getRecommendList() {
		List<RecommendDto> dtos = new ArrayList<RecommendDto>();
		String sql = "select no, title, category, secret, state, reg_id, reg_name, \r\n"
				+ "    to_char(reg_date, 'yyyy-MM-dd') as reg_date\r\n"
				+ "    from my_최시헌_rec\r\n"
				+ "    order by no desc";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				String no = rs.getString("no");
				String title = rs.getNString("title");
				String category = rs.getString("category");
				if(category.equals("food")) category = "음식";
				else if(category.equals("sights")) category = "관광";
				else if(category.equals("festival")) category = "마츠리/하나비";
				else if(category.equals("stay")) category = "숙소";
				String secret = rs.getString("secret");
				String state = rs.getString("state");
				String reg_id = rs.getString("reg_id");
				String reg_name = rs.getString("reg_name");
				String reg_date = rs.getString("reg_date");
				
				RecommendDto dto = new RecommendDto(no, title, category, "sub_category", "tags", "region", "link",
													"content", "attach", secret, state, reg_id, reg_name, reg_date, "update_date", 0,0,0);
				
				dtos.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("getRecommendList() 오류: "+ sql);
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return dtos;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
