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
	<h4>PIEKA의 회원이 되어보세요!</h4>
	<form:form modelAttribute="user" method="post" action="join">
	<%-- 
		<spring:hasBindErrors name="user">
			<font color="red"> <%-- ${errors.globalErrors} : controller에서 bresult.reject(코드값)메서드로
                              추가한 error 코드 값들
 --%> <%--<c:forEach items="${errors.globalErrors}" var="error">
					
    <spring:message code="${error.code}" /> : 코드값에 해당하는 메세지를 출력
                                        현재 messages.properties 파일에 설정
    ${error.code} : reject(코드값)으로 등록한 코드값
 
					<spring:message code="${error.code}" />
					<br>
				</c:forEach>
			</font>
		</spring:hasBindErrors>
--%>
		<div style="display: inline;">
			아이디
		</div>
		<div style="display: inline; font-size: 13px;">
			<font color="red"><form:errors path="userid" /></font>
		</div>
		<div style="margin:5px 0px 20px 0px; ">
			<form:input path="userid" id="input_userid" style="border:1px solid #747474; border-radius: 10px; font-size:15px; width:60%; height:40px;" placeholder="   아이디 입력 (6~20자)"/>
			<button>중복 확인</button>
		</div>
		
		<div style="display: inline;">
			비밀번호
		</div>
		<div style="display: inline; font-size: 13px;">
			<font color="red"><form:errors path="password" /></font>
		</div>
		<div style="margin:5px 0px 20px 0px; ">
			<form:password path="password" id="input_password" style="border:1px solid #747474; border-radius: 10px; font-size:15px; width:80%; height:40px;" placeholder="   비밀번호 입력 (영문자, 숫자, 특수문자 포함 8~20자)"/>
		</div>
		
		<div style="display: inline;">
			비밀번호 확인
		</div>
		<div style="display: inline; font-size: 13px;">
			<font color="red">에이작에서 오는 알람메세지 영역</font>
		</div>
		<div style="margin:5px 0px 20px 0px; ">
			<input type="password" id="input_password2" style="border:1px solid #747474; border-radius: 10px; font-size:15px; width:80%; height:40px;" placeholder="   비밀번호 입력 (영문자, 숫자, 특수문자 포함 8~20자)">
		</div>
		
		<div style="display: inline;">
			이름
		</div>
		<div style="display: inline; font-size: 13px;">
			<font color="red"><form:errors path="username" /></font>
		</div>
		<div style="margin:5px 0px 20px 0px; ">
			<form:input path="username" id="input_username" style="border:1px solid #747474; border-radius: 10px; font-size:15px; width:80%; height:40px;" placeholder="   이름을 입력 해주세요."/>
		</div>
				
				
		<div style="display: inline;">
			전화번호
		</div>
		<div style="display: inline; font-size: 13px;">
			<font color="red"><form:errors path="phoneno" /></font>
		</div>
		<div style="margin:5px 0px 20px 0px; ">
			<form:input path="phoneno"  id="input_phoneno" style="border:1px solid #747474; border-radius: 10px; font-size:15px; width:80%; height:40px;" placeholder="   휴대폰 번호 입력 ( ' - ' 제외 11자리)"/>		
		</div>				
			
		<div style="display: inline;">
			이메일
		</div>
		<div style="display: inline; font-size: 13px;">
			<font color="red"><form:errors path="email" /></font>
		</div>				
		<div style="margin:5px 0px 20px 0px;">
			<form:input path="email" id="input_email" style="border:1px solid #747474; border-radius: 10px; font-size:15px; width:38.2%; height:40px;" placeholder="   이메일 주소"/>
			<span>@</span>
 			<select id="select" style="border:1px solid #747474; border-radius: 10px; font-size:15px; width:37.5%; height:40px;">
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
		<div style="margin:5px 0px 20px 0px;">
			<form:hidden path="birthday" id="birthday" />
			<select name="yy" id="year" style="margin-right:19.5px; border:1px solid #747474; border-radius: 10px; font-size:15px; width:24%; height:40px;" ></select>
			<select name="mm" id="month" style="margin-right:19.5px; border:1px solid #747474; border-radius: 10px; font-size:15px; width:24%; height:40px;"></select>
			<select name="dd" id="day" style="border:1px solid #747474; border-radius: 5px; font-size:15px; width:24%; height:40px;"></select>
		</div>			
		
		<input type="submit" value="회원가입" style=" width:40%; height:40px; border:1px solid #747474; border-radius: 5px;">
		<input type="reset" value="초기화" style=" width:40%; height:40px;border:1px solid #747474; border-radius: 5px;">
	</form:form>
	<script>
	$("select[name=yy]").change(function(){
		var year = $("#year").val();
		var month = $("#month").val();
		var day = $("#day").val();
		$('#birthday').val(year+month+day);
	});
	
	$("select[name=mm]").change(function(){
		var year = $("#year").val();
		var month = $("#month").val();
		var day = $("#day").val();
		$('#birthday').val(year+month+day);
	});
	
	$("select[name=dd]").change(function(){
		var year = $("#year").val();
		var month = $("#month").val();
		var day = $("#day").val();
		$('#birthday').val(year+month+day);
	});
	
	$(document).ready(function(){            
	    var now = new Date();
	    var year = now.getFullYear();
	    var mon = (now.getMonth() + 1) > 9 ? ''+(now.getMonth() + 1) : '0'+(now.getMonth() + 1); 
	    var day = (now.getDate()) > 9 ? ''+(now.getDate()) : '0'+(now.getDate());           
	    //년도 selectbox만들기               
	    for(var i = 1900 ; i <= year ; i++) {
	        $('#year').append('<option value="' + i + '">' + i + '</option>');    
	    }

	    // 월별 selectbox 만들기            
	    for(var i=1; i <= 12; i++) {
	        var mm = i > 9 ? i : "0"+i ;            
	        $('#month').append('<option value="' + mm + '">' + mm + '</option>');    
	    }
	    
	    // 일별 selectbox 만들기
	    for(var i=1; i <= 31; i++) {
	        var dd = i > 9 ? i : "0"+i ;            
	        $('#day').append('<option value="' + dd + '">' + dd+ '</option>');    
	    }
	    $("#year  > option[value="+year+"]").attr("selected", "true");        
	    $("#month  > option[value="+mon+"]").attr("selected", "true");    
	    $("#day  > option[value="+day+"]").attr("selected", "true");       
	  
	})
	</script>
</body>
</html>