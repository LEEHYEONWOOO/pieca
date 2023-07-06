package logic;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Component
@RequiredArgsConstructor
@Setter
@Getter
@ToString
public class Carlike {
   private String userid;
   private int carno;
   private int cnt;

}