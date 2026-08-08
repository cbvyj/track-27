package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.member.MemberLogin;
import command.member.MemberLogout;
import command.member.MemberMyinfo;
import command.member.MemberSave;

@WebServlet("/Member")
public class Member extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public Member() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        
        String gubun = request.getParameter("t_gubun");
        String ajax = request.getParameter("ajax");
        String viewPage = "";
        
        if (gubun == null) gubun = "login";
        request.setAttribute("gubun", gubun);
        
     // 1. 회원가입
        if ("memberSave".equals(gubun)) {
            MemberSave mem = new MemberSave();
            mem.execute(request);           
            viewPage = "common_alert.jsp";
        } 
        
        // 2. 로그인
        else if ("memberLogin".equals(gubun)) {
            MemberLogin mem = new MemberLogin();
            mem.execute(request);
            viewPage = "common_alert.jsp";
        }
        
        // 3. 로그아웃
        else if ("memberLogout".equals(gubun)) {
            MemberLogout mem = new MemberLogout();
            mem.execute(request);
            viewPage = "common_alert.jsp";
        }
        
        // 4. 내정보
        else if ("myinfo".equals(gubun)) {
        	MemberMyinfo mem = new MemberMyinfo();
        	mem.execute(request);
        	viewPage = "member/member_myinfo.jsp";
        }
        	
        
        // . Fetch 비동기 모달 요청 (로그인 폼 띄우기)
        else if ("true".equals(ajax)) {
            if ("login".equals(gubun)) {
                viewPage = "member/member_login.jsp";
            }
        } 
        // . 일반 페이지 전환 요청 (회원가입 폼)
        else if ("join".equals(gubun)) {
            viewPage = "member/member_join.jsp";
        } 
        // . 그 외 요청은 Index로 이동
        else {
            response.sendRedirect("Index");
            return;
        }
        
        if (!viewPage.equals("")) {
            RequestDispatcher rd = request.getRequestDispatcher(viewPage);
            rd.forward(request, response);
        }
    }
    

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // POST 요청도 doGet으로 수신
    }
}