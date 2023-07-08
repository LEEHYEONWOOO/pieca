package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Car;
import logic.Carlike;
import logic.User;

public interface CarMapper {

   @Select({"<script>",
           "select * from car where no IS NOT NULL",
           "<if test='maker != null'> and maker = #{maker}</if>",
          	"<if test='car_size != null'> and car_size = #{car_size} </if>",
          	"<if test='car_type != null'> and car_type = #{car_type} </if>",
          	" order by no",
           "</script>"})
   List<Car> select(Map<String, Object> param); //namespace : dao.mapper.ItemMapper

   
   
   
   
   //select : sql 문장의 이름
   /*
   @Select("select ifnull(max(id),0) from item")
   int maxId();
   
   @Insert("insert into item (id, name,price,description,pictureUrl)"
      + " values (#{id},#{name},#{price},#{description},#{pictureUrl})")
   void insert(Car car);
   
   @Update("update item set name=#{name}, price=#{price},"
      + " description=#{description}, pictureUrl=#{pictureUrl} where id=#{id}")
   void update(Car car);
   
   @Delete("delete from item where id=#{id}")
   void delete(Map<String, Object> param);
   */

}