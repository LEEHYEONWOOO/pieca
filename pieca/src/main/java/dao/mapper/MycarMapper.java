package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Carlike;
import logic.Mycar;
import logic.User;

public interface MycarMapper {
/*
   @Select("select * from carlike where userid=#{userid} and carno=#{carno}")
   Carlike select(Carlike carlike);

   @Insert("insert into carlike (userid, carno) values (#{userid}, #{carno})")
   void insert(Carlike carlike);
   
   @Delete("delete from carlike where userid=#{userid} and carno=#{carno}")
   void delete(Carlike carlike);
   
   @Select("select count(carno) from carlike where carno=#{carno}")
   int selectliketotal(Carlike carlike);
   */
   
   @Select("select * from mycar where userid=#{userid}")
   Mycar select(String userid);
   
   @Insert("insert into mycar (userid, carno) values (#{userid}, 0)")
   void insert(String userid);
   
   @Delete("delete from mycar where userid=#{userid} and carno=#{carno}")
   void delete(Mycar mycar);

   @Update("update mycar set userid=#{userid},carno=#{carno} where userid=#{userid}")
   void update(Mycar mycar);
}