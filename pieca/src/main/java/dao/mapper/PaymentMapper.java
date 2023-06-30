package dao.mapper;

import org.apache.ibatis.annotations.Insert;

import logic.Payment;

public interface PaymentMapper {
   @Insert("insert into payment (orderno,userid,amount,"
         + " type,regdate,status) values " 
         + " (#{orderno},#{userid},#{amount},"
         + " #{type},#{regdate},#{status})")
   void insert(Payment payment);

}