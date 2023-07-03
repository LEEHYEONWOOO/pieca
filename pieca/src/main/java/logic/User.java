package logic;

import java.util.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Past;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class User {
   @Size(min=5,max=20,message="사용할 수 없는 아이디입니다.")
   private String userid;
   
   private String channel; // 네이버, 카카오 소셜로그인
   
   @Size(min=6,max=20,message="비밀번호는 8자이상 20자이하로 입력하세요")
   private String password;
   
   @NotEmpty(message="사용자이름은 필수 입니다.")
   private String username;
   //
   @Pattern(regexp="^\\d{3}\\d{3,4}\\d{4}$",message="양식에 맞게 입력 해주세요.")
   private String phoneno;
   
   @NotEmpty(message="email을 입력하세요.")
   @Email(message="email 형식으로 입력하세요.")
   private String email;
   
   private String card;
   
 //입력받은 형식을 format에 맞춰서 Date타입으로 변환   
   @Past(message="생일은 과거 날짜만 가능합니다.")
   @DateTimeFormat(pattern="yyyy-MM-dd")
   private Date birthday;
}