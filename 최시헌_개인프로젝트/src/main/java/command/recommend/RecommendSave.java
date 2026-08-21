package command.recommend;

import java.io.File;
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
        
        // 1. 실제 파일이 저장될 attachDir 경로 가져오기 및 디렉터리 자동 생성
        String attachDir = CommonUtil.getRecommendDir(request);
        File dir = new File(attachDir);
        if (!dir.exists()) {
            dir.mkdirs(); // 디렉터리가 없으면 자동 생성
        }
        
        int maxSize = 1024 * 1024 * 50; // 50MB
        MultipartRequest mpr = null;

        try {
            mpr = new MultipartRequest(request, attachDir, maxSize, "utf-8", new DefaultFileRenamePolicy());
        } catch (IOException e) {
            System.out.println("RecommendSave 파일 업로드 오류");
            e.printStackTrace();
        }
        
        String no = dao.getRecNo();
        String title = mpr.getParameter("t_title");
        String category = mpr.getParameter("t_category");
        String sub_category = mpr.getParameter("t_sub_category");
        String[] tagsArr = mpr.getParameterValues("t_tags");
        String tags = (tagsArr != null) ? String.join(",", tagsArr) : "";
        if(!category.equals("food")) tags = null;
        String region = mpr.getParameter("t_region");
        String link = mpr.getParameter("t_link");
        String content = mpr.getParameter("t_content");
        
        // 다중 파일명 추출
        List<String> fileList = new ArrayList<>();
        Enumeration<?> files = mpr.getFileNames();
        
        while (files.hasMoreElements()) {
            String fileParamName = (String) files.nextElement();
            String filesystemName = mpr.getFilesystemName(fileParamName);
            
            if (filesystemName != null) {
                fileList.add(filesystemName);
            }
        }
        
        String attach = String.join(",", fileList);
        String secret = mpr.getParameter("t_secret");
        String state = "pending"; 
        String reg_id = (String) request.getSession().getAttribute("sessionId");
        String reg_name = (String) request.getSession().getAttribute("sessionName");
        String reg_date = CommonUtil.getTodayTime();
    
<<<<<<< HEAD
        RecommendDto dto = new RecommendDto(no, title, category, sub_category, tags, region, link, content, attach, secret, state, reg_id, reg_name, reg_date, null, 0,0,0);
=======
        RecommendDto dto = new RecommendDto(no, title, category, sub_category, tags, region, link, content, attach, secret, state, reg_id, reg_name, reg_date, null, 0, 0, 0);
>>>>>>> branch 'main' of https://github.com/cbvyj/track-27.git
        
        int result = dao.recommendSave(dto);
        
        String msg = (result == 1) ? "등록되었습니다" : "등록 실패하였습니다";
        
        request.setAttribute("t_msg", msg);
        request.setAttribute("t_url", "Recommend");
    }
}