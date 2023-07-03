package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.PaymentMapper;
import logic.Payment;
@Repository
public class PaymentDao {
   
   @Autowired
   private SqlSessionTemplate template;
   private Map<String,Object> param = new HashMap<>();
    private Class<PaymentMapper> cls = PaymentMapper.class;
    
   public void insertkakao(Payment payment) {
      template.getMapper(cls).insert(payment);
   }

   public String getBalance(String userid) {
      param.clear();
      param.put("userid", userid);
      return template.getMapper(cls).selectBalance(userid);
   }

   public List<Payment> list(String userid) {
      return template.getMapper(cls).select(userid);
   }
   

}