package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Car;
import logic.Carlike;
import logic.User;

public interface CarlikeMapper {

   @Select("select * from carlike where userid=#{userid} and carno=#{carno}")
   Carlike select(Carlike carlike);

   @Insert("insert into carlike (userid, carno) values (#{userid}, #{carno})")
   void insert(Carlike carlike);
   
   @Delete("delete from carlike where userid=#{userid} and carno=#{carno}")
   void delete(Carlike carlike);
   
   @Select("select count(carno) from carlike where carno=#{carno}")
   int selectliketotal(Carlike carlike);
   
   @Select("SELECT carno, COUNT(userid) AS cnt FROM carlike GROUP BY carno;")
   List<Carlike> selectliketotal2();
   
   @Select("SELECT carno, COUNT(userid) AS cnt FROM carlike GROUP BY carno ORDER BY cnt DESC LIMIT 5;")
   List<Carlike> select_rank5();

   @Select({"<script>",
        "select * from carlike <if test='id != null'>where userid=#{userid}</if>",
        "</script>"})
   List<Carlike> selectLike(String userid);
   
   @Select({"<script>",
       "select maker from car GROUP BY maker",
       "</script>"})
   List<Car> getMakers();
   
   @Select({"<script>",
       "select car_size from car GROUP BY car_size",
       "</script>"})
   List<Car> getSizes();
   
   @Select({"<script>",
       "select car_type from car GROUP BY car_type",
       "</script>"})
   List<Car> getTypes();
   


}