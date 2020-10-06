package kitri.project.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class RequestInterceptor extends HandlerInterceptorAdapter{
	private static final Logger logger = LoggerFactory.getLogger(RequestInterceptor.class);
 
	//컨트롤러 수행 전
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
 
    // 로그인세션 체크하여 세션에 없으면 다른 페이지로 이동
    if (request.getSession().getAttribute("sessionId") == null) {
    	System.out.println(request.getContextPath());
    	response.sendRedirect("main");
        return false;
    }
    
    return true;
    }
 
	// 컨트롤러 수행 후
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) 
    throws Exception {
		
		super.postHandle(request, response, handler, modelAndView);
	}

	 //view 수행 후
	 @Override
	 public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
	 throws Exception {
		 super.afterCompletion(request, response, handler, ex);
	 }

}