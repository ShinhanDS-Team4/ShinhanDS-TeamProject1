package com.team4.shoppingmall.filter;

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

public class LoginFilter implements Filter {

    @Override
   public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse rep = (HttpServletResponse)response;
		HttpSession session = req.getSession();
		//이거 꼭 이렇게 해야하는 이유 여쭤보기


        String requestURI = req.getRequestURI();

        // ".do" 패턴이 포함된 요청에 대해서만 필터링
        if (requestURI.endsWith(".do") && !requestURI.endsWith("login.do") && !requestURI.endsWith("logout.do")) {
			System.out.println("쿼리 스트링!!!" + req.getQueryString());
			session.setAttribute("lastRequest", requestURI);
			//get방식이 적용된 원래 페이지로 돌아가게 할 수 있는 역할(getQueryString)	
			session.setAttribute("queryString", req.getQueryString());
        	System.out.println(requestURI);
            // 로그인 상태 확인 (예: 세션에 사용자 정보가 있는지 확인)
            Object user = req.getSession().getAttribute("member");
            
            
            if (user == null) {
                // 로그인이 안 되어 있으면 로그인 페이지로 리다이렉트
                rep.sendRedirect(req.getContextPath() + "/member_test/login.do");
                return;
            }
        }

        // 로그인이 되어 있으면 계속 진행
        chain.doFilter(request, response);
    }

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}
}