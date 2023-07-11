<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%-- /shop1/src/main/webapp/WEB-INF/view/board/ 

     http://localhost:8080/shop1/board/write 요청시 write.jsp 화면 출력
     1. Controller 클래스 생성. 
 --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
</head>
<body>
<div style="width:1920px; height:750px; display: flex; justify-content: center; align-items: center;">
   <form:form modelAttribute="board" action="write" enctype="multipart/form-data" name="f">
      <table class="w3-table" style="width:1000px; margin-top: 10%;">
         <tr>
            <th style="width: 25%; vertical-align: middle; font-size:20px;">글쓴이</th>
            <td style="width: 75%;">
               <form:input path="writer" readonly="true" class="w3-input" value="${login.username}" />
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
            <th style = "vertical-align: middle; font-size:20px;">첨부파일</th>
            <td><input type="file" name="file1"></td>
         </tr>
         <tr>
            <td colspan="2" class="w3-center">
               <a href="javascript:document.f.submit()"><div style="display: inline; color:#F15F5F; font-size:20px;">[게시글 등록]</div></a>
               <a href="list?boardid=${boardid}"><div style="display: inline; font-size:20px;">[게시글 목록]</div></a>
            </td>
         </tr>
      </table>
   </form:form>
</div>
   
<script type="text/javascript">
function chg_pwCheck(password) {
   $.ajax({
      type : "POST",
      url : "../user/pwCheck",
      data : {
         "userid" : $("#userid").val(),
         "password" : password
      },
      success : function(result) {
      }
   });
}
</script>
</body>
</html>