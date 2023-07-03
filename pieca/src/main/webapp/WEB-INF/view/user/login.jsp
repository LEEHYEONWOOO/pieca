<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%-- /shop1/src/main/webapp/WEB-INF/view/user/login.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인화면</title>
<script type="text/javascript"
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
</head>
<body>
<div id="login_container">
   <form:form modelAttribute="user" method="post" action="login"
      name="loginform">
      <input type="hidden" name="username" value="유효성검증을위한데이터">
      <input type="hidden" name="email" value="a@a.a">
      <input type="hidden" name="birthday" value="2000-01-01">
      
      <div id="login_global_error">
         <spring:hasBindErrors name="user">
            <font color="red">
               <c:forEach items="${errors.globalErrors}" var="error">
                  <spring:message code="${error.code}" />
               </c:forEach
            ></font>
         </spring:hasBindErrors>   
      </div>
         
      <div id="login_userid_input">
         <form:input path="userid" id="login_input_userid" placeholder="아이디 입력"/>
      </div>
      
      <div id="login_password_input">
         <form:password path="password" id="login_input_password" placeholder="비밀번호 입력"/>
      </div>
      
      <div id="login_submit_container">
         <input type="submit" id="login_submit_button" value="로그인">
      </div>
      <div id="login_naver_container">
         <a href="${apiURL}"><img width="300px;" height="70px;" src="../img/login_naver.png"></a>
      </div>
      <div id="login_kakao_container">
           <a href="../user/kakao_connect"><img width="300px;" height="70px;"src="../img/kakao_login.png"></a>
         </div>
      <div id="login_etc_container">
         <a href="../user/join">회원 가입</a>
         <span>&nbsp;&nbsp;|&nbsp;&nbsp;</span>
         <a href="javascript:win_open('idsearch')" style="text-decoration: none; color:black;">아이디 찾기</a>
         <span>&nbsp;&nbsp;|&nbsp;&nbsp;</span>
         <a href="javascript:win_open('pwsearch')" style="text-decoration: none; color:black;">비밀번호 찾기</a>
      </div>
      
   </form:form>
   </div>
<script>
function win_open(page) {
      var op = "width=500, height=500, left=50,top=150";
      open(page ,"",op);
}
</script>
</body>
</html>