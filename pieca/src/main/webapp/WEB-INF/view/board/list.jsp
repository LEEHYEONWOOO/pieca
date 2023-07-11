<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%-- /shop1/src/main/webapp/WEB-INF/view/board/list.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${boardName}</title>
<script type="text/javascript">
   function listpage(page) {
      document.searchform.pageNum.value = page;
      document.searchform.submit();
   }
</script>
</head>
<body>
<div style="width:1920px; height:750px; display: flex; justify-content: center; align-items: center;">
   <table class="w3-table-all w3-border" id="main_table" style="width:1350px; font-size:16px; margin-top: 10%;">
      <tr>
      <form action="list" method="post" name="searchform">
         <td style="text-align: left; vertical-align: middle; color: #F15F5F; padding-left:15px; font-size:23px;">
            ${boardName}
         </td>
         <td>
            <input type="hidden" name="pageNum" value="1"> 
            <input type="hidden" name="boardid" value="${param.boardid}">
            <select name="searchtype" id="searchtype" class="w3-select">
               <option value="">검색 조건을 선택 해주세요.</option>
               <option value="title">제목</option>
               <option value="writer">작성자</option>
               <option value="content">내용</option>
            </select>
            <script type="text/javascript">
               searchform.searchtype.value = "${param.searchtype}";
            </script>
         </td>
         <td colspan="2">
            <input type="text" name="searchcontent" id="searchcontent" value="${param.searchcontent }" class="w3-input" placeholder="검색어를 입력 하세요.">
         </td>
         <td>
            <input type="submit" onclick="typeCheck()" value="검색" class="w3-btn w3-blue">
            <input type="button" value="전체게시물 보기" class="w3-btn w3-blue" onclick="location.href='list?boardid=${boardid}'">
         </td>
      </form>
      </tr>
      <c:if test="${listcount > 0}">
      <tr>
         <td colspan="5" class="w3-left-align" style="font-size:20px;">
            글개수 : ${listcount}
         </td>
      </tr>
      <tr style="font-size:19px; color: #F15F5F">
         <th width=10%;>번호</th>
         <th width=40%;>제목</th>
         <th width=12%;>글쓴이</th>
         <th width=12%;>조회수</th>
         <th width=16%;>날짜</th>
      </tr>
      <c:forEach var="board" items="${boardlist}">
      <tr>
      <input type="hidden" id="pagecount" value="${boardno}">
         <td>${boardno}</td>
         <%-- 화면 보여지는 게시물 번호 --%>
         <c:set var="boardno" value="${boardno - 1}" />
         <td class="w3-left">
            <c:if test="${! empty board.fileurl}">
               <a href="file/${board.fileurl}"><i class="fa-regular fa-image"></i></a>
            </c:if>
            <%-- 
            <c:if test="${empty board.fileurl}">
               &nbsp;&nbsp;&nbsp;&nbsp;
            </c:if>
            --%>
            <c:forEach begin="1" end="${board.grplevel}">
               &nbsp;&nbsp;
            </c:forEach>
            <c:if test="${board.grplevel > 0}">
               <span class="fa-solid fa-reply fa-rotate-180"></span>
            </c:if> <%-- ㅂ 한자--%>
            
            <a href="detail?num=${board.num}">${board.title}
               <c:forEach items="${recog}" var="recog">
                  <c:if test="${recog.num == board.num && board.boardid == 2}">
                     <c:if test="${recog.recog_Status==1}">
                        <span id="up_check" style="font-size:20px;" class="fa-regular fa-circle-check"></span>
                     </c:if>
                     <c:if test="${recog.recog_Status==0}">
                        <span id="up_check" style="color: #747474; font-size:20px;" class="fa-regular fa-circle-check"></span>
                     </c:if>
                     <c:if test="${recog.recog_Status==2}">
                        <span id="up_check" style="color: red; font-size:20px;" class="fa-regular fa-circle-check"></span>
                     </c:if>
                  </c:if>
               </c:forEach>
               <c:if test="${login.userid == ('admin')}">
                  <c:if test="">
                     <span style="color: red;">[미확인]</span>
                  </c:if>
               </c:if>
            </a>
         </td>
         <td>${board.writer}</td>
         <td>${board.readcnt}</td>
         <td>
            <fmt:formatDate value="${board.regdate }" pattern="yyyyMMdd" var="rdate" />
            <c:if test="${today == rdate }">
               <fmt:formatDate value="${board.regdate }" pattern="HH:mm:ss" />
            </c:if>
            <c:if test="${today != rdate }">
               <fmt:formatDate value="${board.regdate }" pattern="yyyy-MM-dd HH:mm" />
            </c:if>
         </td>
      </tr>
      </c:forEach>
      
      <tr>
         <td colspan="5" class="w3-center">
            <c:if test="${pageNum > 1}">
               <a href="javascript:listpage('${pageNum - 1}')">[이전]</a>
            </c:if>
            <c:if test="${pageNum <= 1}">
               [이전]
            </c:if>
            <c:forEach var="a" begin="${startpage }" end="${endpage}">
               <c:if test="${a == pageNum}">
                  <div style="display: inline; color:#F15F5F; font-size:20px;">[${a}]</div>
               </c:if>
               <c:if test="${a != pageNum}">
                  <a href="javascript:listpage('${a}')">[${a}]</a>
               </c:if>
            </c:forEach>
            <c:if test="${pageNum < maxpage}">
               <a href="javascript:listpage('${pageNum + 1}')">[다음]</a>
            </c:if>
            <c:if test="${pageNum >= maxpage}">
               [다음]
            </c:if>
         </td>
      </tr>
      </c:if>
      
      <%-- 등록된 게시물이 있는 경우 끝 --%>
      <c:if test="${listcount == 0}">
         <tr>
            <td colspan="5">등록된 게시물이 없습니다.</td>
         </tr>
      </c:if>
      <c:if test="${boardid == 1 && login.userid == 'admin'}">
         <tr>
            <td colspan="5">
               <a href="write" class="w3-left" style="color: #F15F5F; font-size:20px;">[글쓰기]</a>
            </td>
         </tr>
      </c:if>
      <c:if test="${boardid == 2}">
         <tr>
            <td colspan="5">
               <a href="write" class="w3-left" style="color: #F15F5F; font-size:20px;">[글쓰기]</a>
            </td>
         </tr>
      </c:if>
   </table>
</div>
<script>
$(document).ready(function(){
   const count = $("#pagecount").val();
   if(count < 10) {
      $("#main_table").css("margin-top","-5.2%")
   }
         
})

function typeCheck() {
   const select = document.getElementById("searchtype");
   const value = select.options[select.selectedIndex].value;
   const searchcontent = $("#searchcontent").val();
   
   if(searchcontent == '') {
      alert('검색어를 입력 하세요.')
   }
   
   if (value == '') {
      alert('검색 조건을 선택 해주세요.')
   }
   
   
}
</script>
</body>
</html>