package common;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

public class CommonUtil {

	//작은따옴표 변환
	public static String getSingleQuot(String str) {
		str = str.replaceAll("'", "&#39;");
		return str;
	}
	
	// 큰따옴표 변환
	public static String getDoubleQuot(String str){
		str = str.replaceAll("\"", "&quot;");
		return str;
	}
	
	//게시판 첨부파일 경로
	public static String getRecommendDir(HttpServletRequest request){
		String dir = request.getSession().getServletContext().getRealPath("/")+"attach/recommend";
		return dir;
	}
	
	// null을 공백으로
	public static String getCheckNull(String str) {
		String result ="";
		if(str != null) result = str;
		return result;
	}	
	
	// 오늘날짜  yyyy-MM-dd
	public static String getToday(){
		Date date = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		
		String today = sd.format(date);
		return today;
	}
	
	// 오늘날짜  yyyy-MM
		public static String getTodayYYMM(){
			Date date = new Date();
			SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM");
			
			String today = sd.format(date);
			return today;
		}
	
	// 오늘날짜 시분초 yyyy-MM-dd HH:mm:ss
	public static String getTodayTime(){
		Date date = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		String today = sd.format(date);
		return today;
	}	
	
	// 페이지 설정
    public static String getPageSetting(int current_page, int total_page, int pageNumber_count){
        int pagenumber = pageNumber_count;   // 한 화면의 페이지 인덱스 수
        int startpage;     // 시작 페이지 번호
        int endpage;       // 마지막 페이지 번호
        int curpage;       // 이동할 페이지 번호
        
        String strList = ""; 

        // 시작 페이지 번호 구하기
        startpage = ((current_page - 1) / pagenumber) * pagenumber + 1;
        // 마지막 페이지 번호 구하기
        endpage = (((startpage - 1) + pagenumber) / pagenumber) * pagenumber;
        
        if(total_page <= endpage) endpage = total_page;
                    
        // 이전 페이지 그룹 (<< 버튼)
        if(current_page > pagenumber){
            curpage = startpage - 1;
            strList += "<a href=\"javascript:goListPage('" + curpage + "')\" class='page-btn'>&laquo;</a>";
        }
                        
        // 페이지 번호 생성
        curpage = startpage;
        while(curpage <= endpage){
            if(curpage == current_page){
                // 현재 활성화된 페이지
                strList += "<a class='page-btn active'>" + curpage + "</a>";
            } else {
                // 클릭 가능한 페이지
                strList += "<a href=\"javascript:goListPage('" + curpage + "')\" class='page-btn'>" + curpage + "</a>";
            }
            curpage++;
        }
        
        // 다음 페이지 그룹 (>> 버튼)
        if(total_page > endpage){
            curpage = endpage + 1;
            strList += "<a href=\"javascript:goListPage('" + curpage + "')\" class='page-btn'>&raquo;</a>";
        }
        
        return strList;
    }           
}
	
	





