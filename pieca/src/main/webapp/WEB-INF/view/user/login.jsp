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
	<h2>사용자 로그인</h2>
	<form:form modelAttribute="user" method="post" action="login"
		name="loginform">
		<input type="hidden" name="username" value="유효성검증을위한데이터">
		<input type="hidden" name="email" value="a@a.a">
		<input type="hidden" name="birthday" value="2000-01-01">
		<spring:hasBindErrors name="user">
			<font color="red"><c:forEach items="${errors.globalErrors}"
					var="error">
					<spring:message code="${error.code}" />
				</c:forEach></font>
		</spring:hasBindErrors>
		<input type="hidden" id="decesion">
				아이디
		<form:input path="userid" />
		<font color="red"><form:errors path="userid" /></font>
		비밀번호<form:password path="password" oninput="pwCheck(password.value)" />
		<font color="red"><form:errors path="password" /></font>
		<input type="submit" onclick="winLogin()" value="로그인">
		<input type="button" value="회원가입" onclick="winOpen('join')">
		<input type="button" value="아이디찾기" onclick="winOpen('idsearch')">
		<input type="button" value="비밀번호찾기" onclick="winOpen('pwsearch')">
		<p>
			<a href="${apiURL}"><img height="30"
				src="http://static.nid.naver.com/oauth/small_g_in.PNG"></a>
	</form:form>
	
<script>
function winOpen(page) {
	var link = "join"
	location.href=link;
	location.replace(link);
	window.open(link);
}

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
</script>
</body>
</html>