<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /shop1/src/main/webapp/WEB-INF/view/user/mypage.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mypage</title>
<style>
.sidenav {
  width: 300px;
  position: fixed;
  z-index: 1;
  top: 120px;  /* y */
  left: 300px; /* x */
  overflow-x: hidden;
  padding: 8px 0;
}

.sidenav a {
  padding: 6px 8px 6px 16px;
  text-decoration: none;
  font-size: 22px;
  color: #2196F3;
  display: block;
}

.sidenav a:hover {
  color: #064579;
}

.main_1 {
  margin-left: 850px; /* .sidenav의 width를 고려해서 지정해야함 */
  font-size: 28px; /* Increased text to enable scrolling */
  padding: 0px 10px;
  width: 750px;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}

</style>
</head>
<%--
   http://localhost:8080/shop1/user/mypage?userid=id명
   mypage 완성하기
   파라미터 : userid
   salelist : userid가 주문한 전체 Sale 객체 목록.(List)
   user     : userid에 해당하는 회원정보
 --%>
<body>


<div class="sidenav">
  <a href="#about"><span class="fa-regular fa-user"></span> 회원 정보</a>
  <a href="#about"><span class="fa-solid fa-lock"></span> 개인정보</a>
  <a href="#services">2</a>
  <a href="#clients">3</a>
  <a href="#contact">4</a>
</div>

<div class="main_1">
	<div id="basic_info_wrapper" style="transition-duration: 0.5s; border:1px solid #FFFFFF; border-radius: 5px; margin-bottom:50px; margin-top:120px; box-shadow: 0px 2px 4px 0px #1B1B1B;height:250px; ">
		<div id="basic_info_left_inner" style="float:left; width:23%; height:230px; margin: 50px 0px 0px 50px; ">
			<div id="basic_info_left_title" style="font-size:24px; display: inline;">
				<span><b>${user.username}님</b>&nbsp;&nbsp;</span>
			</div>
			<a class="fa-regular fa-pen-to-square" id="show_update"></a>
			<div id="basic_info_left_desc" style="font-size:15px;">
				<p>위 항목은 개인 정보로써 다른 사람에게 공유되지 않는 개인정보 입니다.</p>
			</div>
		</div>
		<div id="basic_info_right" style="float:left; width:55%; height:230px; margin: 10px 0px 0px 100px;">
			
			<div id="basic_info_right_id" style=" width:200px;">
				<p style="font-size:15px; margin-bottom: 0px;">ID</p>
				<input type="text" id="userid" value="${user.userid}"
				 style="outline:none; background-color: #FFFFFF; color: #000000; font-size:20px; border:0px solid #747474; border-radius: 6px; width:340px; height:40px;">
			</div>
			
			<div id="basic_info_right_email" style="margin-top:10px;">
			<p style="font-size:15px; margin-bottom: -20px;">이메일</p>
				<span style="font-size:20px;">${user.email}</span>
			</div>
			
			<div id="basic_info_right_phone" style="width:200px; margin-top:10px; display: inline-block;">
				<p style="font-size:15px; margin-bottom: -16px;">전화번호</p>
				<span style="font-size:20px;">${user.phoneno}</span>				
			</div>
			
			<div id="basic_info_right_birth" style="display: inline-block;">
				<p style="font-size:15px; margin-bottom: -16px;">생년월일</p>
				<span style="font-size:20px;"><fmt:formatDate value="${user.birthday}" pattern="yyyy-MM-dd" /></span>
			</div>
		</div>
	</div>
	
	
	
	<div id="basic_pass_wrapper" style="border:1px solid #FFFFFF; border-radius: 5px; margin-bottom:50px; margin-top:120px; box-shadow: 0px 2px 4px 0px #1B1B1B;height:320px; ">
	 
		<div id="basic_info_left_inner" style="float:left; width:23%; height:230px; margin: 90px 0px 0px 50px; ">
			<div id="basic_info_left_title" style="font-size:24px;">
				<span><b>비밀번호 변경</b></span>
			</div>
			<div id="basic_info_left_desc" style="font-size:15px;">
				<p>주기적으로 비밀번호를 변경하여 타인의 무단 사용을 방지하세요.</p>
			</div>
		</div>
		
		<div id="basic_info_right" style="float:left; width:55%; height:350px; margin: 10px 0px 0px 100px;">
		
  				<div id="change_pass_right_current" style="margin-top:10px;">
  				<form action="password" id="form" method="post" name="f" onsubmit="return inchk(this)">
  					<input type="hidden" id="userid" value="${sessionScope.loginUser.userid}">
  					<input type="hidden" id="decesion">
  					
    				<p style="font-size:15px; margin-bottom: 0px;">현재 비밀번호</p>
    				<input type="password" id="password" name="password" oninput="pwCheck(password.value)" style="border:1px solid #747474; border-radius: 6px; width:340px; height:40px;">
    				<span id="check1" class="fa-regular fa-circle-check" style="color: green;"></span>
				</div>
				
				<div id="change_pass_right_current" style="margin-top:10px;">
    				<span style="font-size:15px; margin-bottom: 0px;">새 비밀번호</span>
    				<div id="pwValid" style="display:inline; font-size: 13px;"></div>
				</div>
    				<input type="password" id="chgpass" name="chgpass" oninput="passValid()" style="border:1px solid #747474; border-radius: 6px; width:340px; height:40px;">
				
				<div id="change_pass_right_current2" style="float:left; margin-top: 10px;">    
    				<p style="width:230px; font-size:15px; margin-bottom: 0px;">새 비밀번호 확인</p>
    				<input type="password" id="chgpass2" name="chgpass2" oninput="passValid()" style="border:1px solid #747474; border-radius: 6px; width:270px; height:40px;">
    			</div>
    			<div id="change_pass_right_button" style="float:left; margin: 42px 0px 0px 10px">
    				<input type="submit" id="submit" value="변경" style="border:1px solid #D5D5D5; border-radius: 6px; font-size:16px; width:60px; height:40px; color:#FFFFFF;">    
    			</div>
				</form>
		</div>
	</div>
	
	<div id="basic_pass_wrapper" style="border:1px solid #FFFFFF; border-radius: 5px; margin-bottom:50px; margin-top:120px; box-shadow: 0px 2px 4px 0px #1B1B1B;height:300px; ">
	
		<div id="basic_info_left_inner" style="float:left; width:23%; height:230px; margin: 70px 0px 0px 50px; ">
			<div id="basic_info_left_title">
				<h3>PIKA Card</h3>
			</div>
			<div id="basic_info_left_desc" style="font-size:15px;">
				<p>PIKA에서 제공하는 충전 카드로 다양한 혜택을 누려보세요.</p>
			</div>
		</div>
		
		<div id="basic_info_right" style="float:left; width:60%; height:350px; margin: 35px 0px 0px 30px;">
		
  				<div id="change_pass_right_current" style="margin-top:10px; text-align:center;">
  					<img src="${path}../img/PIKA_CARD2_non.jpg" alt="Image" style="width:60%">
  				</div>
		</div>
	</div>
	
	
	


</div> <!-- main -->
<script type="text/javascript">

$(document).ready(function () {
	$("#userid").attr("disabled","disabled");
	
	$("#chgpass").attr("disabled","disabled");
	$("#chgpass").css("background-color","#D5D5D5");
	$("#chgpass2").css("background-color","#D5D5D5");
	$("#chgpass2").attr("disabled","disabled");
	$("#submit").attr("disabled","disabled");
	$("#submit").css("background-color","#D5D5D5");
	$("#check1").hide();
	$("#update_info_wrapper").hide();
  });

$(document).ready(function(){
	  $("#show_update").click(function(){
		  $("#basic_info_wrapper").css("height","350px");
		  $("#userid").css("border","1px solid #747474");
		  $("#userid").removeAttr("disabled");
	  });
	});
	
function pwCheck(password){
	console.log(password)
	$.ajax({
		type:"POST",
		url: "pwCheck",
		data : {"userid":$("#userid").val(),
				"password": password },
		success:function(result){
			console.log(result)
			if (result == true) {
				$("#check1").show();
				$('#decesion').val("ready");
				$("#chgpass").removeAttr("disabled");
				$("#chgpass").css("background-color","#FFFFFF");
			} else {
				$("#check1").hide();
				$('#decesion').val("not");
				$("#chgpass").attr("disabled","disabled");
				$("#chgpass").css("background-color","#D5D5D5");
			}
		}
	});	
}

function passValid(){
	var password = $("#password").val();
	var chgpass = $("#chgpass").val();
	var chgpass2 = $("#chgpass2").val();
	var passDec = $("#passDec").val();
	var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~?!@#$%^&*_-]).{8,20}$/
	//reg.test(password) == true => 정규식 일치
	
	
	if ((chgpass.length >= 8) && (chgpass.length <= 20) 
			&& !(/(\w)\1\1/.test(chgpass))
			&& !(chgpass.search(" ") != -1)
			&& (reg.test(chgpass))){ // 길이 만족할때
		$("#pwValid").text("사용 가능합니다 :)");
		$("#pwValid").css("color","green");
		$("#passDec").val("true");
		$("#chgpass2").removeAttr("disabled");
		$("#chgpass2").css("background-color","#FFFFFF");
	} else if (/(\w)\1\1/.test(chgpass)) {
		$("#pwValid").text("3번이상 반복되는 문자는 사용 불가능 합니다.");
		$("#pwValid").css("color","red");
		$("#passDec").val("false");
		$("#chgpass2").attr("disabled","disabled");
		$("#chgpass2").css("background-color","#D5D5D5");
	} else if (chgpass.search(" ") != -1) {
		$("#pwValid").text("공백은 사용 불가능 합니다.");
		$("#pwValid").css("color","red");
		$("#passDec").val("false");
		$("#chgpass2").attr("disabled","disabled");
		$("#chgpass2").css("background-color","#D5D5D5");
	} else if (!reg.test(chgpass)) {
		$("#pwValid").text("대소문자, 숫자, 특수문자 포함 8~20자리");
		$("#pwValid").css("color","red");
		$("#passDec").val("false");
		$("#chgpass2").attr("disabled","disabled");
		$("#chgpass2").css("background-color","#D5D5D5");
	}
	
	if (chgpass != "" || chgpass2 != "") {
		if ((chgpass == chgpass2)) {
			$("#pwCheck").text("비밀번호가 일치합니다 :)");
			$("#pwCheck").css("color","green");
			$("#submit").removeAttr("disabled");
			$("#submit").css("background-color","#00B6EF");
		} else if (chgpass != chgpass2) {
			$("#pwCheck").text("비밀번호가 일치하지 않습니다.");
			$("#pwCheck").css("color","red");
			$("#submit").attr("disabled","disabled");
			$("#submit").css("background-color","#BDBDBD");
		}	
	}
}
</script>

</body>

</html>