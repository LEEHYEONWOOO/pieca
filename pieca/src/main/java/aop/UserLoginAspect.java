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
public class UserLoginAspect {
	
@Around
("execution(* controller.User*.idCheck*(..)) && args(..,userid,session)")
	public Object userIdCheck(ProceedingJoinPoint joinPoint,String userid,
			HttpSession session) throws Throwable {
	//System.out.println(userid);
	   User loginUser = (User)session.getAttribute("loginUser");	
	   if(loginUser == null) {
		   throw new LoginException("login");
	   }
	   return joinPoint.proceed();	
	}
	//UserController.loginCheck*(..,HttpSession) => pointcut

	@Around
("execution(* controller.User*.loginCheck*(..)) && args(..,session)")
	public Object loginCheck(ProceedingJoinPoint joinPoint,
			HttpSession session) throws Throwable {
		System.out.println("@@@user login aop@@@");
	   User loginUser = (User)session.getAttribute("loginUser");	
	   if(loginUser == null) {
		   throw new LoginException("login");
	   }
	   return joinPoint.proceed();	
	}
	
	@Around
	("execution(* controller.Board*.login*(..))&& args(..,session)")
	public Object boardLoginCheck(ProceedingJoinPoint joinPoint,
			HttpSession session) throws Throwable {
		System.out.println("@@@Board login aop@@@");
	   User loginUser = (User)session.getAttribute("loginUser");	
	   if(loginUser == null) {
		   throw new LoginException("../user/login");
	   }
	   return joinPoint.proceed();	
	}
	
	
}
