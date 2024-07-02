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
		
		if(!req.getRequestURI().endsWith("admin_login")) {
			System.out.println("!!getRequestURI:" + req.getRequestURI());
			System.out.println("!!getQueryString:" + req.getQueryString());	
			session.setAttribute("lastRequest", req.getRequestURI());
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
}
