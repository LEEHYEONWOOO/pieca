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

.main {
  margin-left: 800px; /* .sidenav의 width를 고려해서 지정해야함 */
  font-size: 28px; /* Increased text to enable scrolling */
  padding: 0px 10px;
  width: 900px;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}

#writeInput:focus{
    outline:none;
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

   <div class="main">

   <div id="basic_info_wrapper" style="transition-duration: 0.5s; border:1px solid #FFFFFF; border-radius: 5px; margin:120px 0px 50px 0px; box-shadow: 0px 2px 4px 0px #1B1B1B; height:340px; ">
   
   <form:form modelAttribute="user" method="post" action="update">
   
      <div id="basic_info_left_inner" style="float:left; width:20%; height:230px; margin: 40px 0px 0px 50px; ">
         <div id="basic_info_left_title" style="display: inline;">
            <c:if test="${user.channel eq 'naver' }">
               <img src="../img/mypage_N.png" style="width:30px; height:30px;">
               <b><form:input path="userid" value="${user.username}" id="writeInput" readonly="true" spellcheck="false"
                style="font-size:24px; width:100px; border:none; margin:-5px 0px 0px 0px;"/></b>
            </c:if>
            <c:if test="${user.channel eq null }">
               <b><form:input path="userid" value="${user.userid}" id="userid" readonly="true" spellcheck="false"
                style="font-size:24px; width:200px; border:none;"/></b>
             </c:if>
         </div>
         
         
         <div id="basic_info_left_desc" style="font-size:15px;">
            <p>위 항목은 개인 정보로써 다른 사람에게 공유되지 않는 개인정보 입니다.</p>
         </div>
      </div>
      
      <div id="basic_info_right" style="float:left; width:55%; height:230px; margin: 30px 0px 0px 165px;">
         <%-- 이름 --%>
         <div id="basic_info_right_username" style="width:80px; position:relative; float:left; margin: 0px 0px 0px 0px;">
            <label for="username" style="font-size:16px; color: #747474;">name</label>
            <input type="hidden" id="mode_name">
         </div>
         
         <div id="basic_info_right_username_error" style="width:180px; position:relative; float:left; margin:-1px 0px 0px -20px; ">
            <label id="usernameCheck" for="username" style="font-size:13px; color: #747474;">&nbsp;</label>
         </div>
         
         <div id="basic_info_right_username_input" style="float:left; margin:-30px 30px 0px -17px;">
            <input type="hidden" id="start_name">
            <form:input path="username" id="username" value="${user.username}" oninput="nameChk(); upSubmitChk();"
            style="width:420px; border:2px solid #FFFFFF; border-radius: 6px; background-color: #FFFFFF; color: #000000; font-size:23px; height:60px; padding:18px 0px 0px 14px;"/>
         </div>
         <div id="basic_info_right_update" style="float: left; position:relative;margin: -12px 0px 0px -335px;">
      <a class="fa-regular fa-pen-to-square" id="show_update"></a>
   </div>
         
         <%-- 
         
         
         --%>         
         <input type="hidden" id="mode"/>
         <%-- 이메일 --%>
         <div id="basic_info_right_email_email" style="width:60px; position:relative; float:left;">
            <label for="input_email" style="font-size:16px; color: #747474;">email</label>
            <input type="hidden" id="mode_email">
         </div>
         
         <div id="basic_info_right_email_error" style="width:150px; position:relative; float:left;">
            <label id="emailCheck" for="input_email" style="font-size:13px; color: #747474;">&nbsp;</label>
         </div>
         
         <div id="basic_info_right_email_input" style="float:left; margin:-35px 10px 0px -17px;">
            <form:hidden path="email" id="email"/>
               <c:set var="email_base" value="${user.email}"/>
               <c:set var="email_be" value = "${fn:split(email_base, '@')[0]}" />
               <c:set var="email_af" value = "${fn:split(email_base, '@')[1]}" />
               <input type="hidden" id="start_email">
               <input type="hidden" id="start_email_be">
               <input type="hidden" id="start_email_af">
               <input type="hidden" id="email_af" value="${email_af}">
               <input type="text" id="input_email" value="${email_be}" oninput="emailChk(); upSubmitChk();"
               style="margin:42px 0px 0px -210px; width:230px; border:2px solid #747474; border-radius: 6px; background-color: #FFFFFF; color: #000000; font-size:23px; height:60px; padding:18px 0px 0px 15px;"/>
               
               <form:input path="email" id="email_original" value="${user.email}"
               style="width:440px; border:2px solid #FFFFFF; border-radius: 6px; background-color: #FFFFFF; color: #000000; font-size:23px; height:60px; padding:18px 0px 0px 15px;"/>
               
         </div>
         <div id="basic_info_right_email_address" style="width:50px; position:relative; float:left; margin:0px 0px 0px 0px;">
            <label for="select_email" style="font-size:16px; color: #747474;">address</label>
         </div>
         
         <div id="basic_info_right_email_input" style="float:left; margin:-60px 30px 0px 217px;">
            <select name="select_email" id="select_email" style="border:2px solid #747474; border-radius: 6px; font-size:23px; width:187px; height:60px; padding:14px 0px 0px 0px;">
                  <option value="naver.com" id="naver.com">naver.com</option>
                  <option value="gmail.com" id="gmail.com">gmail.com</option>
                  <option value="hanmail.net" id="hanmail.net">hanmail.net</option>
                  <option value="nate.com" id="nate.com">nate.com</option>
              </select>
           </div>
         
         <%-- 
         <input type="text" id="input_email" style="border:1px solid #747474; border-radius: 6px; font-size:15px; width:222px; height:40px;" placeholder="   이메일 주소"/>
         <span>@</span>
          <select name="select_email" id="select_email" style="border:1px solid #747474; border-radius: 6px; font-size:15px; width:222px; height:40px;">
               <option value="" disabled selected>E-Mail 선택</option>
               <option value="naver.com" id="naver.com">naver.com</option>
               <option value="gmail.com" id="gmail.com">gmail.com</option>
               <option value="hanmail.net" id="hanmail.net">hanmail.net</option>
               <option value="nate.com" id="nate.com">nate.com</option>
           </select>
         --%>
         <%-- 전화번호 --%>
         <div id="basic_info_right_phoneno" style="width:50px; position:relative; float:left;">
            <label for="tel" style="font-size:16px; color: #747474;">Tel</label>
            <input type="hidden" id="mode_phone">
         </div>
         
         <div id="basic_info_right_phoneno_error" style="width:200px; position:relative; float:left; margin:-1px 0px 0px -20px; ">
            <label id="phonenoCheck" for="tel" style="font-size:13px; color: #747474;">&nbsp;</label>
         </div>
         
         <div id="basic_info_right_phoneno_input" style="float:left; margin:-33px 100px 0px -17px;">
            <form:input path="phoneno" id="phoneno" value="${user.phoneno}" oninput="phonenoChk(); upSubmitChk();"
            style="width:420px; border:2px solid #FFFFFF; border-radius: 6px; background-color: #FFFFFF; color: #000000; font-size:23px; height:60px; padding:18px 0px 0px 15px;"/>
            <input type="hidden" id="start_phoneno">
         </div>
         
         <%-- 생년월일 --%>
         <div id="basic_info_right_birthday_input_update_s1">
         <div id="basic_info_right_birth" style="width:50px; position:relative; float:left;">
            <label for="tel" style="font-size:16px; color: #747474;">birth</label>
         </div>
         
         <div id="basic_info_right_birth_error" style="width:200px; position:relative; float:left; margin:-1px 0px 0px -20px; ">
            <label id="birthCheck" for="tel" style="font-size:13px; color: #747474;">&nbsp;</label>
         </div>
         
         <div id="basic_info_right_birth_input" style="float:left; margin:-35px 10px 0px -68px;">
            <fmt:formatDate value="${user.birthday}" var="birth" type="date" pattern="yyyy-MM-dd" />
            <form:input path="birthday" id="birthday" value="${birth}" oninput=""
            style="width:360px; border:2px solid #FFFFFF; border-radius: 6px; background-color: #FFFFFF; color: #000000; font-size:23px; height:60px; padding:19px 0px 0px 14px;"/>
            <input type="hidden" id="start_birthday">
         </div>
         </div>
         
         <%-- 년 --%>
         <form:hidden path="birthday" id="birthday" />
         <div id="basic_info_right_birthday_input_update_s2">
            
            <div id="basic_info_right_birthday_year" style="width:50px; position:relative; float:left;">
               <label for="year" style="font-size:16px; color: #747474;">Year</label>
            </div>
            <div id="basic_info_right_birthday_input_year" style="float:left; margin:7px 10px 0px -67px;">
               <fmt:formatDate value="${user.birthday}" var="year" type="date" pattern="yyyy" />
               <select name="yy" id="year" style="width:138px; border:2px solid #747474; border-radius: 6px; background-color: #FFFFFF; color: #000000; font-size:23px; height:60px; padding:18px 0px 0px 10px;" ></select>
            </div>
            <%-- 월 --%>
            <div id="basic_info_right_birthday_month" style="width:50px; position:relative; float:left;">
               <label for="month" style="font-size:16px; color: #747474;">&nbsp;Month</label>
            </div>
            <div id="basic_info_right_birthday_input_month" style="float:left; margin:7px 10px 0px -57px;">
               <fmt:formatDate value="${user.birthday}" var="month" type="date" pattern="MM" />
               <select name="mm" id="month" style="width:138px; border:2px solid #747474; border-radius: 6px; background-color: #FFFFFF; color: #000000; font-size:23px; height:60px; padding:18px 0px 0px 5px;" ></select>
            </div>
            <%-- 일 --%>
            <div id="basic_info_right_birthday_day" style="width:50px; position:relative; float:left;">
               <label for="day" style="font-size:16px; color: #747474;">&nbsp;Day</label>
            </div>
            <div id="basic_info_right_birthday_input_day" style="float:left; margin:7px 10px 0px -57px;">
               <fmt:formatDate value="${user.birthday}" var="day" type="date" pattern="dd" />
               <select name="dd" id="day" style="width:138px; border:2px solid #747474; border-radius: 6px; background-color: #FFFFFF; color: #000000; font-size:23px; height:60px; padding:18px 0px 0px 5px;" ></select>
            </div>
         </div>
         
         <%-- 비밀번호 --%>
         <div id="basic_info_right_password" style="width:60%; position:relative; float:left;">
            <label for="password" style="font-size:16px; color: #747474;">password</label>
         </div>
         <div id="basic_info_right_password_input" style="float:left; margin:-35px 10px 0px -17px;">
            <form:password path="password"  oninput=" upSubmitChk(); up_pwCheck(password.value);"
            style="width:355px; border:2px solid #747474; border-radius: 6px; background-color: #FFFFFF; color: #000000; font-size:23px; height:60px; padding:18px 0px 0px 15px;"/>
         </div>
         <div id="basic_info_right_password_check" style="position:relative; float:left; margin: -25px 0px 0px -50px">
            <span id="up_check" class="fa-regular fa-circle-check" style="color: green;"></span>
         </div>
         
         <div id="basic_info_right_password_submit" style="float:left; margin: -42px 0px 0px -5px">
            <input type="submit" id="up_submit" value="수정" style="border:2px solid #D5D5D5; border-radius: 6px; font-size:18px; width:60px; height:28px; color:#FFFFFF;">
         </div>
         
         <div id="basic_info_right_password_cancel" style="float:left; margin: -11px 0px 0px -5px">
                 <input type="button" id="update_cancel" value="취소" style="background-color:#FFBB00; border:2px solid #FFBB00; border-radius: 6px; font-size:18px; width:60px; height:28px; color:#FFFFFF;">
              </div>
              
      </div>
   </form:form>
   </div>
   <%-- basic_info_wrapper --%>
   <%-- basic_info_wrapper --%>
   <%-- basic_info_wrapper --%>
   <%-- 비밀번호 수정 --%>
   <div id="basic_pass_wrapper" style="border:1px solid #FFFFFF; border-radius: 5px; margin-bottom:50px; margin-top:120px; box-shadow: 0px 2px 4px 0px #1B1B1B;height:240px; ">
    
      <div id="basic_pass_left_inner" style="float:left; width:20%; height:230px; margin: 20px 0px 0px 50px; ">
         <div id="basic_pass_left_title" style="font-size:24px;">
            <span><b>비밀번호 변경</b></span>
         </div>
         <div id="basic_pass_left_desc" style="font-size:15px;">
            <p>주기적으로 비밀번호를 변경하여 타인의 무단 사용을 방지하세요.</p>
         </div>
      </div>
      
      <div id="basic_pass_right" style="float:left; width:55%; height:350px; margin: 10px 0px 0px 165px;">
      
              <form action="password" id="form" method="post" name="f" onsubmit="return inchk(this)">
              
            <%-- xxx --%>
            <div id="change_pass_right_password" style="width:60%; position:relative; float:left;">
               <input type="hidden" id="userid" value="${sessionScope.loginUser.userid}">
                 <input type="hidden" id="decesion">
               <label for="chg_password" style="font-size:16px; color: #747474;">password</label>
            </div>
            
            <div id="change_pass_right_password_input" style="float:left; margin:-35px 10px 0px -17px;">
               <input type="password" id="chg_password" name="password" oninput="chg_pwCheck(password.value)" style="width:420px; border:2px solid #747474; border-radius: 6px; background-color: #FFFFFF; color: #000000; font-size:23px; height:60px; padding:18px 0px 0px 15px;">
            </div>
            
            <div id="change_pass_right_password_check" style="position:relative; float:left; margin: -25px 0px 0px -50px">
               <span id="chg_check" class="fa-regular fa-circle-check" style="color: green;"></span>
            </div>
            <%-- xxx --%>
            
            <div id="change_pass_right_current" style="width:150px; position:relative; float:left;">
               <label for="chgpass" style="font-size:16px; color: #747474;">New password</label>
            </div>
            
            <div id="basic_info_right_birth_error" style="width:280px; position:relative; float:left; margin:-1px 0px 0px -10px; ">
               <label id="pwValid" for="chgpass" style="font-size:13px; color: #747474;">&nbsp;</label>
            </div>
             
             <div id="change_pass_right_password_input" style="float:left; margin:-35px 10px 0px -17px;">
               <input type="password" id="chgpass" name="chgpass" oninput="passValid()" style="width:420px; border:2px solid #747474; border-radius: 6px; background-color: #FFFFFF; color: #000000; font-size:23px; height:60px; padding:18px 0px 0px 15px;">
            </div>
            <%-- xxx --%>
            
             <div id="change_pass_right_curren2" style="width:220px; position:relative; float:left;">
               <label for="chgpass2" style="font-size:16px; color: #747474;">New password</label>
            </div>
            
             <div id="change_pass_right_password_input" style="float:left; margin:-35px 10px 0px -17px;">
               <input type="password" id="chgpass2" name="chgpass2" oninput="passValid()" style="width:355px; border:2px solid #747474; border-radius: 6px; background-color: #FFFFFF; color: #000000; font-size:23px; height:60px; padding:18px 0px 0px 15px;">
            </div>
            
             <div id="change_pass_right_button" style="float:left; margin: -35px 0px 0px -5px">
                <input type="submit" id="pw_submit" value="변경" style="border:2px solid #747474; border-radius: 6px; font-size:18px; width:60px; height:60px; color:#FFFFFF;">    
             </div>
            </form>
      </div>
   </div>
   
   <%-- 회원 탈퇴 --%>
   <div id="basic_delete_wrapper" style="transition-duration: 0.5s; border:1px solid #FFFFFF; border-radius: 5px; margin:120px 0px 50px 0px; box-shadow: 0px 2px 4px 0px #1B1B1B; height:160px; ">
    
      <div id="basic_delete_left_inner" style="float:left; width:20%; height:230px; margin: 20px 0px 0px 50px; ">
         <div id="basic_delete_left_title" style="font-size:24px;">
            <span><b>회원 탈퇴</b></span>
         </div>
         <div id="basic_delete_left_desc" style="font-size:15px;">
            <p>PIECA에서 사용되는 회원님의 정보를 삭제하며, 복구 불가능 합니다.</p>
         </div>
      </div>
      
      <div id="basic_delete_right" style="float:left; width:55%; height:350px; margin: 10px 0px 0px 165px;">
      
              <form method="post" action="delete" name="deleteForm">
              <input type="hidden" name="userid" value="${param.userid}">
            <%-- xxx --%>
            <div id="change_delete_right_password" style="width:60%; position:relative; float:left;">
               <input type="hidden" id="userid" value="${sessionScope.loginUser.userid}">
                 <input type="hidden" id="decesion">
               <label for="delete_password" style="font-size:16px; color: #747474;">password</label>
            </div>
            
            <div id="change_delete_right_password_input" style="float:left; margin:-35px 10px 0px -17px;">
               <input type="password" id="delete_password" name="password" oninput="delete_pwCheck(password.value)" style="width:420px; border:2px solid #747474; border-radius: 6px; background-color: #FFFFFF; color: #000000; font-size:23px; height:60px; padding:18px 0px 0px 15px;">
            </div>
            
            <div id="change_delete_right_password_check" style="position:relative; float:left; margin: -25px 0px 0px -50px">
               <span id="delete_check" class="fa-regular fa-circle-check" style="color: green;"></span>
            </div>
            <%-- xxx --%>
            <div id="change_delete_right_password_security" style="width:145px; position:relative; float:left;">
               <label for="sec_code" style="font-size:16px; color: #747474;">보안코드</label>
            </div>
            <div id="change_delete_right_password_security_show" style="float:left; margin:5px 10px 0px -162px;">
               <input type="text" id="security_code" readonly="readonly"  style="width:140px; border:2px solid #747474; border-radius: 6px; background-color: #FFFFFF; color: #000000; font-size:23px; height:60px; padding:18px 0px 0px 15px;">
            </div>
            <%-- xxx --%>
            <div id="change_delete_right_password_security2" style="width:110px; position:relative; float:left;">
               <label for="sec_code" style="font-size:16px; color: #747474;">보안코드 확인</label>
            </div>
            <div id="change_delete_right_password_security_input" style="float:left; margin:5px 10px 0px -126px;">
               <input type="text" id="security_code2" oninput="security_codeChk()" style="width:274px; border:2px solid #747474; border-radius: 6px; background-color: #FFFFFF; color: #000000; font-size:23px; height:60px; padding:18px 0px 0px 15px;">
            </div>
            <div id="change_delete_right_password_check2" style="position:relative; float:left; margin: 17px 0px 0px -50px">
               <span id="delete_check2" class="fa-regular fa-circle-check" style="color: green;"></span>
            </div>
            <%-- xxx --%>
            <div id="change_delete_right_password_check_logo" style="position:relative; float:left; margin: 12px 0px 0px 0px; font-size:35px;">
               <span id="delete_check" onclick="getRandomString();" class="fa-sharp fa-solid fa-arrows-rotate" style="color:#2196F3"></span>
            </div>
            <%-- xxx --%>
            
            
            
            <div>
  
  
  
</div>
            <%-- <a href="javascript:document.deleteForm.submit()">[회원탈퇴]</a>--%>
            <%-- xxx --%>
            
            </form>
      </div>
   </div>
   
  
  


</div> <%-- main --%>
<script type="text/javascript">

$(document).ready(function () {
   
   $("#username").attr("disabled","disabled");
   $("#email_original").attr("disabled","disabled");
   //$("#input_email").attr("disabled","disabled");
   $("#phoneno").attr("disabled","disabled");
   $("#birthday").attr("disabled","disabled");
   
   $("#select_email").hide();
   $("#input_email").hide();
   $("#basic_info_right_email_address").hide();
   $("#basic_info_right_birthday_input_update_s2").hide();
   
   $("#basic_info_right_update").show();
   $("#test11").hide()
   
   $("#basic_info_right_password").hide()
   $("#basic_info_right_password_input").hide();
   $("#basic_info_right_password_input").hide();
   $("#basic_info_right_password_submit").hide();
   $("#basic_info_right_password_cancel").hide();
   $("#change_delete_right_password_check_logo").hide();

   $("#chgpass").attr("disabled","disabled");
   $("#chgpass").css("background-color","#D5D5D5");
   $("#chgpass2").css("background-color","#D5D5D5");
   $("#chgpass2").attr("disabled","disabled");
   $("#pw_submit").attr("disabled","disabled");
   $("#up_submit").attr("disabled","disabled");
   $("#security_code2").attr("disabled","disabled");
   $("#pw_submit").css("background-color","#D5D5D5");
   $("#up_submit").css("background-color","#D5D5D5");
   $("#security_code").css("background-color","#D5D5D5");
   $("#security_code2").css("background-color","#D5D5D5");
   $("#up_check").hide();
   $("#chg_check").hide();
   $("#delete_check").hide();
   $("#delete_check2").hide();
   $("#update_info_wrapper").hide();
  });

$(document).ready(function(){
   $("#show_update").click(function(){
      var birthday = $("#birthday").val();
      var email_af = $("#email_af").val();
      
      username
      $("#start_name").val($("#username").val());
      $("#start_birthday").val(birthday);
      $("#start_phoneno").val($("#phoneno").val());
      $("#start_email").val($("#email_original").val());
      $("#start_email_be").val($("#input_email").val());
      
      
      $("#year").val(birthday.substring(0, 4))
      $("#month").val(birthday.substring(5, 7))
      $("#day").val(birthday.substring(8, 10))
      
      $("#mode_name").val('enable');
      $("#mode_email").val('enable');
      $("#mode_phone").val('enable');
   
      $("#select_email").val(email_af);
      $("#email_original").hide();
      $("#select_email").show();
      $("#input_email").show();
      $("#basic_info_right_email_address").show();
      
      $("#username").removeAttr("disabled");
      $("#email").removeAttr("disabled");
      $("#input_email").removeAttr("disabled");
      $("#phoneno").removeAttr("disabled");
      $("#birthday").removeAttr("disabled");
      $("#username").css("border","2px solid #747474");
      $("#email").css("border","2px solid #747474");
      $("#input_email").css("border","2px solid #747474");
      $("#phoneno").css("border","2px solid #747474");
      $("#birthday").css("border","2px solid #747474");
      
      $("#basic_info_wrapper").css("height","420px");
      $("#basic_info_right_update").hide(0);
      
      $("#basic_info_right_birthday_input_update_s1").hide();
      $("#basic_info_right_birthday_input_update_s2").show();
      
      $("#basic_info_right_password").slideDown(600);
      $("#basic_info_right_password_input").slideDown(610);
      $("#basic_info_right_password_submit").slideDown(610);
      $("#basic_info_right_password_cancel").slideDown(610);
   });
});

$(document).ready(function(){
   $("#update_cancel").click(function(){
      var email_af = $("#email_af").val();
      $("#username").val($("#start_name").val());
      $("#birthday").val($("#start_birthday").val());
      $("#phoneno").val($("#start_phoneno").val());
      $("#email_original").val($("#start_email").val());
      $("#input_email").val($("#start_email_be").val());
      
      $("#emailCheck").css("color","#ffffff");
      $("#phonenoCheck").text("");
      $("#password").val('')
      
      $("#mode_email").val('disable');
      $("#mode_phone").val('disable');
      
      $("#select_email").val(email_af);
      $("#email_original").show();
      $("#select_email").hide();
      $("#input_email").hide();
      $("#basic_info_right_email_address").hide();
      
      $("#username").attr("disabled","disabled");
      $("#email").attr("disabled","disabled");
      $("#input_email").attr("disabled","disabled");
      $("#phoneno").attr("disabled","disabled");
      $("#birthday").attr("disabled","disabled");
      
      $("#username").css("border","2px solid #FFFFFF");
      $("#email").css("border","2px solid #FFFFFF");
      $("#input_email").css("border","2px solid #FFFFFF");
      $("#phoneno").css("border","2px solid #FFFFFF");
      $("#birthday").css("border","2px solid #FFFFFF");
      
      $("#basic_info_wrapper").css("height","340px");
      $("#basic_info_right_update").show(0);
      
      $("#basic_info_right_birthday_input_update_s1").show();
      $("#basic_info_right_birthday_input_update_s2").hide();
      
      $("#basic_info_right_password").hide(0);
      $("#basic_info_right_password_input").hide(0);
      $("#basic_info_right_password_submit").hide(0);
      $("#basic_info_right_password_cancel").hide(0);
   });
});

function nameChk() {
   var username = $("#username").val();
   const reg = /^[가-힣a-zA-Z]+$/;
   if ((username != '') && (reg.test(username))) {
      $("#usernameCheck").text("사용 가능합니다.");
      $("#usernameCheck").css("color","green");
      $("#mode_name").val("enable");
   } else if (username == '') {
      $("#usernameCheck").text("이름을 입력하세요.");
      $("#usernameCheck").css("color","red");
      $("#mode_name").val("disable");
   } else if (!reg.test(username))  {
      $("#usernameCheck").text("옳바른 형식이 아닙니다.");
      $("#usernameCheck").css("color","red");
      $("#mode_name").val("disable");
   }
}

function emailChk() {
   var email_be = $("#input_email").val();
   var email_af = $("#select_email").val();
   $('#email').val(email_be + '@' + email_af);
   
   if ((email_be != '') && (email_af != null)) {
      $("#emailCheck").text("사용 가능합니다.");
      $("#emailCheck").css("color","green");
      $("#mode_email").val("enable");
   } else if (email_be == '') {
      $("#emailCheck").text("email을 입력하세요.");
      $("#emailCheck").css("color","red");
      $("#mode_email").val("disable");
   } else if (email_af == null)  {
      $("#emailCheck").text("주소를 선택하세요.");
      $("#emailCheck").css("color","red");
      $("#mode_email").val("disable");
   }
}

$("select[name=select_email]").change(function(){
   var email_be = $("#input_email").val();
   var email_af = $(this).val();
   $('#email').val(email_be + '@' + email_af);
});

function phonenoChk() {
   var phoneno = $("#phoneno").val();
   var phonenoLen = $("#phoneno").val().length;
   //
   var reg = /^[0-9]{10,11}$/

   if ((reg.test(phoneno)) && (!phoneno.match(/\-/g) ) ) {
      $("#phonenoCheck").text("사용 가능합니다.");
      $("#phonenoCheck").css("color","green");
      $("#mode_phone").val("enable");
   }  else if (phoneno.match(/\-/g)) {
      $("#phonenoCheck").text("' - '없이 입력하세요.");
      $("#phonenoCheck").css("color","red");
      $("#mode_phone").val("disable");
   } else if (!reg.test(phoneno)) {
      $("#phonenoCheck").text("10, 11자리로 숫자만 입력하세요.");
      $("#phonenoCheck").css("color","red");
      $("#mode_phone").val("disable");
   }
}

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

function upSubmitChk() {
   var mode_name = $("#mode_name").val();
   var mode_email = $("#mode_email").val();
   var mode_phone= $("#mode_phone").val();
   var mode_pass = $("#mode_pass").val();
   
   console.log('1.'+mode_name);
   console.log('2.'+mode_email);
   console.log('3.'+mode_phone);
   console.log('4.'+mode_pass);
   
   if ((mode_email == 'enable') && (mode_phone == 'enable') &&
   (mode_pass == 'enable') && (mode_name == 'enable')) {
      $("#up_submit").removeAttr("disabled");
      $("#up_submit").css("background-color","#2196F3");
      $("#up_submit").css("border","2px solid #2196F3");
   } else {
      $("#up_submit").attr("disabled","disabled");
      $("#up_submit").css("background-color","#D5D5D5");
      $("#up_submit").css("border","2px solid #D5D5D5");
   }
}


function up_pwCheck(password){
   $.ajax({
      type:"POST",
      url: "pwCheck",
      data : {"userid":$("#userid").val(),
            "password": password },
      success:function(result){
         if (result == true) {
            $("#mode_pass").val("enable");
            $("#up_check").show();
         } else {
            $("#mode_pass").val("disable");
            $("#up_check").hide();
         }
         upSubmitChk() // delay
      }
   });   
}
/*
$("#up_submit").removeAttr("disabled");
$("#up_submit").css("background-color","#2196F3");
$("#up_submit").css("border","2px solid #2196F3");
$("#up_submit").attr("disabled","disabled");
$("#up_submit").css("background-color","#D5D5D5");
$("#up_submit").css("border","2px solid #D5D5D5");
*/
function chg_pwCheck(password){
   console.log(password)
   $.ajax({
      type:"POST",
      url: "pwCheck",
      data : {"userid":$("#userid").val(),
            "password": password },
      success:function(result){
         console.log(result)
         if (result == true) {
            $("#chg_check").show();
            $('#decesion').val("ready");
            $("#chgpass").removeAttr("disabled");
            $("#chgpass").css("background-color","#FFFFFF");
         } else {
            $("#chg_check").hide();
            $('#decesion').val("not");
            $("#chgpass").attr("disabled","disabled");
            $("#chgpass").css("background-color","#D5D5D5");
         }
      }
   });   
}

function delete_pwCheck(password){
   $.ajax({
      type:"POST",
      url: "pwCheck",
      data : {"userid":$("#userid").val(),
            "password": password },
      success:function(result){
         console.log(result)
         if (result == true) {
            getRandomString();
            $("#delete_check").show();
            $("#security_code").removeAttr("disabled");
            $("#security_code2").removeAttr("disabled");
            $("#security_code").css("background-color","#FFFFFF");
            $("#security_code2").css("background-color","#FFFFFF");
            $("#security_code2").css("width","224px");
            $("#change_delete_right_password_check_logo").show();
         } else {
            $("#delete_check").hide();
            $("#delete_check2").hide();
            $("#security_code").val('');
            $("#security_code2").val('');
            $("#security_code").attr("disabled","disabled");
            $("#security_code2").attr("disabled","disabled");
            $("#security_code").css("background-color","#D5D5D5");
            $("#security_code2").css("background-color","#D5D5D5");
            $("#security_code2").css("width","274px");
            $("#change_delete_right_password_check_logo").hide();
         }
      }
   });   
}

function security_codeChk(){
   var security_code = $("#security_code").val();
   var security_code2 = $("#security_code2").val();
   console.log(security_code)
   console.log(security_code2)
   
   if (security_code == security_code2) {
      $("#delete_check2").show();
      $("#basic_delete_wrapper").css("height","260px");
   } else {
      $("#delete_check2").hide();
      $("#basic_delete_wrapper").css("height","160px");
   }
   
}

function getRandomString() {
   console.log('here')
   var letters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
     var randomString = "";
     for (var i = 0; i < 1; i++) {
       randomString += letters.charAt(Math.floor(Math.random() * letters.length));
     }
     $('#security_code').val(randomString);
       console.log('good')
   }

function preventCopy(e) {
     e = e || window.event;
     if (e.preventDefault) {
       e.preventDefault();
     } else {
       e.returnValue = false;
     }
   }

   $("input").on("copy", preventCopy);
   

function passValid(){
   var password = $("#chg_password").val();
   var chgpass = $("#chgpass").val();
   var chgpass2 = $("#chgpass2").val();
   var passDec = $("#passDec").val();
   var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~?!@#$%^&*_-]).{8,20}$/
   //reg.test(password) == true => 정규식 일치
   console.log(password)
   console.log(chgpass)
   if ((chgpass.length >= 8) && (chgpass.length <= 20) 
         && !(/(\w)\1\1/.test(chgpass))
         && !(chgpass.search(" ") != -1)
         && (reg.test(chgpass))
         && (password != chgpass)){ // 길이 만족할때
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
      $("#pwValid").text("대소문자, 숫자, 특수문자, 8~20자리");
      $("#pwValid").css("color","red");
      $("#passDec").val("false");
      $("#chgpass2").attr("disabled","disabled");
      $("#chgpass2").css("background-color","#D5D5D5");
   } else if (password == chgpass) {
      $("#pwValid").text("기존과 동일한 password 사용 불가");
      $("#pwValid").css("color","red");
      $("#passDec").val("false");
      $("#chgpass2").attr("disabled","disabled");
      $("#chgpass2").css("background-color","#D5D5D5");
   }
   
   if (chgpass != "" || chgpass2 != "") {
      if ((chgpass == chgpass2)) {
         $("#pwCheck").text("비밀번호가 일치합니다 :)");
         $("#pwCheck").css("color","green");
         $("#pw_submit").removeAttr("disabled");
         $("#pw_submit").css("background-color","#2196F3");
         $("#pw_submit").css("border","2px solid #2196F3");
      } else if (chgpass != chgpass2) {
         $("#pwCheck").text("비밀번호가 일치하지 않습니다.");
         $("#pwCheck").css("color","red");
         $("#pw_submit").attr("disabled","disabled");
         $("#pw_submit").css("background-color","#D5D5D5");
         $("#pw_submit").css("border","2px solid #D5D5D5");
      }   
   }
}


</script>

</body>

</html>