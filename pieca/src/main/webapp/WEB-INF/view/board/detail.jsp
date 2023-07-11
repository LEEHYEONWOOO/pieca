<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%-- /shop1/src/main/webapp/WEB-INF/view/board/detail.jsp
    Controller,ShopService, BoardDao 구현.  
       1. num파라미터에 해당하는 게시물 정보를 board 객체 전달. 
          service.getBoard(num) 
          boardDao.selectOne(num)
       2. 조회수 증가.  
          boardDao.addReadcnt(num)
--%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 상세보기</title>
<style type="text/css">
.leftcol {
   text-align: left;
   vertical-align: top;
}

.lefttoptable {
   height: 250px;
   border-width: 0px;
   text-align: left;
   vertical-align: top;
   padding: 0px;
}
</style>
</head>
<body>
<div style="width:1920px; height:750px; display: flex; justify-content: center; align-items: center;">

   <table class="w3-table-all" style="width:1000px; margin: 9% 0% 0% 0%;">
      <tr>
         <th style="width: 20%; vertical-align: middle; font-size:20px;">글쓴이</th>
         <td style="width: 80%" class="leftcol">&nbsp;&nbsp;${board.writer}</td>
      </tr>
      <tr>
         <th style = "vertical-align: middle; font-size:20px;">제목</th>
         
         <td class="leftcol">
         <div style="width:70%; text-align: left; float:left;">
            ${board.title}
         </div>
         <div style="width:30%; text-align: right; float:left;">
         <c:if test="${board.boardid==2}">
               <c:if test="${status==0}">
                  <font color="black">처리 대기중인 게시물입니다.</font>
               </c:if>
               <c:if test="${status==1}">
                  <font color="green">승인 되어있는 게시물입니다.</font>
               </c:if>
               <c:if test="${status==2}">
                  <font color="red">반려 되어있는 게시물입니다.</font>
               </c:if>
            </c:if> <!-- 여기까지@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
            </div>
            </td>
      </tr>
      <tr>
         <th style = "font-size:20px; height:450px;">내용</th>
         <td class="leftcol">
            <table class="lefttoptable">
               <tr>
                  <td class="leftcol lefttoptable">${board.content}</td>
               </tr>
            </table>
         </td>
      </tr>
      <tr>
         <th style = "vertical-align: middle; font-size:20px;">첨부파일</th>
         <td>&nbsp; <c:if test="${!empty board.fileurl}">
               <a href="file/${board.fileurl}">${board.fileurl}</a>
            </c:if></td>
      </tr>
      <tr>
         <td colspan="2">
            <c:if test="${login.username=='관리자'}">
               <a href="reply?num=${board.num}">[답글]</a>
            </c:if>
            <c:if test="${board.writer == login.username || login.username == '관리자'}">
               <a href="update?num=${board.num}">[수정]</a>
               <a href="delete?num=${board.num}">[삭제]</a>
            </c:if>
            <a href="list?boardid=${board.boardid}">[게시물목록]</a>
            <c:if test="${board.boardid==2}">
               <c:if test="${login.userid=='admin'}">
                  <a href="../admin/refuse?num=${board.num}" style="float:right;">[반려]</a>
                  <a href="../admin/recog?num=${board.num}" style="float:right;">[승인]</a>
               </c:if>
            </c:if> <!-- layout 수정 후 게시물 표현부분 위로 올려야할 부분임@@@@@@@@@@@@@@@@@@@ -->
         </td>
      </tr>
   </table>
   
   
</div>
   <div class="w3-container" style="width:54%; margin: 10% 0% 0% 23%;">
      <table class="w3-table-all w3-bordered">
         <c:forEach var="c" items="${commlist}" varStatus="stat">
            <c:if test="${stat.first}">
                 <tr>
                   <th style="width:8%">번호</th>
                   <th style="width:12%">작성자</th>
                   <th style="width:35%">내용</th>
                   <th style="width:25%">작성일자</th>
                   <th style="width:20%">댓글 삭제</th>
                 </tr>
            </c:if>
            <tr>
               <td>${c.seq}</td>
               <td>${c.writer}</td>
               <td>${c.content}</td>
               <td><fmt:formatDate value="${c.regdate}"
                     pattern="yyyy-MM-dd HH:mm:ss" /></td>
               <td class="w3-right">
                  <form action="commdel" method="post" name="commdel${stat.index}">
                     <input type="hidden" name="num" value="${c.num}"> <input
                        type="hidden" name="seq" value="${c.seq}">
                     <spring:hasBindErrors name="board">
                        <font color="red"><c:forEach
                              items="${errors.globalErrors}" var="error">
                              <spring:message code="${error.code }" />
                           </c:forEach> </font>
                     </spring:hasBindErrors>
                     <c:if test="${login.userid == c.loginid}">
                        <input type="password" name="pass" placeholder="비밀번호" style="width:60%;">
                        <a href="javascript:document.commdel${stat.index}.submit()" style="margin-left:10%;">삭제</a>
                     </c:if>
                  </form>
               </td>
            </tr>
         </c:forEach>
      </table>
      
   </div>
   
   

   <%-- 댓글 등록,조회,삭제 --%>
   <div style="width:51.65%; margin: 1% 0% 0% 23.85%;">
   <span id="comment"></span>
   <c:if test="${login.userid !=null }">
      <form:form modelAttribute="comment" action="comment" method="post"
         name="commForm">
         <form:hidden path="num" />
         <form:hidden path="loginid" value="${login.userid}" />
         <div class="w3-row">
            <div class="w3-col s2  w3-center">
               <p>
                  <form:input readonly="true" path="writer"
                     class="w3-input w3-border" value="${login.username}" />
                  <font color="red"><form:errors path="writer" /></font>
               </p>
            </div>
            <div class="w3-col s2  w3-center">
               <p>
                  <form:password path="pass" class="w3-input w3-border"
                     placeholder="비밀번호" />
                  <font color="red"><form:errors path="pass" /></font>
               </p>
            </div>
            <div class="w3-col s7  w3-center">
               <p>
                  <form:input path="content" class="w3-input w3-border"
                     placeholder="댓글내용" />
                  <font color="red"><form:errors path="content" /></font>
               </p>
            </div>
            <div class="w3-col s1  w3-center">
               <p>
                  <button type="submit" class="w3-btn w3-border">댓글등록</button>
               </p>
            </div>
         </div>
      </form:form>
   </c:if>
   </div>
   
   
   

   <script type="text/javascript">
      function comment_insert() {
         let data = {
            num : document.commForm.num.value,
            writer : document.commForm.writer.value,
            content : document.commForm.content.value
         }
         $.ajax({
            url : "comment",
            type : "POST",
            data : data,
            success : function(data) {
               $("comment").html(data)
            }
         })
      }
   </script>
</body>
</html>