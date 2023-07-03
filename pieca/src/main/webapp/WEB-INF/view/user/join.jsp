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
<div id="join_container">
   <form:form modelAttribute="user" method="post" action="join">
      <div id="join_userid_title">
         아이디
      </div>
      <div id="join_userid_error">
         <font color="red"><form:errors path="userid" /></font>
         <div id="join_idCheck"></div>
      </div>
      <div id="join_userid_input">
         <form:input path="userid" id="join_input_userid" oninput="idCheck(); joinSubmitChk();" placeholder="아이디 입력 (6~20자)"/>
      </div>
      
      <div id="join_password_title">
         <input type="hidden" id="join_passDec">
         비밀번호
      </div>
      <div id="join_password_error">
         <font color="red"><form:errors path="password" /></font>
         <div id="join_pwValid"></div>
      </div>
      <div id="join_password_input">
         <form:password path="password" id="join_input_password" oninput="passValid(); joinSubmitChk();" placeholder="비밀번호 입력 (대소문자, 숫자, 특수문자 포함 8~20자)"/>
      </div>
      
      <div id="join_password2_title">
         비밀번호 확인
      </div>
      <div id="join_pwCheck"></div>
      <div id="join_password2_input">
         <input type="password" id="join_input_password2" oninput="passValid(); joinSubmitChk();" placeholder="비밀번호 먼저 검증 받으세요.">
      </div>
      
      <div id="join_username_title">
         이름
      </div>
      <div id="join_username_error">
         <font color="red"><form:errors path="username" /></font>
         <div id="join_nameChk"></div>
      </div>
      <div id="join_username_input">
         <form:input path="username" id="join_input_username" oninput="nameChk(); joinSubmitChk();" placeholder="이름을 입력 해주세요."/>
      </div>
            
            
      <div id="join_phoneno_title">
         전화번호
      </div>
      <div id="join_phoneno_error">
         <font color="red"><form:errors path="phoneno" /></font>
         <div id="join_phoneChk"></div>
      </div>
      <div id="join_phoneno_input">
         <form:input path="phoneno" id="join_input_phoneno" oninput="phonenoChk(); joinSubmitChk();" placeholder="휴대폰 번호 입력 ( ' - ' 제외 11자리)"/>      
      </div>            
         
      <div id="join_email_title">
         이메일
      </div>
      <div id="join_email_error">
         <font color="red"><form:errors path="email" /></font>
         <div id="join_emailChk"></div>
      </div>            
      <div id="join_email_input">
         <form:hidden path="email" id="join_email"/>
         <input type="text" id="join_input_email" oninput="emailChk();" placeholder="이메일 주소"/>
         <span>@</span>
          <select name="select_email" id="join_select_email" onfocus="emailChk(); joinSubmitChk();" onchange="emailChk(); joinSubmitChk();">
               <option value="" disabled selected>E-Mail 선택</option>
               <option value="naver.com" id="naver.com">naver.com</option>
               <option value="gmail.com" id="gmail.com">gmail.com</option>
               <option value="hanmail.net" id="hanmail.net">hanmail.net</option>
               <option value="nate.com" id="nate.com">nate.com</option>
           </select>
      </div>
      
      <div id="join_birthday_title">
         생년월일
      </div>
      <div id="join_birthday_error">
         <font color="red"><form:errors path="birthday" /></font>
         <div id="join_birthdayChk"></div>
      </div>
      <div id="join_birthday_input">
         <form:hidden path="birthday" id="join_birthday" />
         <select name="yy" id="join_year" onchange="birthChk(); joinSubmitChk();"></select>
         <select name="mm" id="join_month" onchange="birthChk(); joinSubmitChk();"></select>
         <select name="dd" id="join_day" onchange="birthChk(); joinSubmitChk();"></select>
      </div>         
      
      <input type="submit" id="join_submit" value="회원가입">
      <input type="reset" id="join_reset" value="초기화">
   </form:form>
   </div>
   
   <input type="hidden" id="join_mode_userid">
   <input type="hidden" id="join_mode_pass">
   <input type="hidden" id="join_mode_name">
   <input type="hidden" id="join_mode_phone">
   <input type="hidden" id="join_mode_email">
   <input type="hidden" id="join_mode_birth">
   
<script>

$(document).ready(function () {
   $("#join_input_password2").attr("disabled","disabled");
   $("#join_submit").attr("disabled","disabled");
   $("#join_submit").css("background-color","#D5D5D5");
  });

function idCheck(){
   
   var userid = $('#join_input_userid').val();
   $.ajax({
      type:"POST",
      url: "idConfirm",
      data : {"userid":userid},
      success:function(result){
         if ((userid.length >= 6) && (userid.length <= 20)) {
            if ((result == true) && !(userid.search(" ") != -1)) {
               $("#join_idCheck").text("사용 가능합니다.");
               $("#join_idCheck").css("color","green");
               $("#join_mode_userid").val("enable");
               joinSubmitChk()
            } else if (result == false) {
               $("#join_idCheck").text("이미 사용중입니다.");
               $("#join_idCheck").css("color","red");
               $("#join_mode_userid").val("disable");
               joinSubmitChk()
            } else if (userid.search(" ") != -1) {
               $("#join_idCheck").text("아이디에 공백은 사용 불가능합니다.");
               $("#join_idCheck").css("color","red");
               $("#join_mode_userid").val("disable");
               joinSubmitChk()
            }
         } else {
            $("#join_idCheck").text("아이디는 6자 이상, 20자 이하이여야 합니다.");
            $("#join_idCheck").css("color","red");
            $("#join_mode_userid").val("disable");
            joinSubmitChk()
         }
      }
   });   
}

function passValid(){
   var password = $("#join_input_password").val();
   var password2 = $("#join_input_password2").val();
   var passDec = $("#join_passDec").val();
   var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~?!@#$%^&*_-]).{8,20}$/
   //reg.test(password) == true => 정규식 일치
   
   if ((password.length >= 8) && (password.length <= 20) 
         && !(/(\w)\1\1/.test(password))
         && !(password.search(" ") != -1)
         && (reg.test(password))){ // 길이 만족할때
      $("#join_pwValid").text("사용 가능합니다.");
      $("#join_pwValid").css("color","green");
      $("#join_passDec").val("true");
      $("#join_input_password2").removeAttr("disabled");
      $("#join_mode_pass").val("enable");
   } else if (/(\w)\1\1/.test(password)) {
      $("#join_pwValid").text("3번이상 반복되는 문자는 사용 불가능 합니다.");
      $("#join_pwValid").css("color","red");
      $("#join_passDec").val("false");
      $("#join_input_password2").attr("disabled","disabled");
      $("#join_mode_pass").val("disable");
   } else if (password.search(" ") != -1) {
      $("#join_pwValid").text("공백은 사용 불가능 합니다.");
      $("#join_pwValid").css("color","red");
      $("#join_passDec").val("false");
      $("#join_input_password2").attr("disabled","disabled");
      $("#join_mode_pass").val("disable");
   } else if (!reg.test(password)) {
      $("#join_pwValid").text("대소문자, 숫자, 특수문자가 포함 8~20자리이어야 합니다.");
      $("#join_pwValid").css("color","red");
      $("#join_passDec").val("false");
      $("#join_input_password2").attr("disabled","disabled");
      $("#join_mode_pass").val("disable");
   }
   
   
   if (password != "" || password2 != "") {
      if ((password == password2)) {
         $("#join_pwCheck").text("비밀번호가 일치합니다.");
         $("#join_pwCheck").css("color","green");
         
         $("#join_mode_pass").val("enable");
      } else if (password != password2) {
         $("#join_pwCheck").text("비밀번호가 일치하지 않습니다.");
         $("#join_pwCheck").css("color","red");
         
         $("#join_mode_pass").val("disable");
      }   
   }
}

function nameChk() {
   var username = $("#join_input_username").val();
   var reg1 = /[가-힣]/;
   var reg2 = /[ㄱ-ㅎㅏ-ㅣ]/;
   var reg3 = /[0-9]/;
   var reg4 =  /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/;
   var reg5 =  /[a-z]/;
   console.log(username)
   if ((reg1.test(username)) && (!reg2.test(username))
      && (!reg3.test(username)) && (!reg4.test(username))
      && !(username.search(" ") != -1) && (username != '')
      && (!reg5.test(username))) {
      $("#join_nameChk").text("사용 가능합니다.");
      $("#join_nameChk").css("color","green");
      $("#join_mode_name").val("enable");
   } else if (reg2.test(username)) {
      $("#join_nameChk").text("자음,모음 개별로 사용 불가능 합니다.");
      $("#join_nameChk").css("color","red");
      $("#join_mode_name").val("disable");
   } else if (reg3.test(username)) {
      $("#join_nameChk").text("숫자는 사용 불가능 합니다.");
      $("#join_nameChk").css("color","red");
      $("#join_mode_name").val("disable");
   } else if (reg4.test(username)) {
      $("#join_nameChk").text("특수문자는 사용 불가능 합니다.");
      $("#join_nameChk").css("color","red");
      $("#join_mode_name").val("disable");
   } else if (reg5.test(username)) {
      $("#join_nameChk").text("외국인은 관리자에게 문의 하세요.");
      $("#join_nameChk").css("color","red");
      $("#join_mode_name").val("disable");
   } else if (username.search(" ") != -1) {
      $("#join_nameChk").text("공백은 사용 불가능 합니다.");
      $("#join_nameChk").css("color","red");
      $("#join_mode_name").val("disable");
   } else if (username == '') {
      $("#join_nameChk").text("이름을 입력 해주세요.");
      $("#join_nameChk").css("color","red");
      $("#join_mode_name").val("disable");
   }
}

function phonenoChk() {
   var phoneno = $("#join_input_phoneno").val();
   var phonenoLen = $("#join_input_phoneno").val().length;
   var reg = /^[0-9]{10,11}$/
   
   if ((reg.test(phoneno)) && (!phoneno.match(/\-/g) )) {
      $("#join_phoneChk").text("사용 가능합니다.");
      $("#join_phoneChk").css("color","green");
      $("#join_mode_phone").val("enable");
   }  else if (phoneno.match(/\-/g)) {
      $("#join_phoneChk").text("' - '없이 입력하세요.");
      $("#join_phoneChk").css("color","red");
      $("#join_mode_phone").val("disable");
   } else if (!reg.test(phoneno)) {
      $("#join_phoneChk").text("10, 11자리로 숫자만 입력하세요.");
      $("#join_phoneChk").css("color","red");
      $("#join_mode_phone").val("disable");
   }
}


function emailChk() {
   joinSubmitChk()
   var email_be = $("#join_input_email").val();
   var email_af = $("#join_select_email").val();
   $('#join_email').val(email_be + '@' + email_af);
   console.log(email_af)
   if (!(email_be.search(" ") != -1) && (email_af != null) && (email_be != '')) {
      $("#join_emailChk").text("사용 가능합니다.");
      $("#join_emailChk").css("color","green");
      $("#join_mode_email").val("enable");
   } else if (email_be.search(" ") != -1) {
      $("#join_emailChk").text("공백은 사용 불가능 합니다.");
      $("#join_emailChk").css("color","red");
      $("#join_mode_email").val("disable");
   } else if ((email_be == '') && (email_af == null)){
      $("#join_emailChk").text("주소를 입력 하시고 도메인을 선택 해주세요.");
      $("#join_emailChk").css("color","red");
      $("#join_mode_email").val("disable");
   } else if ((email_be == '') && (email_af != null)){
      $("#join_emailChk").text("주소를 입력 해주세요.");
      $("#join_emailChk").css("color","red");
      $("#join_mode_email").val("disable");
   } else if ((email_be != '') && (email_af == null)){
      $("#join_emailChk").text("도메인을 선택 해주세요.");
      $("#join_emailChk").css("color","red");
      $("#join_mode_email").val("disable");
   } 
}

function birthChk() {
   joinSubmitChk()
   var year = $("#join_year").val();
   var month = $("#join_month").val();
   var day = $("#join_day").val();
   var birthday = year + '-' + month + '-' + day
   $('#join_birthday').val(birthday);
   
   var date = new Date();
   var year = date.getFullYear();
   var month = date.getMonth() + 1;
   var day = date.getDate();
   var nowdate = year+"-"+(("00"+month.toString()).slice(-2))+"-"+(("00"+day.toString()).slice(-2));
   
   if (birthday <= nowdate) {
      $("#join_birthdayChk").text("사용 가능합니다.");
      $("#join_birthdayChk").css("color","green");
      $("#join_mode_birth").val("enable");
      joinSubmitChk()
   } else {
      $("#join_birthdayChk").text("오늘 이후의 생년월일은 사용 불가능 합니다.");
      $("#join_birthdayChk").css("color","red");
      $("#join_mode_birth").val("disable");
      joinSubmitChk()
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
      $('#join_year').append('<option value="' + i + '">' + i + '</option>');
   }
                     // 월별 selectbox 만들기            
   for (var i = 1; i <= 12; i++) {
      var mm = i > 9 ? i : "0" + i;
      $('#join_month').append('<option value="' + mm + '">' + mm + '</option>');
   }
   
   // 일별 selectbox 만들기
   for (var i = 1; i <= 31; i++) {
      var dd = i > 9 ? i : "0" + i;
      $('#join_day').append('<option value="' + dd + '">' + dd + '</option>');
   }
   $("#join_year  > option[value=" + year + "]").attr("selected", "true");
   $("#join_month  > option[value=" + mon + "]").attr("selected", "true");
   $("#join_day  > option[value=" + day + "]").attr("selected", "true");
})

function joinSubmitChk() {
   var mode_userid= $("#join_mode_userid").val();
   var mode_pass = $("#join_mode_pass").val();
   var mode_name= $("#join_mode_name").val();
   var mode_phone = $("#join_mode_phone").val();
   var mode_email = $("#join_mode_email").val();
   var mode_birth = $("#join_mode_birth").val();
   
   if ((mode_userid == 'enable')
   && (mode_pass == 'enable')
   && (mode_name == 'enable')
   && (mode_phone == 'enable')
   && (mode_email == 'enable')
   && (mode_birth == 'enable') ) {
      $("#join_submit").removeAttr("disabled");
      $("#join_submit").css("background-color","#2196F3");
      $("#join_submit").css("border","2px solid #2196F3");
   } else {
      $("#join_submit").attr("disabled","disabled");
      $("#join_submit").css("background-color","#D5D5D5");
      $("#join_submit").css("border","2px solid #D5D5D5");
   }
}   
</script>
</body>
</html>