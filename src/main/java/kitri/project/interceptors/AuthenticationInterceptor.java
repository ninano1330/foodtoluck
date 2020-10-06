package kitri.project.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthenticationInterceptor extends HandlerInterceptorAdapter {
	
	@Override //컨트롤러보다 먼저 수행되는 메서드
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
//		HttpSession session = request.getSession();
//		Object sessionId = session.getAttribute("sessionId");
//		
//		if(sessionId == null) {
//			return false;
//		}
		//response.
		
		String request_uri = request.getRequestURI();
		String queryString = request.getQueryString();
		String contextPath = request.getContextPath();
		
		System.out.println("request_uri = " + request_uri);
		System.out.println("querySting = " + queryString);
		System.out.println("contextPath = " + contextPath);
		
		request.setAttribute("needlogin", "needlogin");
		return false;
	}

	@Override //컨트롤러가 수행되고 화면이 보여지기 직전에 수행되는 메서드
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}

	
	
}
