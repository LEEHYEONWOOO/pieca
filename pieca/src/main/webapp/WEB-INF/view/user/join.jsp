<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- /shop1/src/main/webapp/WEB-INF/view/user/join.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 등록</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
</head>
<body>
<div style="width:100%; height:100%; margin:7% 0% 10% 37.7%;">
	<h2 style="width:470px; margin-bottom:10px; text-align: center;">PIECA</h2>
	<form:form modelAttribute="user" method="post" action="join">
		<div style="display: inline; text-align:left;">
			아이디
		</div>
		<div style="display: inline; font-size: 13px;">
			<font color="red"><form:errors path="userid" /></font>
			<div id="idCheck" style="display: inline; font-size: 13px;"></div>
		</div>
		<div style="margin:5px 0px 20px 0px; ">
			<form:input path="userid" id="input_userid" style="border:1px solid #747474; border-radius: 6px; font-size:15px; width:360px; height:40px;" placeholder="   아이디 입력 (6~20자)"/>
			<input type="button" id="idCheck_btn" onclick="idCheck()" value="중복 확인" style="width:100px; height:40px; border:1px solid #00B6EF; border-radius: 6px; background-color: #00B6EF; color:white; cursor:pointer;">
		</div>
		
		<div style="display: inline;">
		<input type="hidden" id="passDec">
			비밀번호
		</div>
		<div style="display: inline; font-size: 13px;">
			<font color="red"><form:errors path="password" /></font>
			<div id="pwValid" style="display: inline; font-size: 13px;"></div>
		</div>
		<div style="margin:5px 0px 20px 0px; ">
			<form:password path="password" id="input_password" oninput="passValid()" style="border:1px solid #747474; border-radius: 6px; font-size:15px; width:470px; height:40px;" placeholder="   비밀번호 입력 (대소문자, 숫자, 특수문자 포함 8~20자)"/>
		</div>
		
		<div style="display: inline;">
			비밀번호 확인
		</div>
		<div id="pwCheck" style="display: inline; font-size: 13px;"></div>
		<div style="margin:5px 0px 20px 0px; ">
			<input type="password" id="input_password2" oninput="passValid()" style="border:1px solid #747474; border-radius: 6px; font-size:15px; width:470px; height:40px;" placeholder="   비밀번호 먼저 검증 받으세요.">
		</div>
		
		<div style="display: inline;">
			이름
		</div>
		<div style="display: inline; font-size: 13px;">
			<font color="red"><form:errors path="username" /></font>
		</div>
		<div style="margin:5px 0px 20px 0px; ">
			<form:input path="username" id="input_username" style="border:1px solid #747474; border-radius: 6px; font-size:15px; width:470px; height:40px;" placeholder="   이름을 입력 해주세요."/>
		</div>
				
				
		<div style="display: inline;">
			전화번호
		</div>
		<div style="display: inline; font-size: 13px;">
			<font color="red"><form:errors path="phoneno" /></font>
		</div>
		<div style="margin:5px 0px 20px 0px; ">
			<form:input path="phoneno"  id="input_phoneno" style="border:1px solid #747474; border-radius: 6px; font-size:15px; width:470px; height:40px;" placeholder="   휴대폰 번호 입력 ( ' - ' 제외 11자리)"/>		
		</div>				
			
		<div style="display: inline;">
			이메일
		</div>
		<div style="display: inline; font-size: 13px;">
			<font color="red"><form:errors path="email" /></font>
		</div>				
		<div style="margin:5px 0px 20px 0px;">
			<form:hidden path="email" id="email"/>
			<input type="text" id="input_email" style="border:1px solid #747474; border-radius: 6px; font-size:15px; width:222px; height:40px;" placeholder="   이메일 주소"/>
			<span>@</span>
 			<select name="select_email" id="select_email" style="border:1px solid #747474; border-radius: 6px; font-size:15px; width:222px; height:40px;">
            	<option value="" disabled selected>E-Mail 선택</option>
            	<option value="naver.com" id="naver.com">naver.com</option>
            	<option value="gmail.com" id="gmail.com">gmail.com</option>
            	<option value="hanmail.net" id="hanmail.net">hanmail.net</option>
            	<option value="nate.com" id="nate.com">nate.com</option>
        	</select>
		</div>
		
		<div style="display: inline;">
			생년월일
		</div>
		<div style="display: inline; font-size: 13px;">
			<font color="red"><form:errors path="birthday" /></font>
		</div>
		<div style="margin:5px 0px 50px 0px;">
			<form:hidden path="birthday" id="birthday" />
			<select name="yy" id="year" style="margin-right:19.5px; border:1px solid #747474; border-radius: 6px; font-size:15px; width:140px; height:40px;" ></select>
			<select name="mm" id="month" style="margin-right:19.5px; border:1px solid #747474; border-radius: 6px; font-size:15px; width:140px; height:40px;"></select>
			<select name="dd" id="day" style="border:1px solid #747474; border-radius: 5px; font-size:15px; width:140px; height:40px;"></select>
		</div>			
		
		<input type="submit" id="submit" value="회원가입" style=" width:232px; height:40px; border:1px solid #747474; border-radius: 6px; cursor:pointer;">
		<input type="reset" value="초기화" style=" width:232px; height:40px; border:1px solid #FFBB00; border-radius: 5px; background-color:#FFBB00; cursor:pointer;">
	</form:form>
	</div>
<script>
$(document).ready(function () {
	$("#input_password2").attr("disabled","disabled");
	$("#submit").attr("disabled","disabled");
	$("#submit").css("background-color","#D5D5D5");
  });


function idCheck(){
	var userid = $('#input_userid').val();
	console.log(userid)
	$.ajax({
		type:"POST",
		url: "idConfirm",
		data : {"userid":userid},
		success:function(result){
			console.log(result)
			if ((userid.length >= 6) && (userid.length <= 20)) {
				if (result == true) {
					$("#idCheck").text("사용 가능합니다 :)");
					$("#idCheck").css("color","green");
				} else {
					$("#idCheck").text("이미 사용중입니다.");
					$("#idCheck").css("color","red");
				}
			} else {
				$("#idCheck").text("아이디는 6자 이상, 20자 이하이여야 합니다.");
				$("#idCheck").css("color","red");
			}
		}
	});	
}

function passValid(){
	var password = $("#input_password").val();
	var password2 = $("#input_password2").val();
	var passDec = $("#passDec").val();
	var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~?!@#$%^&*_-]).{8,20}$/
	//reg.test(password) == true => 정규식 일치
	
	if ((password.length >= 8) && (password.length <= 20) 
			&& !(/(\w)\1\1/.test(password))
			&& !(password.search(" ") != -1)
			&& (reg.test(password))){ // 길이 만족할때
		$("#pwValid").text("사용 가능합니다 :)");
		$("#pwValid").css("color","green");
		$("#passDec").val("true");
		$("#input_password2").removeAttr("disabled");
	} else if (/(\w)\1\1/.test(password)) {
		$("#pwValid").text("3번이상 반복되는 문자는 사용 불가능 합니다.");
		$("#pwValid").css("color","red");
		$("#passDec").val("false");
		$("#input_password2").attr("disabled","disabled");
	} else if (password.search(" ") != -1) {
		$("#pwValid").text("공백은 사용 불가능 합니다.");
		$("#pwValid").css("color","red");
		$("#passDec").val("false");
		$("#input_password2").attr("disabled","disabled");
	} else if (!reg.test(password)) {
		$("#pwValid").text("대소문자, 숫자, 특수문자가 포함 8~20자리이어야 합니다.");
		$("#pwValid").css("color","red");
		$("#passDec").val("false");
		$("#input_password2").attr("disabled","disabled");
	}
	
	if (password != "" || password2 != "") {
		if ((password == password2)) {
			$("#pwCheck").text("비밀번호가 일치합니다 :)");
			$("#pwCheck").css("color","green");
			$("#submit").removeAttr("disabled");
			$("#submit").css("background-color","#00B6EF");
		} else if (password != password2) {
			$("#pwCheck").text("비밀번호가 일치하지 않습니다.");
			$("#pwCheck").css("color","red");
			$("#submit").attr("disabled","disabled");
			$("#submit").css("background-color","#BDBDBD");
		}	
	}
}

$("select[name=select_email]").change(function(){
	  var email_be = $("#input_email").val();
	  var email_af = $(this).val();
	  console.log(email_be)
	  console.log(email_af)
	  console.log(email_be + '@' + email_af)
	  $('#email').val(email_be + '@' + email_af);
	});

$("select[name=yy]").change(function() {
	var year = $("#year").val();
	var month = $("#month").val();
	var day = $("#day").val();
	$('#birthday').val(year + '-' + month + '-' + day);
});

$("select[name=mm]").change(function() {
	var year = $("#year").val();
	var month = $("#month").val();
	var day = $("#day").val();
	$('#birthday').val(year + '-' + month + '-' + day);
});

$("select[name=dd]").change(function() {
	var year = $("#year").val();
	var month = $("#month").val();
	var day = $("#day").val();
	$('#birthday').val(year + '-' + month + '-' + day);
});

$(document).ready(function() {
	var now = new Date();
	var year = now.getFullYear();
	var mon = (now.getMonth() + 1) > 9 ? ''
			+ (now.getMonth() + 1) : '0'
			+ (now.getMonth() + 1);
	var day = (now.getDate()) > 9 ? ''
			+ (now.getDate()) : '0' + (now.getDate());
		//년도 selectbox만들기               
	for (var i = 1900; i <= year; i++) {
		$('#year').append('<option value="' + i + '">' + i + '</option>');
	}
							// 월별 selectbox 만들기            
	for (var i = 1; i <= 12; i++) {
		var mm = i > 9 ? i : "0" + i;
		$('#month').append('<option value="' + mm + '">' + mm + '</option>');
	}
	
	// 일별 selectbox 만들기
	for (var i = 1; i <= 31; i++) {
		var dd = i > 9 ? i : "0" + i;
		$('#day').append('<option value="' + dd + '">' + dd + '</option>');
	}
	$("#year  > option[value=" + year + "]").attr("selected", "true");
	$("#month  > option[value=" + mon + "]").attr("selected", "true");
	$("#day  > option[value=" + day + "]").attr("selected", "true");
})

	
</script>
</body>
</html>