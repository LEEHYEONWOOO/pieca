package dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Payment;

public interface PaymentMapper {
   @Insert("insert into payment (orderno,userid,amount,"
         + " type,regdate,status) values " 
         + " (#{orderno},#{userid},#{amount},"
         + " #{type},now(),#{status})")
   void insert(Payment payment);
   
   @Select("select sum(amount) from payment where userid =#{userid}")
   String selectBalance(String userid);
   
   @Select({"<script>",
        "select * from payment <if test='id != null'>where userid=#{userid}</if> order by regdate",
        "</script>"})
   List<Payment> select(String userid);

}