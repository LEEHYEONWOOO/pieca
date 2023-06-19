package controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
import logic.ShopService;
import logic.User;
import util.CipherUtil;

@Controller
@RequestMapping("user")
public class UserController {
	@Autowired 
	private ShopService service;
	@Autowired
	private CipherUtil util;
//================= private  메서드
	private String passwordHash(String password) {
		try {
			return util.makehash(password,"SHA-512");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return null;
	}
	private String emailEncrypt(String email, String userid) {
		try {
			String key = util.makehash(userid, "SHA-256");
			return util.encrypt(email,key); //이메일 암호화
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	private String emailDecrypt(User user) {
		try {
			String key = util.makehash(user.getUserid(), "SHA-256");
			String email = util.decrypt(user.getEmail(),key);
			return email;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//================= private  메서드
	
	@GetMapping("*")  //설정되지 않은 모든 요청시 호출되는 메서드
	public ModelAndView join() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		return mav;
	}
	
	@PostMapping("join") //회원가입
	public ModelAndView userAdd(@Valid User user, BindingResult bresult) {
		ModelAndView mav = new ModelAndView();
		System.out.println(user.getUserid());
		System.out.println(user.getPassword());
		System.out.println(user.getUsername());
		System.out.println(user.getPhoneno());
		System.out.println(user.getEmail());
		System.out.println(user.getBirthday());
		
		if(bresult.hasErrors()) {
			System.out.println("도착1");
			mav.getModel().putAll(bresult.getModel());
			System.out.println("도착2");
			//reject 메서드 : global error에 추가
			bresult.reject("error.input.user");
			System.out.println("도착3");
			bresult.reject("error.input.check");
			System.out.println("도착4");
			return mav;
		}
		//정상 입력값 : 회원 가입 하기 => db의 usersecurity 테이블에 저장
		System.out.println("정상임!!");
		try {
			/*
			 * password : SHA-512 해쉬값 변경
			 * email    : AES 알고리즘으로 암호화 
			 */
			user.setPassword(passwordHash(user.getPassword()));
			user.setEmail(emailEncrypt(user.getEmail(),user.getUserid()));
			service.userInsert(user); //db에 insert
			mav.addObject("user",user);
		}catch(DataIntegrityViolationException e) {
	//DataIntegrityViolationException : db에서 중복 key 오류시 발생되는 예외 객체
			e.printStackTrace();
			bresult.reject("error.duplicate.user"); //global 오류 등록
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		mav.setViewName("redirect:login");
		return mav;
	}
	
	@PostMapping("login")
	public ModelAndView login(@Valid User user, BindingResult bresult,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.login.input");
			return mav;
		}
		//1. userid 맞는 User를 db에서 조회하기
		User dbUser = service.selectUserOne(user.getUserid());
		if (dbUser == null) {//조회된 데이터가 없는 경우
			bresult.reject("error.login.id"); //아이디를 확인하세요 
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		//2. 비밀번호 검증  
		//   일치 : session.setAttribute("loginUser",dbUser) => 로그인 정보
		//   불일치 : 비밀번호를 확인하세요. 출력 (error.login.password)
		//3. mypage로 페이지 이동 => 404 오류 발생 (임시)
		// dbUser.getPassword() : SHA-512 해쉬값으로 저장.
		// user.getPassword() : 입력받은 데이터. => SHA-512 해쉬값으로 변경 필요. 비밀번호 비교
//		String password = passwordHash(user.getPassword());
		if(passwordHash(user.getPassword()).equals(dbUser.getPassword())) { //정상 로그인
			session.setAttribute("loginUser", dbUser);
			mav.setViewName("redirect:../main/home");
		}else {  
			bresult.reject("error.login.password");
			mav.getModel().putAll(bresult.getModel());
		}		
		return mav;
	}
	/*
	 * AOP 설정하기 : 
	 *   UserLoginAspect 클래스의 userIdCheck 메서드로 구현하기.
	 * 1.pointcut : UserController 클래스의 idCheck로 시작하는 메서드이고, 
	 *              마지막 매개변수의 userid,session인 경우 
	 * 2. 로그인 여부 검증
	 *   - 로그인이 안된경우 로그인 후 거래하세요. 메세지 출력. login페이지 호출
	 * 3. admin이 아니면서, 로그인 아이디와 파라미터 userid값이 다른 경우
	 *   - 본인만 거래 가능합니다. 메세지 출력. item/list 페이지 호출              
	 */
	@RequestMapping("mypage")
	public ModelAndView idCheckMypage(String userid,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		System.out.println(userid);
		User user = service.selectUserOne(userid);
		user.setEmail(emailDecrypt(user));  //이메일 복호화
		mav.addObject("user", user); //회원정보데이터
		return mav;
	}	
	//로그아웃 컨트롤러 구현하기.
	//로그아웃 후 login 페이지로 이동
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:../main/home";
	}
	//로그인 상태, 본인정보만 조회 검증 => AOP 클래스(UserLoginAspect.userIdCheck() 검증)
	@GetMapping({"update","delete"})
	public ModelAndView idCheckUser(String userid,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.selectUserOne(userid);
		user.setEmail(emailDecrypt(user));  //이메일 복호화
		mav.addObject("user",user);
		return mav;
	}
	@PostMapping("update")
	public ModelAndView idCheckUpdate(@Valid User user,BindingResult bresult,String userid,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		//입력값 검증
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.update.user");
			return mav;
		}
		//비밀번호 검증
		User loginUser = (User)session.getAttribute("loginUser");
		if(!loginUser.getPassword().equals(this.passwordHash(user.getPassword()))) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.login.password");
			return mav;
		}
		//비밀번호 일치 => 데이터 수정
		try {
			user.setEmail(this.emailEncrypt(user.getEmail(), user.getUserid()));
			user.setPassword(passwordHash(user.getPassword()));
			service.userUpdate(user);
			if(loginUser.getUserid().equals(user.getUserid())) 			   
			   session.setAttribute("loginUser", user);
			mav.setViewName("redirect:mypage?userid="+user.getUserid());
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException
			("update?userid="+user.getUserid());
		}
		return mav;
	}
	/* 탈퇴 검증
	 * UserLoginAspect.userIdCheck() 메서드 실행 하도록 설정
	 *
	 * 회원탈퇴 
	 * 1.파라미터 정보 저장. (userid, password)
	 *   - 관리자인 경우 탈퇴 불가
	 * 2.비밀번호 검증 => 로그인된 비밀번호 검증 
	 *   본인탈퇴 : 본인 비밀번호 
	 *   관리자가 타인 탈퇴 : 관리자 비밀번호
	 * 3.비밀번호 불일치 
	 *   메세지 출력 후 delete 페이지 이동  
	 * 4.비밀번호 일치
	 *   db에서 해당 사용자정보 삭제하기
	 *   본인탈퇴 : 로그아웃, login 페이지 이동
	 *   관리자탈퇴 : admin/list 페이지 이동 => 404 오류 발생 
	 */
	
	@PostMapping("delete")
	public String  idCheckdelete
	       (String password, String userid,HttpSession session) {
		// 관리자 탈퇴 불가
		if(userid.equals("admin"))
			throw new LoginException
			         ("mypage?userid="+userid);
		//비밀번호 검증 : 로그인된 정보
		User loginUser = (User)session.getAttribute("loginUser");
		//password : 입력된 비밀번호
		//loginUser.getPassword() : 로그인 사용자의 비밀번호
		if(!password.equals(loginUser.getPassword())) {
			throw new LoginException
			     ("delete?userid="+userid);
		}
		//비밀번호 일치 : 고객정보 제거
		try {
			service.userDelete(userid);
		} catch(DataIntegrityViolationException e) {
			throw new LoginException
			("mypage?userid="+userid);
		} catch(Exception e) {
			e.printStackTrace();
			throw new LoginException("delete?userid="+userid);
		}
		//탈퇴 성공 : 회원정보를 제거 된 상태
		if(loginUser.getUserid().equals("admin")) {  //관리자가 강제 탈퇴
			return "redirect:../admin/list";
		} else {           //본인 탈퇴. 
			session.invalidate();
			return "redirect:login";
		}	
	}
	/*
	 * UserLoginAspect.loginCheck() : UserController.loginCheck*(..) 인 메서드
	 *                                 마지막 매개변수 HttpSession인 메서드
	 * 1. 로그인 검증  => AOP 클래스. 
	 * 2. 파라미터값 저장 (매개변수이용)
	 * 3. 현재비밀번호와 입력된 비밀번호 검증
	 *    불일치 : 오류 메세지 출력. password 페이지 이동
	 * 4. 일치 : db 수정
	 * 5. 성공 : 로그인정보 변경, mypage 페이지 이동
	 *    실패 : 오류 메세지 출력. password 페이지 이동   
	 */	
	@PostMapping("password") 
	public String loginCheckPasswordRtn
	     (String password,String chgpass,HttpSession session) {
		//비밀번호 검증
		
		User loginUser = (User)session.getAttribute("loginUser");
		//password : 현재비밀번호
		//loginUser.getPassword() : 로그인된 비밀번호
		
		if(!passwordHash(password).equals(loginUser.getPassword())) {
		  throw new LoginException("password");
		}
		try {
			service.userChgpass(loginUser.getUserid(),passwordHash(chgpass));
			loginUser.setPassword(chgpass); //로그인 정보에 비밀번호 수정
			session.invalidate();
		} catch(Exception e) {
			  throw new LoginException("password");
		}
		return "redirect:../main/home";
	}
	
	@RequestMapping("pwCheck")
	@ResponseBody
	public Boolean pwCheck(String userid, String password,HttpSession session) {
		//System.out.println("여기왔음!!!!");
		User dbUser = service.selectUserOne(userid);
		//System.out.println("입력한 패스워드::"+password);
		//System.out.println("loginUser.getPassword()::"+loginUser.getPassword());
		Boolean check = false;
			
	if(dbUser != null) {
		if(passwordHash(password).equals(dbUser.getPassword())) {
			check = true;
		}
	}
		return check;
	}
	
	// {url}search : {url} 지정되지 않음. *search 인 요청시 호출되는 메서드
	@PostMapping("{url}search")
	public ModelAndView search(User user, BindingResult bresult, @PathVariable String url) {
		//@PathVariable : {url} 의 이름을 매개변수로 전달.
		//   요청 : idsearch : url <= "id"
		//   요청 : pwsearch : url <= "pw"
		ModelAndView mav = new ModelAndView();
		String code = "error.userid.search";
		String title = "아이디";
		if(url.equals("pw")) { //비밀번호 검증인 경우
			title = "비밀번호 초기화";
			code = "error.password.search";
			if(user.getUserid() == null || user.getUserid().trim().equals("")) {
				//BindingResult.reject() : global error 
				//    => jsp의 <spring:hasBindErrors ... 부분에 오류출력 
				//BindingResult.rejectValue() : 
				//   => jsp의 <form:errors path= ...  부분에 오류출력 
				bresult.rejectValue("userid", "error.required"); //error.required.userid 오류코드 
			}
		}
		if(user.getEmail() == null || user.getEmail().trim().equals("")) {
			bresult.rejectValue("email", "error.required"); //error.required.email 오류코드 
		}
		if(user.getPhoneno() == null || user.getPhoneno().trim().equals("")) {
			bresult.rejectValue("phoneno", "error.required"); //error.required.phoneno  오류코드
		}
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		//입력검증 정상완료.
		if(user.getUserid() != null && user.getUserid().trim().equals(""))
			user.setUserid(null);
		/*                                         result
		 * user.getUserid() == null : 아이디찾기 =>  아이디값 저장
		 * user.getUserid() != null : 비밀번호찾기 => 비밀번호값 저장
		 */
		String result = null;
		if(user.getUserid() == null) { //아이디 찾기
			//전화번호 기준으로 회원목록 조회 => 이메일로는 검증 안됨
			List<User> list =service.getUserlist(user.getPhoneno());
			System.out.println(list);
			for(User u : list) {
				//u 객체의 email 정보 : 암호화상태
				//emailDecrypt(u) : 이메일 복호화
				System.out.println("email:"+this.emailDecrypt(u));				
				u.setEmail(this.emailDecrypt(u)); //복호화된 이메일로 저장 => 입력된 이메일과 비교
				//u.getEmail() : db에 저장된 이메일을 복호화한 데이터
				//user.getEmail() : 입력된 이메일 데이터
				if(u.getEmail().equals(user.getEmail())) { //검색 성공. 복호화된 이메일로 비교.
					result = u.getUserid();
				}
			}
		} else {  //비밀번호 찾기(초기화)
			//이메일 암호화
			user.setEmail(this.emailEncrypt(user.getEmail(), user.getUserid()));
			result =  service.getSearch(user); //mybatis 구현시 해당 레코드가 없는 경우 결과값이 null임
            									//결과값이 없는 경우 예외발생 없음
			if(result != null) { //비밀번호 검색 성공 => 초기화. db에 비밀번호를 변경.
				String pass=null;
				try {
					pass = util.makehash(user.getUserid(),"SHA-512");
				} catch (NoSuchAlgorithmException e) {
					e.printStackTrace();
				}
				//pass : 아이디의 SHA-512로 계산한 해쉬값
				int index = (int)(Math.random()*(pass.length()-10)); //비밀번호 해쉬값 일부분 
				result = pass.substring(index,index+6); //pass값의 임의의 위치에서 6자리값 랜덤 선택
				//비밀번호 변경 => 비밀번호 초기화
				service.userChgpass(user.getUserid(),passwordHash(result));
			}
		}		
		if(result == null) { //아이디 또는 비밀번호 검색 실패.
			bresult.reject(code);
		    mav.getModel().putAll(bresult.getModel());
		    return mav;
  	    }
		System.out.println("result=" + result);
		mav.addObject("result",result);
		mav.addObject("title",title);
		mav.setViewName("search");
		return mav;
	}
}