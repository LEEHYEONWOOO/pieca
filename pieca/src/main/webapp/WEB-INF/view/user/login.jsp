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
<div style="width:100%; height:450px; margin: 10% 0% 10% 42.2%;">
	<h2 style="width:300px; margin-bottom:70px; text-align: center;">PIECA</h2>
	<form:form modelAttribute="user" method="post" action="login"
		name="loginform">
		<input type="hidden" name="username" value="유효성검증을위한데이터">
		<input type="hidden" name="email" value="a@a.a">
		<input type="hidden" name="birthday" value="2000-01-01">
		
		<div style="width:300px; font-size: 13px; margin:0px 0px 10px 0px;">
			<spring:hasBindErrors name="user">
				<font color="red">
					<c:forEach items="${errors.globalErrors}" var="error">
						<spring:message code="${error.code}" />
					</c:forEach
				></font>
			</spring:hasBindErrors>	
		</div>
			
		<div style="margin:15px 0px 20px 0px; ">
			<form:input path="userid" id="input_userid" style="border:1px solid #747474; border-radius: 6px; font-size:15px; width:300px; height:50px;" placeholder="   아이디 입력"/>
		</div>
		
		<div style="margin:5px 0px 20px 0px; ">
			<form:password path="password" id="input_password" style="border:1px solid #747474; border-radius: 6px; font-size:15px; width:300px; height:50px;" placeholder="   비밀번호 입력"/>
		</div>
		
		<div style="display: inline; ">
			<input type="submit" value="로그인" style="width:300px; height:44px; border:1px solid #00B6EF; border-radius: 6px; background-color: #00B6EF;font-size: 18px; color:white; cursor:pointer;">
		</div>
		
		<div style="font-size: 14px; width:300px; text-align:center; margin: 20px 0px 20px 0px">
			<a href="../user/join" style="text-decoration: none; color:black;">회원 가입</a>
			<span>&nbsp;&nbsp;|&nbsp;&nbsp;</span>
			<a href="javascript:win_open('idsearch')" style="text-decoration: none; color:black;">아이디 찾기</a>
			<span>&nbsp;&nbsp;|&nbsp;&nbsp;</span>
			<a href="javascript:win_open('pwsearch')" style="text-decoration: none; color:black;">비밀번호 찾기</a>
		</div>
		<div style="display: inline; font-size: 13px;">
			<a href="${apiURL}"><img width="140px;" src="../img/login_naver2.png"></a>
		</div>
	</form:form>
	</div>
<script>
function win_open(page) {
	   var op = "width=500, height=450, left=50,top=150";
	   open(page ,"",op);
}

<%--
function winOpen(page) {
	var link = page
	if (link == 'join') window.resizeTo(600,950);
	if (link == 'idsearch') window.resizeTo(616,467);
	if (link == 'pwsearch') window.resizeTo(616,507);
	location.href=link;
	location.replace(link);
}

function winLogin()
{	
	var decesion = $("#decesion").val();
	
	if (decesion == "ready") {
		window.opener.name ="parentPage";
		document.loginform.target ="parentPage";
		document.loginform.submit();
		window.open('','_self').close();
	}
}
--%>

</script>
</body>
</html>