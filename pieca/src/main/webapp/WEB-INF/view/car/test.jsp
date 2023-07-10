<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Main</title>
</head>
<body>
<button onclick="changeList()">리스트 변경</button>
<ul>
<c:forEach items="${list}" var="item">
<li>${item}</li>
</c:forEach>
</ul>

<script>
function changeList() {
	  // list 객체의 요소를 변경합니다.
	  $("#list")=[1,2]
	}
</script>
</body>
</html>