<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- /shop1/src/main/webapp/WEB-INF/view/user/pwsearch.jsp--%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div style="width:80%; margin:0% 0% 0% 19.5%;">
	<h2 style="width:80%; text-align: center;">PIECA</h2>
	<form:form modelAttribute="user" action="pwsearch" method="post">
	
	<div style="display: inline;">
		아이디
	</div>
	<div style="display: inline; font-size: 13px;">
		<font color="red"><form:errors path="userid" /></font>
	</div>
	<div style="margin:5px 0px 20px 0px; ">
		<input type="text" name="userid" style="border:1px solid #747474; border-radius: 6px; font-size:15px; width:75%; height:40px;" placeholder="   아이디를 입력 해주세요.">
	</div>
			
	<div style="display: inline;">		
		이메일
	</div>
	<div style="display: inline; font-size: 13px;">
		<font color="red"><form:errors path="email" /></font>
	</div>
	<div style="margin:5px 0px 20px 0px; ">	
		<input type="text" name="email" style="border:1px solid #747474; border-radius: 6px; font-size:15px; width:75%; height:40px;" placeholder="   이메일을 입력 해주세요.">
	</div>
			
	<div style="display: inline;">			
		전화번호
	</div>
	<div style="display: inline; font-size: 13px;">
		<font color="red"><form:errors path="phoneno" /></font>
	</div>
	<div style="margin:5px 0px 20px 0px; ">
		<input type="text" name="phoneno" style="border:1px solid #747474; border-radius: 6px; font-size:15px; width:75%; height:40px;" placeholder="   핸드폰번호를 ' - ' 없이 입력 해주세요.">
	</div>
			
	<div style="font-size: 13px; margin:0px 0px 10px 0px;">
		<spring:hasBindErrors name="user">
			<font color="red">
				<c:forEach items="${errors.globalErrors}" var="error">
					<spring:message code="${error.code}" />
				</c:forEach>
			</font>
		</spring:hasBindErrors>
	</div>
	
	<div style="font-size: 15px; margin:0px 0px 20px 0px;">
		<c:if test="${not empty result}">
			<input type="text" id="result" value="${result}로 초기화 되었습니다." style="border:none; outline:none; width:75%; height:20px;" readonly="readonly">
		</c:if>
	</div>
		
	<input type="submit" id="submit" value="비밀번호 검색"style="width:37.5%; height:44px; border:1px solid #00B6EF; border-radius: 6px; background-color: #00B6EF;font-size: 18px; color:white; cursor:pointer;">
	<input type="button" id="send_button" value="비밀번호 전송" onclick="pwSend();" style="width:37.5%; height:44px; border:1px solid #00B6EF; border-radius: 6px; font-size: 18px; color:white; cursor:pointer;">			
	</form:form>
	</div>
<script>
function pwSend() {
	opener.document.loginform.password.value='${result}';
	self.close();
}

$(document).ready(function () {
	$("#send_button").attr("disabled",true);
	$("#send_button").css("background-color","#BDBDBD");
	$("#send_button").css("border","none");
  });
  
$(function()  {
	var result = $("#result").val();
	if (result != null) {
		$("#send_button").attr("disabled",false);
		$("#send_button").css("background-color","#FFBB00");		
	} else {
		$("#send_button").attr("disabled",true);
		$("#send_button").css("background-color","#BDBDBD");
	}
	
})
</script>	
</body>
</html>