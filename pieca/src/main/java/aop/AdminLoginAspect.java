package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import exception.LoginException;
import logic.User;

@Component
@Aspect
public class AdminLoginAspect {
	@Around("execution(* controller.AdminController.*(..)) && args(..,session)")
	public Object adminCheck(ProceedingJoinPoint joinPoint, HttpSession session) 
			throws Throwable {//AOP수정필요
		User loginUser = (User)session.getAttribute("loginUser");
		if(loginUser == null) {
			throw new LoginException("../user/login");
		}
		else if (!loginUser.getUserid().equals("admin")) {
			throw new LoginException
			("../user/mypage?userid="+loginUser.getUserid());
		}
		return joinPoint.proceed();
	}
}
