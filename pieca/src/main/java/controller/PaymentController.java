package controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import logic.Payment;
import logic.ShopService;
import logic.User;
import util.CipherUtil;

@Controller
@RequestMapping("payment")
public class PaymentController {
   @Autowired
   private Payment payment;
   
   @Autowired 
   private ShopService service;
   
   @Autowired
   private CipherUtil util;

   
   private String emailDecrypt(User user) {
      try {
         String key = util.makehash(user.getUserid(), "SHA-256");
         String email = "";
         email = util.decrypt(user.getEmail(), key);
         return email;
      } catch (Exception e) {
         e.printStackTrace();
      }
      return null;
   } 
   
   @RequestMapping("kakao")
   @ResponseBody
   public Map<String, Object> kakao(HttpSession session, HttpServletRequest request) {
      Map<String,Object> map = new HashMap<>();
      Random random = new Random();
      int randomNumber = random.nextInt(100000);// 0에서 99999 사이의 난수를 생성
      String randomNumberString = String.format("%05d", randomNumber);// 난수를 5자리로 자릅니다.
      Date date = new Date();
      SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddhhmmss");
      map.put("merchant_uid", simpleDateFormat.format(date)+randomNumberString);
      String amount = request.getParameter("amount");
      System.out.println(amount);
      
      User loginUser = (User)session.getAttribute("loginUser");
      System.out.println("kakao에서 본 loginUser는 : "+loginUser);
      //loginUser.getUserid()+"-"+session.getId()+
      //map.put("name", "테스트"; // 상품명
      map.put("amount", amount); // 주문 금액
      String email = emailDecrypt(loginUser);
      map.put("buyer_email", email); // 현재 사용 안함 복호화 필요
      map.put("buyer_name", loginUser.getUsername());
      map.put("buyer_tel", loginUser.getPhoneno());
      return map;
   }
   
   @RequestMapping("insertkakaopay")
   @ResponseBody
   public Boolean insertkakaopay(String orderno, String userid, String amount) {
      Date date = new Date();
      payment.setOrderno(orderno);
      payment.setUserid(userid);
      payment.setAmount(amount);
      payment.setRegdate(date);
      payment.setType("kakao");
      payment.setStatus("success");
      System.out.println("이곳은 inserkakaopay");
      System.out.println(payment);
      service.payInsert(payment);
      return true;
   }
   

}