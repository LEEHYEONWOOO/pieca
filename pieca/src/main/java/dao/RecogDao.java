package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.RecogMapper;
import logic.Recog;

@Repository
public class RecogDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<>();
	private Class<RecogMapper> cls = RecogMapper.class;
	
	public List<Recog> getRecog(Integer num) {
		param.clear();
		param.put("num", num);
		return template.getMapper(cls).select(param);
	}
	public List<Recog> getRecog() {
		param.clear();
		return template.getMapper(cls).select(param);
	}
	
	public void doRecog(Integer num,int status) {
		param.clear();
		param.put("num", num);
		param.put("recog_Status", status);
		template.getMapper(cls).update(param);
	}
}
