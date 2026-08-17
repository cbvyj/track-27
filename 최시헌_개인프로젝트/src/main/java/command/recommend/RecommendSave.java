package command.recommend;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.CommonExecute;
import common.CommonUtil;
import dao.RecommendDao;
import dto.RecommendDto;

public class RecommendSave implements CommonExecute {

    @Override
    public void execute(HttpServletRequest request) {
        RecommendDao dao = RecommendDao.getDao();
        
        String attachDir = CommonUtil.getRecommendDir(request);
        int maxSize = 1024 * 1024 * 50; // 50MB
        MultipartRequest mpr = null;

        try {
            mpr = new MultipartRequest(request, attachDir, maxSize, "utf-8", new DefaultFileRenamePolicy());
        } catch (IOException e) {
            System.out.println("RecommendSave 오류");
            e.printStackTrace();
        }
        
        String no = dao.getRecNo();
        String title = CommonUtil.getSingleQuot(mpr.getParameter("t_title"));
        String category = mpr.getParameter("t_category");
        String sub_category = mpr.getParameter("t_category_sub");
        String[] tagsArr = mpr.getParameterValues("t_tags");
        String tags = (tagsArr != null) ? String.join(",", tagsArr) : "";
        String region = mpr.getParameter("t_region");
        String link = mpr.getParameter("t_link");
        String content = CommonUtil.getSingleQuot(mpr.getParameter("t_content"));
        
        // 다중 파일명 추출 및 쉼표(,)로 연결 처리
        List<String> fileList = new ArrayList<>();
        Enumeration<?> files = mpr.getFileNames(); // 전송된 모든 파일 파라미터 추출
        
        while (files.hasMoreElements()) {
            String fileParamName = (String) files.nextElement();
            String filesystemName = mpr.getFilesystemName(fileParamName);
            
            // 실제 파일이 존재하는 경우 리스트에 추가
            if (filesystemName != null) {
                fileList.add(filesystemName);
            }
        }
        
        // 여러 파일명을 "img1.jpg,img2.jpg,img3.jpg" 형태로 결합
        String attach = String.join(",", fileList);
        String secret = mpr.getParameter("t_secret"); // JSP hidden 값 'Y'
        String state = "pending"; 
        String reg_id = (String) request.getSession().getAttribute("sessionId");
        String reg_name = (String) request.getSession().getAttribute("sessionName");
        String reg_date = CommonUtil.getTodayTime();
    
        RecommendDto dto = new RecommendDto(no, title, category, sub_category, tags, region, link, content, attach, secret, state, reg_id, reg_name, reg_date, null, 0,0,0);
        
        int result = dao.recommendSave(dto);
        
        String msg = (result == 1) ? "등록되었습니다" : "등록 실패하였습니다";
        
        request.setAttribute("t_msg", msg);
        request.setAttribute("t_url", "Recommend");
    }
}