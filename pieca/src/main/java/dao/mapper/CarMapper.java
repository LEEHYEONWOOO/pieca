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
           "select * from car <if test='maker != null'>where maker=#{maker}</if> order by no",
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