package logic;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Component
@RequiredArgsConstructor
@Getter
@Setter
@ToString
public class Payment {
	
   private String orderno;
   private String userid;
   private String amount;
   private String type;
   private Date regdate;
   private String status;
   
   /*
public String getOrderno() {
	return orderno;
}
public void setOrderno(String orderno) {
	this.orderno = orderno;
}
public String getUserid() {
	return userid;
}
public void setUserid(String userid) {
	this.userid = userid;
}
public String getAmount() {
	return amount;
}
public void setAmount(String amount) {
	this.amount = amount;
}
public String getType() {
	return type;
}
public void setType(String type) {
	this.type = type;
}
public Date getRegdate() {
	return regdate;
}
public void setRegdate(Date regdate) {
	this.regdate = regdate;
}
public String getStatus() {
	return status;
}
public void setStatus(String status) {
	this.status = status;
}
@Override
public String toString() {
	return "Payment [orderno=" + orderno + ", userid=" + userid + ", amount=" + amount + ", type=" + type + ", regdate="
			+ regdate + ", status=" + status + "]";
}
   */
   
}