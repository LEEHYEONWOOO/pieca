package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Recog;

public interface RecogMapper {
	String select = "select num,writer,recog_Status from recog";
	
    @Select({"<script>",
    	select,
   	"<if test='num != null'> where num = #{num}</if>",
   	"<if test='writer != null'> where writer = #{writer} </if>",
   	"<if test='recog_Status != null'> where recog_Status= #{recog_Status}</if>",
   	"</script>"})
	List<Recog> select(Map<String, Object> param);

    @Update("update recog set recog_Status = #{recog_Status}" 
            + " where num = #{num}")
	void update(Map<String, Object> param);
    
    @Delete("delete from recog where num = #{num}")
	void delete(Integer num);

	
}
