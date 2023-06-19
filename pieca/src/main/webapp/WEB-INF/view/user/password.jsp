<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /shop1/src/main/webapp/WEB-INF/view/user/password.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<script src="https://kit.fontawesome.com/f060468afd.js" crossorigin="anonymous"></script>
<script type="text/javascript" src= 
"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<style>

input[type=password]{
  width: 30.5%;
  display:flex;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-bottom: 4%;
  resize: vertical;
}

input[type=submit], #goback {
  background-color: red;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  width: 15%;
}

.container {
  border-radius: 5px;
  padding: 30px;
  margin-left: 42%;
}

#check1, #check2, #check3 {
	display:hidden;
}

 #check1, #check2, #check3 {
	color: green; 
	font-size:18px;
}

.container label {
	font-size:18px;
}
</style>
</head>
<body>
<div class="container">
  <form action="password" id="form" method="post" name="f" onsubmit="return inchk(this)">
  	<input type="hidden" id="userid" value="${sessionScope.loginUser.userid}">
  	<input type="hidden" id="decesion">
    <label for="password">사용중인 비밀번호</label>
    <span id="check1" class="fa-regular fa-circle-check"></span>
    <input type="password" id="password" name="password" oninput="pwCheck(password.value)">
	
    <label for="chgpass">변경 비밀번호 1차</label>
    <span id="check2" class="fa-regular fa-circle-check"></span>
    <input type="password" id="chgpass" name="chgpass">
    
    <label for="chgpass2">변경 비밀번호 2차</label>
    <span id="check3" class="fa-regular fa-circle-check"></span>
    <input type="password" id="chgpass2" name="chgpass2">
    <input type="button" id="goback" onclick="goBack();" value="뒤로가기">
    <input type="submit" id="submit" value="비밀번호 변경">
</form>
</div>

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