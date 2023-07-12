<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%-- /shop1/src/main/webapp/WEB-INF/view/board/reply.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 답글 쓰기</title>
</head>
<body>
<div style="width:1920px; height:750px; display: flex; justify-content: center; align-items: center;">
   <form:form modelAttribute="board" action="reply" method="post" name="f">
      <form:hidden path="num" />
      <form:hidden path="boardid" />
      <form:hidden path="grp" />
      <form:hidden path="grplevel" />
      <form:hidden path="grpstep" />
      <table class="w3-table" style="width:1000px; margin-top: 10%;">
         <tr>
            <th style = "vertical-align: middle; font-size:20px;">
               <div>
                  글쓴이
               </div>
               <div>
                  <font color="red">
                     <form:errors path="writer" />
                  </font>
               </div>
            <td>
               <input type="text" name="writer" class="w3-input" value="관리자">
            </td>
         </tr>
         <tr>
            <th style = "vertical-align: middle; font-size:20px;">
               <div>
                  비밀번호
               </div>
               <div>
                  <font color="red">
                     <form:errors path="pass" />
                  </font>
               </div>
            </th>
            <td>
               <form:password path="pass" class="w3-input" value="" placeholder="게시글의 비밀번호를 입력 하세요."/>
            </td>
         </tr>
         <tr>
            <th style = "vertical-align: middle; font-size:20px;">
               <div>
                  제목
               </div>
               <div>
                        <font color="red">
                           <form:errors path="title" />
                        </font>
                     </div>
            </th>
            <td>
               <form:input path="title" class="w3-input" value="RE:${board.title}" />
            </td>
         </tr>
         <tr>
            <th style = "font-size:20px;">
               <div>
                  내용
               </div>
               <div>
                  <font color="red">
                     <form:errors path="content" />
                  </font>
               </div>
            </th>
            <td>
               <form:textarea path="content" rows="15" cols="80"/>
            </td>
         </tr>
         <script>
            CKEDITOR.replace("content", {
               filebrowserImageUploadUrl : "imgupload",
               height : '300'
               
            })
         </script>
         <tr>
            <td colspan="2" class="w3-center">
               <a href="javascript:document.f.submit()"><div style="display: inline; color:#F15F5F; font-size:20px;">[답변글 등록]</div></a>
            </td>
         </tr>
      </table>
   </form:form>
</div>
</body>
</html>