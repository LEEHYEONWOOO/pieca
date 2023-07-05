package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.CarlikeMapper;
import dao.mapper.MycarMapper;
import logic.Carlike;
import logic.Mycar;
import logic.User;
@Repository // @Component + dao 기능(데이터베이스연결)
public class MycarDao {
   
   @Autowired
   private SqlSessionTemplate template; //org.mybatis.spring.SqlSessionTemplate 객체 주입
   private Map<String, Object> param = new HashMap<>();
   private final Class<MycarMapper> cls = MycarMapper.class;
   
   /*
   public Carlike select(Carlike carlike) {
      return template.getMapper(cls).select(carlike);
   }

   public void insert(Carlike carlike) {
      template.getMapper(cls).insert(carlike);
   }

   public void delete(Carlike carlike) {
      template.getMapper(cls).delete(carlike);
      
   }


   public int selectliketotal(Carlike carlike) {
      return template.getMapper(cls).selectliketotal(carlike);
   }
*/
   public Mycar select(Mycar mycar) {
      return template.getMapper(cls).select(mycar);
   }

   public void insert(Mycar mycar) {
      template.getMapper(cls).insert(mycar);
      
   }

   public void delete(Mycar mycar) {
      template.getMapper(cls).delete(mycar);
   }

   public Mycar selectMycar(String userid) {
      param.clear();
      param.put("userid", userid);
      return template.selectOne("dao.mapper.UserMapper.select",param);
   }

   public void update(Mycar mycar) {
      template.getMapper(cls).update(mycar);
   }


}