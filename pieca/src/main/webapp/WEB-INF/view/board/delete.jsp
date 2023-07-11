<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%-- /shop1/src/main/webapp/WEB-INF/view/board/delete.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 삭제 화면</title>
</head>
<body>
<div style="width:1920px; height:750px; display: flex; justify-content: center; align-items: center;">
   <form action="delete" method="post" name="f">
      <input type="hidden" name="num" value="${param.num}">
      <table class="w3-table-all" style="width:600px; font-size:20px;">
         <div style="width:380px; font-size:25px; display:inline; margin-left: 37%;">
            게시글 삭제
         </div>
         <div style="width: 200px; display:inline;">
            <spring:hasBindErrors name="board">
               <font color="red" size="4px">
                  <c:forEach items="${errors.globalErrors}" var="error">
                     <spring:message code="${error.code }" />
                  </c:forEach>
               </font>
            </spring:hasBindErrors>
         </div>
         <tr>
            <td colspan="2"><input type="password" name="pass" placeholder="비밀번호 입력"
               class="w3-input" style="border:0px solid #FFFFFF;"/></td>
            <td style = "vertical-align: middle; text-align: center;">
            <a href="javascript:document.f.submit()">삭제</a>
            </td>
         </tr>
      </table>
   </form>
</div>
</body>
</html>