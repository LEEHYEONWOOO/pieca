<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%-- /shop1/src/main/webapp/WEB-INF/view/user/idsearch.jsp 
     1. sitemesh 대상페이지 아님
     2. idsearch, pwsearch를 하나의 controller에서 구현 --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카드 발급</title>
<link href="../css/pieca.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/f060468afd.js" crossorigin="anonymous"></script>
<style>

input::placeholder {
   font-family: 'KIMM_Bold';
}

input[type=password]{
   font-family: "arial";
}
input::placeholder {
   font-family: 'KIMM_Bold';
}
</style>
</head>
<body>
   <div id="getcard_container" style="width:80%; margin:0% 0% 0% 19.5%;">
   <div id="getcard_logo" style="width:371px; text-align:center; margin:20px 0px 20px 0px;">
      <img src="../img/PIECA_logo.png" style="width:140px; height:70px;">
   </div>
   <%-- ${result==ok} --%>
   <form:form modelAttribute="user" action="getcard" method="post">
   <form:hidden path="userid" id="email" value="${loginUser.userid}"/>
   <div id="getcard_global_error" style="margin-bottom: 5px;">
      <spring:hasBindErrors name="user">
         <font color="red"><c:forEach items="${errors.globalErrors}"
               var="error">
               <spring:message code="${error.code}" />
            </c:forEach></font>
      </spring:hasBindErrors>
   </div>
   <div id="getcard_email_title" style="display: inline;">
      이메일
   </div>
   <div id="getcard_email_error_box" style="display: inline; font-size: 13px;">
      <input type="hidden" id="getcard_email_mode">
      <font color="red"><form:errors path="email" /></font>
      <div id="getcard_email_error" style="display: inline; font-size: 13px;"></div>
   </div>
   <div id="getcard_email_input_box" style="margin:5px 0px 20px 0px; ">
      <input type="text" name="email" id="getcard_email_input" oninput="emailChk(); submitChk();" style="border:2px solid #747474; border-radius: 6px; font-size:20px; width:75%; height:60px; padding-left:15px;" placeholder="이메일을 입력 해주세요.">
   </div>
   
   <%-- 비밀번호 --%>            
   <div id="getcard_password_title" style="display: inline;">
      비밀번호
   </div>
   <div id="getcard_password_error_box" style="display: inline; font-size: 13px;">
      <input type="hidden" id="getcard_password_mode">
      <font color="red"><form:errors path="password" /></font>
      <div id="getcard_password_error" style="display: inline; font-size: 13px;"></div>
   </div>
   <div id="getcard_password_input_box" style="margin:5px 0px 20px 0px; ">
      <input type="password" name="password" id="getcard_password_input" oninput="passwordChk(); submitChk();" style="border:2px solid #747474; border-radius: 6px; font-size:20px; width:75%; height:60px; padding-left:15px;" placeholder="비밀번호를 입력 해주세요.">
   </div>
   <%-- 비밀번호 --%>
   
   <%-- 보안코드 --%>
   <div id="getcard_securitycode1_title" style="float:left; width:200px;">
      보안코드
   </div>
   <div id="getcard_securitycode1_input_box" style="float:left; width:200px; margin:20px 10px 20px -200px; ">
      <input type="hidden" id="getcard_security_mode">
      <input type="text" id="getcard_securitycode1_input" readonly="readonly" style="border:2px solid #747474; border-radius: 6px; font-size:25px; width:90%; height:60px; padding-left:15px;">
   </div>
   <div id="getcard_securitycode1_logo_box" style="position: relative; float:left; font-size:35px; margin:35px 0px 0px -50px;">
      <span id="getcard_securitycode1_logo" class="fa-sharp fa-solid fa-arrows-rotate"
         onclick="getRandomString();" style="color:#2196F3;"></span>
   </div>
   <%-- 보안코드 --%>
   
   <%-- 보안코드 확인 --%>
   <div id="getcard_securitycode2_title" style="float:left; width:200px;">
      보안코드 확인
   </div>
   <div id="getcard_securitycode2_input_box" style="float:left; width:200px; margin:20px 0px 20px -200px; ">
      <input type="text" id="getcard_securitycode2_input" oninput="securityChk(); submitChk();" style="border:2px solid #747474; border-radius: 6px; font-size:25px; width:70%; height:60px; padding-left:15px;">
   </div>
   <%-- 보안코드 --%>
   
   ${loginUser.card}
   <input type="submit" id="getcard_submit" value="PIECA CARD 발급" style="width:79%; height:60px; border:2px solid #D5D5D5; border-radius: 6px; background-color: #D5D5D5;font-size: 22px; color:white; cursor:pointer;">
   <%-- 
   <input type="button" id="getcard_send_button" value="아이디 전송" onclick="idSend();" style="width:39.6%; height:44px; border:2px solid #D5D5D5; border-radius: 6px; background-color: #D5D5D5; font-size: 18px; color:white; cursor:pointer;">
   --%>
   </form:form>
   </div>
<script>
$(document).ready(function(){
   $("#getcard_securitycode1_logo").hide();
   $("#getcard_securitycode1_input").attr("disabled","disabled");
    $("#getcard_securitycode2_input").attr("disabled","disabled");
    $("#getcard_securitycode1_input").css("background-color","#D5D5D5");
    $("#getcard_securitycode2_input").css("background-color","#D5D5D5");
    $("#getcard_submit").attr("disabled","disabled");
    $("#getcard_submit").css("background-color","#D5D5D5");
    $("#getcard_submit").css("border","2px solid #747474");
})

function preventCopy(e) {
   e = e || window.event;
   if (e.preventDefault) {
      e.preventDefault();
   } else {
      e.returnValue = false;
   }
}
$("input").on("copy", preventCopy);

function getRandomString() {
   var letters = "!@#$%^&*ABCDEFGHJKMNPQRSTUVWXYZ23456789";
   var randomString = "";
   $("#getcard_securitycode2_input").val('');
   //security_codeChk()
   for (var i = 0; i < 6; i++) {
      randomString += letters.charAt(Math.floor(Math.random() * letters.length));
   }
   $('#getcard_securitycode1_input').val(randomString);
}
   
function emailChk() {
   var email = $("#getcard_email_input").val();
   var reg = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$/;
   if (reg.test(email)) {
      $("#getcard_email_error").text("옳바른 형식입니다.");
      $("#getcard_email_error").css("color","green");
      $("#getcard_email_mode").val("enable");
   } else {
      $("#getcard_email_error").text("옳바른 형식이 아닙니다.");
      $("#getcard_email_error").css("color","red");
      $("#getcard_email_mode").val("disable");
   }
}

function passwordChk(){
   var password = $("#getcard_password_input").val();
   var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~?!@#$%^&*_-]).{8,20}$/
   if ((password.length >= 8) && (password.length <= 20) 
   && !(/(\w)\1\1/.test(password)) && !(password.search(" ") != -1)
   && (reg.test(password))){ // 길이 만족할때
      $("#getcard_password_error").text("옳바른 형식 입니다.");
      $("#getcard_password_error").css("color","green");
      $("#getcard_password_mode").val("enable");
      $("#getcard_securitycode1_logo").show();
      $("#getcard_securitycode1_input").removeAttr("disabled");
      $("#getcard_securitycode2_input").removeAttr("disabled");
      $("#getcard_securitycode1_input").css("background-color","#FFFFFF");
      $("#getcard_securitycode2_input").css("background-color","#FFFFFF");
      getRandomString();
   } else if (/(\w)\1\1/.test(password)) {
      $("#getcard_password_error").text("3번이상 반복되는 문자는 불가능 합니다.");
      $("#getcard_password_error").css("color","red");
      $("#getcard_securitycode1_input").val("");
      $("#getcard_password_mode").val("disable");
      $("#getcard_securitycode1_logo").hide();
      $("#getcard_securitycode1_input").attr("disabled","disabled");
        $("#getcard_securitycode2_input").attr("disabled","disabled");
        $("#getcard_securitycode1_input").css("background-color","#D5D5D5");
        $("#getcard_securitycode2_input").css("background-color","#D5D5D5");
   } else if (password.search(" ") != -1) {
      $("#getcard_password_error").text("공백은 사용 불가능 합니다.");
      $("#getcard_password_error").css("color","red");
      $("#getcard_securitycode1_input").val("");
      $("#getcard_password_mode").val("disable");
      $("#getcard_securitycode1_logo").hide();
      $("#getcard_securitycode1_input").attr("disabled","disabled");
        $("#getcard_securitycode2_input").attr("disabled","disabled");
        $("#getcard_securitycode1_input").css("background-color","#D5D5D5");
        $("#getcard_securitycode2_input").css("background-color","#D5D5D5");
   } else if (!reg.test(password)) {
       $("#getcard_password_error").text("대소문자, 숫자, 특수문자, 8~20자리");
       $("#getcard_password_error").css("color","red");
       $("#getcard_securitycode1_input").val("");
       $("#getcard_password_mode").val("disable");
       $("#getcard_securitycode1_logo").hide();
       $("#getcard_securitycode1_input").attr("disabled","disabled");
        $("#getcard_securitycode2_input").attr("disabled","disabled");
        $("#getcard_securitycode1_input").css("background-color","#D5D5D5");
        $("#getcard_securitycode2_input").css("background-color","#D5D5D5");
   }
}

function securityChk() {
   var code1 = $("#getcard_securitycode1_input").val();
   var code2 = $("#getcard_securitycode2_input").val();
   
   if (code1 == code2) {
      $("#getcard_security_mode").val("enable");
   } else {
      $("#getcard_security_mode").val("disable");
   }
}

function submitChk() {
      var mode_email = $("#getcard_email_mode").val();
      var mode_password = $("#getcard_password_mode").val();
      var mode_security = $("#getcard_security_mode").val();
      
      if ((mode_email == 'enable') && (mode_password == 'enable') &&
      (mode_security == 'enable')) {
            $("#getcard_submit").show();
         $("#getcard_submit").removeAttr("disabled");
         $("#getcard_submit").css("background-color","#2196F3");
         $("#getcard_submit").css("border","2px solid #2196F3");
      } else {
         $("#getcard_submit").attr("disabled","disabled");
         $("#getcard_submit").css("background-color","#D5D5D5");
         $("#getcard_submit").css("border","2px solid #747474");
      }
   }
</script>   
</body>
</html>