<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!-- /shop1/src/main/webapp/WEB-INF/view/main/home.jsp -->     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Electric Car</title>
<style>
</style>
</head>
<body>
<div id="img_main" style="display:none; margin-bottom:300px;">
   <img src="${path}../img/test.gif" alt="Image" style="width:100%">
</div>

<%-- section 1 --%>
<div id="img_map" style="display:none; margin-bottom: 300px;">
   <div class="container" style="display: flex; justify-content: center;">
      <div class="inner1">
         <img src="${path}../img/main_station.png" alt="Image" style="width:300px;">
      </div>
      <div class="inner2" style="width:800px; padding: 70px 0px 0px 120px;">
         <div style="font-size:30px;">
            <p><i class="fa-solid fa-charging-station"></i>&nbsp;Charging Station</p>
         </div>
         <div style="font-size:20px; margin-top:20px;">
            <p>카카오맵을 기반으로<br>충전소 위치를 제공합니다.</p>
         </div>
         <div style="font-size:20px; margin-top:15px; color:#F15F5F">
            <a href="${path}../place/location">바로가기 </a>
         </div>
      </div>
   </div>
</div>

<%-- section 2 --%>
<div id="img_board" style="display:none; margin-bottom: 200px;">
   <div class="container" style="display: flex; justify-content: center;">
      <div class="inner2" style="width:800px; padding: 70px 0px 0px 430px;">
         <div style="font-size:30px;">
            <p><i class="fa-solid fa-clipboard"></i></i>&nbsp;Board</p>
         </div>
         <div style="font-size:20px; margin-top:20px;">
            <p>공지사항과 공유게시판에서<br>정보를 공유 하세요.</p>
         </div>
         <div style="font-size:20px; margin-top:15px; color:#F15F5F">
            <a href="${path}../board/list">바로가기 </a>
         </div>
      </div>
      <div class="inner1">
         <img src="${path}../img/main_board.png" alt="Image" style="width:300px;">
      </div>
   </div>
</div>

<%-- section 3 --%>
<div id="img_news" style="display:none; margin-bottom: 300px;">
   <div class="container" style="display: flex; justify-content: center;">
      <div class="inner1">
         <img src="${path}../img/main_news.png" alt="Image" style="width:300px;">
      </div>
      <div class="inner2" style="width:800px; padding: 70px 0px 0px 120px;">
         <div style="font-size:30px;">
            <p><i class="fa-solid fa-newspaper"></i>&nbsp;News</p>
         </div>
         <div style="font-size:20px; margin-top:20px;">
            <p>네이버 뉴스 API으로<br>전기차 관련 뉴스를 제공 합니다.</p>
         </div>
         <div style="font-size:20px; margin-top:15px; color:#F15F5F">
            <a href="${path}../news/main">바로가기 </a>
         </div>
      </div>
   </div>
</div>

<%-- section 4 --%>
<div id="img_car" style="display:none; margin-bottom: 300px;">
   <div class="container" style="display: flex; justify-content: center;">
      <div class="inner2" style="width:800px; padding: 70px 0px 0px 430px;">
         <div style="font-size:30px;">
            <p><i class="fa-solid fa-car"></i>&nbsp;Car</p>
         </div>
         <div style="font-size:20px; margin-top:20px;">
            <p>공지사항과 공유게시판에서<br>정보를 공유 하세요.</p>
         </div>
         <div style="font-size:20px; margin-top:15px; color:#F15F5F">
            <a href="${path}../board/list">바로가기 </a>
         </div>
      </div>
      <div class="inner1">
         <img src="${path}../img/main_car.png" alt="Image" style="width:300px;">
      </div>
   </div>
</div>

<script>
$(document).ready(function () {
   $("#img_main").fadeIn(1000);
  });
  
$(window).scroll(function() {
   if ($(window).scrollTop() > 700) {
      $("#img_map").fadeIn(1000);
   }
   if ($(window).scrollTop() > 1200) {
      $("#img_board").fadeIn(1000);
   }
   if ($(window).scrollTop() > 1700) {
      $("#img_news").fadeIn(1000);
   }
   if ($(window).scrollTop() > 2200) {
      $("#img_car").fadeIn(1000);
   }
});
</script>
</body>
</html>