<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%-- /shop1/src/main/webapp/WEB-INF/view/board/update.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<script type="text/javascript">
   function file_delete() {
      document.f.fileurl.value = ""
      file_desc.style.display = "none";
   }
</script>
</head>
<body>
<div style="width:1920px; height:750px; display: flex; justify-content: center; align-items: center;">
   <form:form modelAttribute="board" action="update"
      enctype="multipart/form-data" name="f">
      <form:hidden path="num" />
      <table class="w3-table" style="width:1000px; margin-top: 10%;">
         <tr>
            <th style="width: 25%; vertical-align: middle; font-size:20px;">
               <div>
                  글쓴이
               </div>
               <div>
                  <font color="red">
                     <form:errors path="writer" />
                  </font>
               </div>
            </th>
            <td style="width: 75%;">
               <form:input path="writer" class="w3-input"/>
               
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
               <form:input path="title" class="w3-input" placeholder="게시글의 제목을 입력 하세요."/>
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
               <form:textarea path="content" rows="15" cols="80" />
            </td>
            <script>
               CKEDITOR.replace("content", {
                  filebrowserImageUploadUrl : "imgupload",
                  height : '300'
               });
            </script>
         </tr>
         <tr>
            <td>첨부파일</td>
            <td><c:if test="${!empty board.fileurl}">
                  <div id="file_desc">
                     <a href="file/${board.fileurl}">${board.fileurl}</a> <a
                        href="javascript:file_delete()">[첨부파일삭제]</a>
                  </div>
               </c:if> <form:hidden path="fileurl" /><input type="file" name="file1"></td>
         </tr>
         <tr>
            <td colspan="2" class="w3-center">
               <a href="javascript:document.f.submit()" style="color: #F15F5F; font-size:20px;">[게시글수정]</a>
               <a href="list" style="font-size:20px;">[게시글목록]</a>
            </td>
         </tr>
      </table>
   </form:form>
</div>
</body>
</html>