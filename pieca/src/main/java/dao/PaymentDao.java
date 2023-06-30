package dao;

import java.util.HashMap;
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
	   System.out.println("이곳은 dao");
	   System.out.println(payment);
      template.getMapper(cls).insert(payment);
   }
   

}