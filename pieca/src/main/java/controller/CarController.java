package controller;

import java.util.ArrayList;
import java.util.Arrays;
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
   
   @GetMapping("updateForm") // get,post 방식에 상관없이 호출
   public ModelAndView updateForm(int carno,HttpSession session) {
	   ModelAndView mav = new ModelAndView();
	   System.out.println(carno+"차량 정보 수정");
	   Car car = new Car();
	   List<Car> carList = service.carList(car);
	   for(int i=0; i<carList.size(); i++) {
		   if(carList.get(i).getNo()==carno) {
			   car = carList.get(i);
		   }
	   }
	   mav.addObject("car",car);
	   return mav;
   }
   
   @GetMapping("pictureForm")
   public ModelAndView pictureForm() {
	   ModelAndView mav = new ModelAndView();
	   return mav;
   }
   
   @GetMapping("insert") // get,post 방식에 상관없이 호출
   public ModelAndView getinsert(HttpSession session) {
	   ModelAndView mav = new ModelAndView();
	   Car car = new Car();
	   mav.addObject("car",car);
	   return mav;
   }
   @PostMapping("insert") // get,post 방식에 상관없이 호출
   public ModelAndView postinsert(@Valid Car car,BindingResult bresult, HttpSession session) {
	   ModelAndView mav = new ModelAndView();
	   if(bresult.hasErrors()) {
	         mav.getModel().putAll(bresult.getModel());
	         return mav;
	   }
	   Car carlist = new Car();
	   List<Car> cars = service.carList(carlist);
	   int max_no = cars.get(cars.size()-1).getNo()+1;
	   System.out.println(max_no + " = 최대 no");
	   car.setNo(max_no);
	   service.carInsert(car);
	   mav.setViewName("redirect:list");
	   return mav;
   }
   
   @PostMapping("updateForm") // get,post 방식에 상관없이 호출
   public ModelAndView update(@Valid Car car, BindingResult bresult, HttpSession session) {
	   ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			mav.addObject("carno",car.getNo());
			return mav;
		}
	   System.out.println(car+"차량 정보 수정 진행");
	   System.out.println(car);
	   service.carUpdate(car);
	   mav.setViewName("redirect:list");
	   return mav;
   }
   
   @PostMapping("delete") // get,post 방식에 상관없이 호출
   public ModelAndView delete(@Valid Car car, HttpSession session) {
	   ModelAndView mav = new ModelAndView();
	   System.out.println("차량 정보 삭제 진행");
	   System.out.println(car);
	   service.carDelete(car);
	   mav.setViewName("redirect:list");
	   return mav;
   }
   
   @RequestMapping("list") // get,post 방식에 상관없이 호출
   public ModelAndView list(String maker,String car_size,String car_type, HttpSession session) {
      // ModelAndView : Model + view
      // view에 전송할 데이터 + view 설정
      // view 설정이 안된 경우 : url 과 동일. item/list 뷰로 설정
      ModelAndView mav = new ModelAndView();
      System.out.println("초기 : "+maker+car_size+car_type);
      //String maker2; String car_size2; String car_type2;
      //if(maker != null) maker2 = maker.substring(1);
      //if(car_size != null) car_size2 = car_size.substring(1);
      //if(car_type != null) car_type2 = car_type.substring(1);
      if(maker==null || maker.equals("")) {
         maker = null;
      }
      if(car_size==null || car_size.equals("")) {
         car_size = null;
      }
      if(car_type==null || car_type.equals("")) {
         car_type = null;
      }
      
      Car car = new Car();
      car.setMaker(maker);
      car.setCar_size(car_size);
      car.setCar_type(car_type);
      List<Car> carList = service.carList(car);
      System.out.println(carList);
      Car car_all = new Car(); 
      List<Car> carList_all = service.carList(car_all);
      mav.addObject("carList_all",carList_all);
      List<Car> carList1 = new ArrayList<>();
      List<Car> carList2 = new ArrayList<>();
      for(int i=0; i<carList.size(); i++) {
         if(i%2 ==0) {
            carList1.add(carList.get(i));
         }else if(i%2 == 1) {
            carList2.add(carList.get(i));
         }
      }
      mav.addObject("carList1",carList1);
      mav.addObject("carList2",carList2);
      
      mav.addObject("maker_selected",maker);
      mav.addObject("car_size_selected",car_size);
      mav.addObject("car_type_selected",car_type);
      if(carList.size()==0) { // carList를 가져오지 못했을때,
      }else{
         //mav.addObject("maker_selected",maker.substring(1));
         //mav.addObject("car_size_selected",car_size.substring(1));
         //mav.addObject("car_type_selected",car_type.substring(1));
      }
      
      
      List<Car> makers = service.getMakers();
      List<Car> car_sizes = service.getSizes();
      List<Car> car_types = service.getTypes();
      
      mav.addObject("makers",makers);
      mav.addObject("car_sizes",car_sizes);
      mav.addObject("car_types",car_types);
      
      User loginUser = (User)session.getAttribute("loginUser");
      System.out.println(loginUser);
      
      //ㅎㅇ
      List<Carlike> liked_Total = service.carliketotal();
      mav.addObject("liked_Total", liked_Total);
      System.out.println("liked_Total : " + liked_Total);
      
      List<Carlike> rank5_Car = service.select_rank5();
      mav.addObject("rank5_Car", rank5_Car);
      System.out.println("rank5_Car : " +rank5_Car);
      System.out.println("없을때 : "+carList.size());
      
      
      //ㅎㅇ
      if (session.getAttribute("loginUser") != null) {
         Mycar dbUser = service.selectMycar(loginUser.getUserid());
         List<Carlike> liked_Car = service.selectUserlike(loginUser.getUserid());
            mav.addObject("liked_Car", liked_Car);
            System.out.println("liked_Car : "+liked_Car);
         List<Carlike> carLikeData = service.selectLike(loginUser.getUserid());
          //System.out.println("333 :: "+carLikeData);
         //System.out.println(dbUser);
         int maxnum = carList.size();
         mav.addObject("carList", carList); // 데이터 저장
         mav.addObject("dbUser", dbUser); // 데이터 저장
         mav.addObject("carLikeData", carLikeData); // 데이터 저장
         mav.addObject("maxnum", maxnum); // 데이터 저장
         Mycar mycar = service.selectMycar(loginUser.getUserid());
         mav.addObject("mycar",mycar);
         System.out.println(mycar+"이게 아이디값으로 검색한 mycar");
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