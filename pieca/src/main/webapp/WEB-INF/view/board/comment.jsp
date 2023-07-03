<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<form:form modelAttribute="comment" action="comment" method="post">
  <form:hidden  path="num" />
  <div class="w3-row">
    <div class="w3-col s2  w3-center">
     <p><form:input path="writer" class="w3-input w3-border" />
       <font color="red"><form:errors path="writer" /></font></p>
     </div>
    <div class="w3-col s9  w3-center">
     <p><form:input path="content" class="w3-input w3-border"/>
         <font color="red"><form:errors path="content" /></font></p></div>
    <div class="w3-col s1  w3-center">
     <p><button type="submit" class="w3-btn w3-border">댓글등록</button></p></div>
  </div>
  </form:form>
