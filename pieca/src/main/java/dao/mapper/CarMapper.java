package dao.mapper;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Car;

public interface CarMapper {

   @Select({"<script>",
           "select * from car where no IS NOT NULL",
           "<if test='maker != null'> and maker = #{maker}</if>",
             "<if test='car_size != null'> and car_size = #{car_size} </if>",
             "<if test='car_type != null'> and car_type = #{car_type} </if>",
             " order by no",
           "</script>"})
   List<Car> select(Map<String, Object> param); //namespace : dao.mapper.ItemMapper

   @Update("update car set no=#{no}, maker=#{maker}, name=#{name}, img=#{img}, imgcnt=#{imgcnt}, car_size=#{car_size}, car_type=#{car_type},release_year=#{release_year}, "
         + "min_price=#{min_price}, max_price=#{max_price}, min_range=#{min_range}, max_range=#{max_range}, avg_min_fuel=#{avg_min_fuel}, avg_max_fuel=#{avg_max_fuel}, "
         + "dt_min_fuel=#{dt_min_fuel}, dt_max_fuel=#{dt_max_fuel}, high_min_fuel=#{high_min_fuel}, high_max_fuel=#{high_max_fuel}, min_output=#{min_output}, "
         + "max_output=#{max_output}, min_output_motor=#{min_output_motor}, max_output_motor=#{max_output_motor}, min_torque=#{min_torque}, "
         + "max_torque=#{max_torque}, min_torque_motor=#{min_torque_motor}, max_torque_motor=#{max_torque_motor}, min_capacity=#{min_capacity}, "
         + "max_capacity=#{max_capacity}, overall_length=#{overall_length} "
         + "where no=#{no}")
   void carUpdate(Car car);

   @Delete("delete from car where no = #{no}")
   void carDelete(@Valid Car car);

   @Insert("insert into car (no, maker, name, img, imgcnt, car_size, car_type, release_year, min_price, max_price, min_range, max_range, avg_min_fuel, avg_max_fuel, dt_min_fuel, "
         + "dt_max_fuel, high_min_fuel, high_max_fuel, min_output, max_output, min_output_motor, max_output_motor, min_torque, max_torque, min_torque_motor, max_torque_motor, "
         + "min_capacity, max_capacity, overall_length) values (#{no}, #{maker}, #{name}, #{img}, #{imgcnt}, #{car_size}, #{car_type}, #{release_year}, #{min_price}, #{max_price}, #{min_range}, "
         + "#{max_range}, #{avg_min_fuel}, #{avg_max_fuel}, #{dt_min_fuel}, #{dt_max_fuel}, #{high_min_fuel}, #{high_max_fuel}, #{min_output}, #{max_output}, #{min_output_motor}, "
         + "#{max_output_motor}, #{min_torque}, #{max_torque}, #{min_torque_motor}, #{max_torque_motor}, #{min_capacity}, #{max_capacity}, #{overall_length})")
   void carInsert(@Valid Car car);

   
   
   
   
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