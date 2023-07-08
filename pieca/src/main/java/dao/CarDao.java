package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.CarMapper;
import logic.Car;
import logic.Carlike;

@Repository // @Component + dao 기능(데이터베이스연결)
public class CarDao {
   
   @Autowired
   private SqlSessionTemplate template; //org.mybatis.spring.SqlSessionTemplate 객체 주입
   private Map<String, Object> param = new HashMap<>();
   private final Class<CarMapper> cls = CarMapper.class;

   public List<Car> list(Car car) {
	   param.clear();
	   param.put("maker",  car.getMaker());
	   param.put("car_size",  car.getCar_size());
	   param.put("car_type",  car.getCar_type());
	   System.out.println("이곳은 carDao"+car.getMaker()+"/"+car.getCar_size()+"/"+car.getCar_type());
      return template.getMapper(cls).select(param); //item 테이블의 전체 내용을 Item 객체의 목록 리턴 
   }





}