package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;
import dao.CarDao;
import logic.Car;
import logic.Carlike;
import logic.Mycar;
import logic.Payment;
import logic.ShopService;
import logic.User;
import util.CipherUtil;

@Controller // @Component + Controller 기능
@RequestMapping("car") // http://localhost:8080/shop1/item/*
public class CarController {
   @Autowired // ShopService 객체 주입.
   private ShopService service;
   @Autowired
   private Carlike carlike;
   @Autowired
   private Mycar mycar;
   @RequestMapping("list") // get,post 방식에 상관없이 호출
   public ModelAndView list(HttpSession session) {
      // ModelAndView : Model + view
      // view에 전송할 데이터 + view 설정
      // view 설정이 안된 경우 : url 과 동일. item/list 뷰로 설정
      ModelAndView mav = new ModelAndView();

      // itemList : item 테이블의 모든 정보를 Item 객체 List로 저장
      List<Car> carList = service.carList();
      User loginUser = (User)session.getAttribute("loginUser");
      
      if (session.getAttribute("loginUser") != null) {
         Mycar dbUser = service.selectMycar(loginUser.getUserid());
         
         //ㅎㅇ
         List<Carlike> liked_Car = service.selectUserlike(loginUser.getUserid());
   	  	 mav.addObject("liked_Car", liked_Car);
   	  	 System.out.println("liked_Car : "+liked_Car);
   	  	 List<Carlike> liked_Total = service.carliketotal();
   	  	 mav.addObject("liked_Total", liked_Total);
   	  	 System.out.println("liked_Total : " + liked_Total);
         //
            
          List<Carlike> carLikeData = service.selectLike(loginUser.getUserid());
          //System.out.println("333 :: "+carLikeData);
         //System.out.println(dbUser);
         int maxnum = carList.size();
         mav.addObject("carList", carList); // 데이터 저장
         mav.addObject("dbUser", dbUser); // 데이터 저장
         mav.addObject("carLikeData", carLikeData); // 데이터 저장
         mav.addObject("maxnum", maxnum); // 데이터 저장

         
         return mav;
      } else {
         int maxnum = carList.size();
         mav.addObject("carList", carList); // 데이터 저장
         mav.addObject("maxnum", maxnum); // 데이터 저장
         return mav;
      }
   }

   @RequestMapping("carlike") //좋아요 추가/삭제
   @ResponseBody
   public Boolean carlike(int carno, String userid) {
      carlike.setCarno(carno);
      carlike.setUserid(userid);
      Boolean check = true;

      Carlike dbUser = service.selectUserlike(carlike);
      if (dbUser == null) {
         service.likeInsert(carlike);
         check = false;
         return check;
      }

      if ((dbUser.getUserid().equals(userid)) && (dbUser.getCarno() == carno)) {
         service.likeDelete(carlike);
         check = true;
         return check;
      }

      return check;
   }
   
   @RequestMapping("carlikedec") // 좋아요 판단
   @ResponseBody
   public Boolean carlikedec(int carno, String userid) {
      carlike.setCarno(carno);
      carlike.setUserid(userid);
      Boolean check = null;

      Carlike dbUser = service.selectUserlike(carlike);
      if (dbUser == null) {
         check = false;
         return check;
      } else {
         check = true;
         return check;
      }
   }
   
   @RequestMapping("carliketotal")
   @ResponseBody
   public int carliketotal(int carno) {
      carlike.setCarno(carno);
      
      int total = service.selectliketotal(carlike);
      return total;
   }
   
   @RequestMapping("mycar")
   @ResponseBody
   public int mycar(int carno, String userid) {
      mycar.setUserid(userid);
      mycar.setCarno(carno);
      Mycar dbUser = service.selectMycar(userid);
      
      if (dbUser.getUserid().equals(userid)) {
         service.mycarUpdate(mycar);
         return carno;
      }
      
      return 0;
   }
   
   @RequestMapping("mycardec")
   @ResponseBody
   public int mycardec(int carno, String userid) {
      mycar.setUserid(userid);
      mycar.setCarno(carno);
      Mycar dbUser = service.selectMycar(userid);
      //System.out.println("dbUser mycardec ::" + dbUser.getCarno());
      
      if (dbUser.getUserid().equals(userid)) {
         return dbUser.getCarno();
      }
      
      return 0;
   }
   /*
    * //http://localhost:8080/shop1/item/detail?id=1
    * 
    * @GetMapping({"detail","update","delete"}) public ModelAndView detail(Integer
    * id) { //id = id 파라미터의 값. //매개변수 이름과 같은 이름의 파라미터값을 자동으로 저장함. ModelAndView mav
    * = new ModelAndView(); Item item = service.getItem(id);
    * mav.addObject("item",item); return mav; }
    * 
    * @GetMapping("create") //Get 방식 요청 public ModelAndView create() { ModelAndView
    * mav = new ModelAndView(); mav.addObject(new Item()); return mav; }
    * 
    * @PostMapping("create") //Post 방식 요청 public ModelAndView register(@Valid Item
    * item, BindingResult bresult, HttpServletRequest request ) { // request : 요청객체
    * 주입. //item의 프로퍼티와 파라미터값을 비교하여 같은 이름의 값을 item객체에 저장 //@Valid :item 객체에 입력된 내용을
    * 유효성 검사함 => bresult 검사 결과 저장 ModelAndView mav = new
    * ModelAndView("item/create"); //view이름 설정 if(bresult.hasErrors()) { //@Valid
    * 프로세스에 의해서 입력 데이터 오류가 있는 경우 System.out.println
    * (bresult.getFieldError("price")); mav.getModel().putAll(bresult.getModel());
    * return mav; //item객체 + 에러메세지 } service.itemCreate(item,request); //db추가,
    * 이미지업로드 mav.setViewName("redirect:list"); //list 요청 return mav; } /*
    * 
    * @GetMapping("update") public ModelAndView update(Integer id) { ModelAndView
    * mav = new ModelAndView(); Item item = service.getItem(id);
    * mav.addObject("item",item); return mav; }
    */
   /*
    * 1. 입력값 유효성 검증 2. db의 내용 수정. 파일 업로드 3. update 완료 후 list 요청
    */
   /*
    * @PostMapping("update") public ModelAndView update(@Valid Item item,
    * BindingResult bresult, HttpServletRequest request ) { ModelAndView mav = new
    * ModelAndView(); if(bresult.hasErrors()) {
    * mav.getModel().putAll(bresult.getModel()); return mav; }
    * service.itemUpdate(item,request); mav.setViewName("redirect:list"); return
    * mav; }
    * 
    * @PostMapping("delete") public String delete(Integer id) {
    * service.itemDelete(id); return "redirect:list"; }
    */
}