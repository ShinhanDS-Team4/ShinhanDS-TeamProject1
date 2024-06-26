package com.team4.shoppingmall.admin;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminLoginChkFilter implements Filter {

	public void init(FilterConfig fConfig) throws ServletException {
        // TODO Auto-generated method stub
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse rep = (HttpServletResponse) response;
        HttpSession session = req.getSession();
        
        String uri = req.getRequestURI();
        
        // 필터를 적용하지 않을 URI들을 배열로 저장
        String[] excludeUris = { "admin_login", "admin_findid", "admin_findpw", "admin_changepw" };
        
        // 필터 적용 여부를 체크할 boolean 변수
        boolean shouldFilter = true;
        
        // excludeUris 배열에 현재 URI가 포함되어 있는지 확인
        for (String excludeUri : excludeUris) {
            if (uri.endsWith(excludeUri)) {
                shouldFilter = false;
                break;
            }
        }
        
        if (shouldFilter) {
            System.out.println("!!getRequestURI:" + uri);
            System.out.println("!!getQueryString:" + req.getQueryString());
            session.setAttribute("lastRequest", uri);
            session.setAttribute("queryRequest", req.getQueryString());
        
            AdminDTO aDto = (AdminDTO) session.getAttribute("aDto");
            if (aDto == null) {
                String path = req.getContextPath();
                rep.sendRedirect(path + "/admin/admin_login");
                return;
            }
        }
        
        // pass the request along the filter chain
        chain.doFilter(request, response);
    }

    public void destroy() {
        // TODO Auto-generated method stub

    }
    
//		if(!req.getRequestURI().endsWith("admin_login") && !req.getRequestURI().endsWith("admin_findid")) {
//			System.out.println("!!getRequestURI:" + req.getRequestURI());
//			System.out.println("!!getQueryString:" + req.getQueryString());	
//			session.setAttribute("lastRequest", req.getRequestURI());
//			session.setAttribute("queryRequest", req.getQueryString());
//		
//			AdminDTO aDto = (AdminDTO) session.getAttribute("aDto");
//			if (aDto == null) {
//				String path = req.getContextPath();
//				rep.sendRedirect(path + "/admin/admin_login");
//				return;
//			}
//		} else if(!req.getRequestURI().endsWith("admin_login") && !req.getRequestURI().endsWith("admin_findpw")) {
//			System.out.println("!!getRequestURI:" + req.getRequestURI());
//			System.out.println("!!getQueryString:" + req.getQueryString());	
//			session.setAttribute("lastRequest", req.getRequestURI());
//			session.setAttribute("queryRequest", req.getQueryString());
//		
//			AdminDTO aDto = (AdminDTO) session.getAttribute("aDto");
//			if (aDto == null) {
//				String path = req.getContextPath();
//				rep.sendRedirect(path + "/admin/admin_login");
//				return;
//		} else if(!req.getRequestURI().endsWith("admin_login") && !req.getRequestURI().endsWith("admin_changepw")) {
//			System.out.println("!!getRequestURI:" + req.getRequestURI());
//			System.out.println("!!getQueryString:" + req.getQueryString());	
//			session.setAttribute("lastRequest", req.getRequestURI());
//			session.setAttribute("queryRequest", req.getQueryString());
//		
//			AdminDTO aDto = (AdminDTO) session.getAttribute("aDto");
//			if (aDto == null) {
//				String path = req.getContextPath();
//				rep.sendRedirect(path + "/admin/admin_login");
//				return;
//		}
}
