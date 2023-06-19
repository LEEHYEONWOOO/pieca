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
  left: 200px; /* x */
  background: #eee;
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
  margin-left: 750px; /* .sidenav의 width를 고려해서 지정해야함 */
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
	<div id="basic_info_wrapper" style="border:1px solid #FFFFFF; border-radius: 5px; margin-bottom:50px; margin-top:120px; box-shadow: 0px 2px 4px 0px #1B1B1B;height:250px; ">
		<div id="basic_info_left_inner" style="float:left; width:23%; height:230px; margin: 50px 0px 0px 50px; ">
			<div id="basic_info_left_title">
				<h3>${user.username}님</h3>
			</div>
			<div id="basic_info_left_desc" style="font-size:15px;">
				<p>위 항목은 개인 정보로써 다른 사람에게 공유되지 않는 개인정보 입니다.</p>
			</div>
		</div>
		
		<div id="basic_info_right" style="float:left; width:55%; height:230px; margin: 10px 0px 0px 100px;">
			<div id="basic_info_right_id" style=" width:200px; display:inline-block;">
				<p style="font-size:15px; margin-bottom: -12px;">ID</p>
				<span style="font-size:25px;">${user.userid}</span>
			</div>
			<div id="basic_info_right_birth" style="display:inline-block;">
				<p style="font-size:15px; margin-bottom: -10px;">생년월일</p>
				<span style="font-size:25px;"><fmt:formatDate value="${user.birthday}" pattern="yyyy" /></span>
				<span style="font-size:25px;"><fmt:formatDate value="${user.birthday}" pattern="MM" /></span>
				<span style="font-size:25px;"><fmt:formatDate value="${user.birthday}" pattern="dd" /></span>
			</div>
			<div id="basic_info_right_phone" style="width:450px; margin-top:10px;">
				<p style="font-size:15px; margin-bottom: -10px;">전화번호</p>
				<span style="font-size:25px;">${user.phoneno}</span>				
			</div>
			<div id="basic_info_right_email" style="margin-top:10px;">
			<p style="font-size:15px; margin-bottom: -10px;">이메일 주소</p>
				<span style="font-size:25px;">${user.email}</span>
			</div>
		</div>
	</div>
	
	<div id="basic_pass_wrapper" style="border:1px solid #FFFFFF; border-radius: 5px; margin-bottom:50px; margin-top:120px; box-shadow: 0px 2px 4px 0px #1B1B1B;height:230px; ">
		<div id="basic_info_left_inner" style="float:left; width:23%; height:230px; margin: 45px 0px 0px 50px; ">
			<div id="basic_info_left_title">
				<h3>비밀번호 변경</h3>
			</div>
			<div id="basic_info_left_desc" style="font-size:15px;">
				<p>주기적으로 비밀번호를 변경하여 타인의 무단 사용을 방지하세요.</p>
			</div>
		</div>
		
		<div id="basic_info_right" style="float:left; width:55%; height:350px; margin: 20px 0px 0px 40px;">
		
  				<div id="change_pass_right_current" style="margin-top:10px;">
  				<form action="password" id="form" method="post" name="f" onsubmit="return inchk(this)">
  					<input type="hidden" id="userid" value="${sessionScope.loginUser.userid}">
  					<input type="hidden" id="decesion">
  					
    				<p style="font-size:15px; margin-bottom: 0px;">현재 비밀번호</p>
    				<input type="password" id="password" name="password" oninput="pwCheck(password.value)" style="width:400px;">
    				<span id="check1" class="fa-regular fa-circle-check" style="color: green;"></span>
				</div>
				
				<div id="change_pass_right_current" style="margin-top:10px;">
    				<p style="font-size:15px; margin-bottom: 0px;">새 비밀번호</p>
    				<input type="password" id="chgpass" name="chgpass" style="width:400px;">
    				<span id="check2" class="fa-regular fa-circle-check" style="color: green;"></span>
				</div>
				
				<div id="change_pass_right_current" style="margin-top:10px; display:inline-block;">    
    				<p style="font-size:15px; margin-bottom: 0px;">새 비밀번호 확인</p>
    				<input type="password" id="chgpass2" name="chgpass2" style="width:260px;">
    				<!--  <span id="check3" class="fa-regular fa-circle-check" style="color: green;"></span>-->
    			</div>
    			<div id="change_pass_right_submit" style=" width:30px; margin-top:10px;  display:inline-block;">
    				<input type="submit" id="submit" value="변경하기">
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
		
		<div class='v-line' style="float:left; margin:25px 0px 0px 35px; border-left: thin solid #747474; height: 250px;"></div>
		
		<div id="basic_info_right" style="float:left; width:60%; height:350px; margin: 35px 0px 0px 30px;">
		
  				<div id="change_pass_right_current" style="margin-top:10px; text-align:center;">
  					<img src="${path}../img/PIKA_CARD2_non.jpg" alt="Image" style="width:60%">
  				</div>
		</div>
	</div>
	
	
	


</div> <!-- main -->
<script type="text/javascript">
function goBack() {
	window.history.back();
}

$(document).ready(function () {
	$("#submit").attr("disabled","disabled");
	$("#submit").css("background-color","#747474");
	$("#check1").hide();
	$("#check2").hide();
	$("#check3").hide();
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
			} else {
				$("#check1").hide();
				$('#decesion').val("not");
			}
		}
	});	
}

$(function inchk(f) {
	$("input").keyup(function() {
		var chgpass = $("#chgpass").val();
		var chgpass2 = $("#chgpass2").val();
		var decesion = $("#decesion").val();
		if (chgpass != "" || chgpass2 != "") {
			if ((chgpass == chgpass2) && (decesion == "ready")){
				console.log(decesion)
				$("#submit").removeAttr("disabled");
				$("#submit").css("background-color","#04AA6D");
				$("#check2").show();
				$("#check3").show();
			} else {
				$("#submit").attr("disabled","disabled");
				$("#submit").css("background-color","#747474");
				$("#check2").hide();
				$("#check3").hide();
				return false;
			}
		}
		return true;
	})
})
</script>

</body>

</html>