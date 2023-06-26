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
<title>아이디 찾기</title>
<style>
@font-face {
    font-family: 'KIMM_Bold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2212@1.0/KIMM_Bold.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}

body * {
   margin: 0;
   font-family: 'KIMM_Bold';
}
</style>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
   <div style="width:80%; margin:0% 0% 0% 19.5%;">
   <div id="join_title" style="width:296px; text-align:center; margin:20px 0px 20px 0px;">
      <img src="../img/PIECA_logo.png" style="width:140px; height:70px;">
   </div>
   
   <form:form modelAttribute="user" action="idsearch" method="post">
   
   <div style="font-size: 13px; margin:0px 0px 10px 0px;">
      <spring:hasBindErrors name="user">
         <font color="red"><c:forEach items="${errors.globalErrors}"
               var="error">
               <spring:message code="${error.code}" />
            </c:forEach></font>
      </spring:hasBindErrors>
   </div>
      
   <div style="display: inline;">
      이메일
   </div>
   <div style="display: inline; font-size: 13px;">
      <input type="hidden" id="mode_email">
      <font color="red"><form:errors path="email" id="error_email"/></font>
      <div id="emailChk" style="display: inline; font-size: 13px;"></div>
   </div>
   <div style="margin:5px 0px 20px 0px; ">
      <input type="text" name="email" id="input_email" oninput="emailChk(); idChk();" style="border:2px solid #747474; border-radius: 6px; font-size:15px; width:75%; height:40px; padding-left:15px;" placeholder="이메일을 입력 해주세요.">
   </div>
            
   <div style="display: inline;">
      전화번호
   </div>
   <div style="display: inline; font-size: 13px;">
      <input type="hidden" id="mode_phone">
      <font color="red"><form:errors path="phoneno"/></font>
      <div id="phoneChk" style="display: inline; font-size: 13px;"></div>
   </div>
   <div style="margin:5px 0px 20px 0px; ">
      <input type="text" name="phoneno" id="input_phone" oninput="phonenoChk(); idChk();" style="border:2px solid #747474; border-radius: 6px; font-size:15px; width:75%; height:40px; padding-left:15px;" placeholder="핸드폰번호를 ' - ' 없이 입력 해주세요.">
   </div>
   
   <div style="font-size: 15px; margin:0px 0px 20px 0px;">
      <c:if test="${not empty result}">
         <c:set var="userid" value="${result}"/>
         <c:set var="length" value="${fn:length(result)}"/>
         <c:set var="display" value = "${fn:substring(userid, 0, length-3)}" />
         <input type="text" id="display" value="회원님의 아이디는 ${display}*** 입니다." style="border:none; outline:none; width:75%; height:20px;" readonly="readonly">
      </c:if>
   </div>         
            
   <input type="submit" id="submit" value="아이디 검색" style="width:39.6%; height:44px; border:2px solid #D5D5D5; border-radius: 6px; background-color: #D5D5D5;font-size: 18px; color:white; cursor:pointer;">
   <input type="button" id="send_button" value="아이디 전송" onclick="idSend();" style="width:39.6%; height:44px; border:2px solid #D5D5D5; border-radius: 6px; background-color: #D5D5D5; font-size: 18px; color:white; cursor:pointer;">
   </form:form>
   </div>
<script>
function idSend() {
   opener.document.loginform.userid.value='${display}***';
   self.close();
}

$(document).ready(function () {
   $("#submit").attr("disabled",true);
   $("#send_button").attr("disabled",true);
   var display = $("#display").val();
   console.log(display)
   if (display != null) {
      $("#send_button").attr("disabled",false);
      $("#send_button").css("background-color","#FFBB00");      
      $("#send_button").css("border","2px solid #FFBB00");   
   } else {
      $("#send_button").attr("disabled",true);
      $("#send_button").css("background-color","#D5D5D5");
      $("#send_button").css("border","2px solid #D5D5D5");
   }
});

function emailChk() {
   var email = $("#input_email").val();
   var reg = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$/;
   if (reg.test(email)) {
      $("#emailChk").text("옳바른 형식입니다.");
      $("#emailChk").css("color","green");
      $("#mode_email").val("enable");
   } else {
      $("#emailChk").text("옳바른 형식이 아닙니다.");
      $("#emailChk").css("color","red");
      $("#mode_email").val("disable");
   }
}

function phonenoChk() {
   var phoneno = $("#input_phone").val();
   var phonenoLen = $("#input_phone").val().length;
   var reg = /^[0-9]{10,11}$/

   if ((reg.test(phoneno)) && (!phoneno.match(/\-/g) )) {
      $("#phoneChk").text("옳바른 형식입니다.");
      $("#phoneChk").css("color","green");
      $("#mode_phone").val("enable");
   }  else if (phoneno.match(/\-/g)) {
      $("#phoneChk").text("' - '없이 입력하세요.");
      $("#phoneChk").css("color","red");
      $("#mode_phone").val("disable");
   } else if (!reg.test(phoneno)) {
      $("#phoneChk").text("10, 11자리로 숫자만 입력하세요.");
      $("#phoneChk").css("color","red");
      $("#mode_phone").val("disable");
   }
}

function idChk() {
   var email = $("#mode_email").val();
   var phone = $("#mode_phone").val();
   console.log(email)
   if ((email == "enable") && (phone == "enable")) {
      $("#submit").attr("disabled",false);
      $("#submit").css("background-color","#2196F3");      
      $("#submit").css("border","2px solid #2196F3");      
   } else {
      $("#submit").attr("disabled",true);
      $("#submit").css("background-color","#D5D5D5");
      $("#submit").css("border","2px solid #D5D5D5");
   }
}
</script>   
</body>
</html>