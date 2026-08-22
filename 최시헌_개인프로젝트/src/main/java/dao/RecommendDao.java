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
				String maxNo = rs.getString("no"); // P2026-08-015
				String todayYM = CommonUtil.getTodayYYMM(); // 26-08
				
				if(maxNo == null) {
					no = "P"+todayYM+"-001";
				} else {
					if(maxNo.substring(1,8).equals(todayYM)) {
						String n = maxNo.substring(9); // 015
						int newNo = Integer.parseInt(n) + 1 ; // 16
						DecimalFormat df = new DecimalFormat("000"); // 016
						no = "P"+todayYM+"-"+df.format(newNo); // P2026-08-016
					} else {
						no = "P"+todayYM+"-001"; // P2026-08-001
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
	public int setRecHit(String no) {
		int result = 0 ;
		String sql = "update my_최시헌_rec\r\n"
				+ "set hit = hit + 1\r\n"
				+ "where no = '"+no+"'";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(sql);
			result = ps.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("setRecHit() 오류: "+sql);
		} finally{
			DBConnection.closeDB(con, ps, rs);
		}
		return result;
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



	// 게시글 목록
	public List<RecommendDto> getRecommendList(String search, int start, int end) {
	    List<RecommendDto> dtos = new ArrayList<RecommendDto>(); 
	    if (search == null) search = "";
	    
	    // CASE문으로 DB의 영문 코드를 한글 변환하여 LIKE 검색 진행
	    String sql = "select *\r\n"
	            + "from(\r\n"
	            + "    select rownum as rnum, tbl.*\r\n"
	            + "    from(\r\n"
	            + "        select no, title, category, tags, secret, state, reg_id, reg_name, \r\n"
	            + "            to_char(reg_date, 'yyyy-MM-dd') as reg_date\r\n"
	            + "            from my_최시헌_rec\r\n"
	            + "            where title like ?\r\n"
	            + "            or NVL(content, ' ') like ?\r\n"
	            + "            or (case tags\r\n"
	            + "                    when 'casual' then '일반/캐주얼'\r\n"
	            + "                    when 'fine_dining' then '고급/파인다이닝'\r\n"
	            + "                    when 'view' then '뷰/야경/루프탑'\r\n"
	            + "                    when 'takeout' then '테이크아웃 전용'\r\n"
	            + "                    when 'reservation' then '예약필수/웨이팅'\r\n"
	            + "                    else tags end) like ?\r\n"
	            + "            or tags like ?\r\n" // 영문 코드(view, casual 등) 직접 검색 대비
	            + "            order by no desc\r\n"
	            + "        ) tbl\r\n"
	            + ") where rnum >= ? and rnum <= ?";
	    try {
	        con = DBConnection.getConnection();
	        ps = con.prepareStatement(sql);
	        
	        String keyword = "%" + search + "%";
	        ps.setString(1, keyword); // title
	        ps.setString(2, keyword); // content
	        ps.setString(3, keyword); // tags (한글 변환)
	        ps.setString(4, keyword); // tags (영문 코드)
	        ps.setInt(5, start);
	        ps.setInt(6, end);
	        
	        rs = ps.executeQuery();
	        while(rs.next()) {
	            String no = rs.getString("no");
	            String title = rs.getString("title");
	            
	            String category = rs.getString("category");
//	            if ("food".equals(category)) category = "음식";
//	            else if ("sights".equals(category)) category = "관광";
//	            else if ("festival".equals(category)) category = "마츠리/하나비";
//	            else if ("stay".equals(category)) category = "숙소";
	            
	            String tags = rs.getString("tags");
	            if ("casual".equals(tags)) tags = "일반/캐주얼";
	            else if ("fine_dining".equals(tags)) tags = "고급/파인다이닝";
	            else if ("view".equals(tags)) tags = "뷰/야경/루프탑";
	            else if ("takeout".equals(tags)) tags = "테이크아웃 전용";
	            else if ("reservation".equals(tags)) tags = "예약필수/웨이팅";
	            else if (tags == null) tags = "";
	            
	            String secret = rs.getString("secret");
	            String state = rs.getString("state");
	            String reg_id = rs.getString("reg_id");
	            String reg_name = rs.getString("reg_name");
	            String reg_date = rs.getString("reg_date");
	            
	            RecommendDto dto = new RecommendDto(no, title, category, "sub_category", tags, "region", "link", "content", 
	                                                "attach", secret, state, reg_id, reg_name, reg_date, "update_date", 0, 0, 0);
	            dtos.add(dto);
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	        System.out.println("getRecommendList() 오류: "+sql);
	    } finally {
	        DBConnection.closeDB(con, ps, rs);
	    }
	    return dtos;
	}

	// 게시글 건수(페이지 생성)
	public int getTotalCount(String search) {
	    int count = 0;
	    if (search == null) search = "";
	    
	    String sql = "select count(*) as count\r\n"
	            + "from my_최시헌_rec\r\n"
	            + "where title like ?\r\n"
	            + "or NVL(content, ' ') like ?\r\n"
	            + "or (case tags\r\n"
	            + "        when 'casual' then '일반/캐주얼'\r\n"
	            + "        when 'fine_dining' then '고급/파인다이닝'\r\n"
	            + "        when 'view' then '뷰/야경/루프탑'\r\n"
	            + "        when 'takeout' then '테이크아웃 전용'\r\n"
	            + "        when 'reservation' then '예약필수/웨이팅'\r\n"
	            + "        else tags end) like ?\r\n"
	            + "or tags like ?";
	    try {
	        con = DBConnection.getConnection();
	        ps = con.prepareStatement(sql);
	        
	        String keyword = "%" + search + "%";
	        ps.setString(1, keyword);
	        ps.setString(2, keyword);
	        ps.setString(3, keyword);
	        ps.setString(4, keyword);
	        
	        rs = ps.executeQuery();
	        if(rs.next()) {
	            count = rs.getInt("count");
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	        System.out.println("getTotalCount() 오류: "+sql);
	    } finally {
	        DBConnection.closeDB(con, ps, rs);
	    }
	    return count;
	}

	//게시글 상세정보
	public RecommendDto recommendView(String no) {
		RecommendDto dto = null;
		String sql="select r.no, r.title, r.hit, r.category, r.sub_category,  \r\n"
				+ "        r.tags, r.region, r.link, r.content, r.attach, r.secret,  \r\n"
				+ "        r.state, r.reg_id, r.reg_name,\r\n"
				+ "        to_char(r.reg_date, 'yyyy-MM-dd hh24:mi:ss') as reg_date,\r\n"
				+ "        to_char(r.update_date, 'yyyy-MM-dd hh24:mi:ss') as update_date\r\n"
				+ "from my_최시헌_rec r, my_최시헌_member m\r\n"
				+ "where r.reg_id = m.id\r\n"
				+ "and r.no = ?";
		
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, no);
			rs = ps.executeQuery();
			if(rs.next()) {
				String title = rs.getString("title");
				String category = rs.getString("category");
				String sub_category = rs.getString("sub_category");
				String tags = rs.getString("tags");
				if ("casual".equals(tags)) tags = "일반/캐주얼";
	            else if ("fine_dining".equals(tags)) tags = "고급/파인다이닝";
	            else if ("view".equals(tags)) tags = "뷰/야경/루프탑";
	            else if ("takeout".equals(tags)) tags = "테이크아웃 전용";
	            else if ("reservation".equals(tags)) tags = "예약필수/웨이팅";
	            else if (tags == null) tags = "";
				String region = rs.getString("region");
				String link = rs.getString("link");
				String content = rs.getString("content");
				String attach = rs.getString("attach");
				String secret = rs.getString("secret");
				String state = rs.getString("state");
				String reg_id = rs.getString("reg_id");
				String reg_name = rs.getString("reg_name");
				String reg_date = rs.getString("reg_date");
				String update_date = rs.getString("update_date");
				int hit = rs.getInt("hit");
				
				
				dto = new RecommendDto(no, title, category, sub_category, tags, region, link, content, attach, secret, state, reg_id, reg_name, reg_date, update_date, hit, 0, 0);
			}
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("recommendView() 오류: "+sql);
		} finally{
			DBConnection.closeDB(con, ps, rs);
		}
		return dto;
	}

	//게시글 수정
	public int recommendUpdate(RecommendDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
