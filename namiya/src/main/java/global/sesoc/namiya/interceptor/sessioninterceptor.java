package global.sesoc.namiya.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class sessioninterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();//현재 세션가져오기
		
		String contextPath = request.getContextPath();
		String loginId = (String) session.getAttribute("loginId");
		String loginName = (String) session.getAttribute("loginName");
		
		String requestURI = request.getRequestURI();
		String uri = requestURI.substring(requestURI.lastIndexOf("/")+1);
		
		 if(loginId == null) {
			response.sendRedirect(contextPath + "/loginForm");  //로그인아이디 없으면 다시 로그인 화면으로

			return false;
		}else {
				return true;
			}
			
		}
}

