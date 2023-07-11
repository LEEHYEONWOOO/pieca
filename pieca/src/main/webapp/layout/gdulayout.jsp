<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%-- /shop1/src/main/webapp/layout/gdulayout.jsp --%>    

<!DOCTYPE html>
<html>
<head>
<title><sitemesh:write property="title" /></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://kit.fontawesome.com/f060468afd.js" crossorigin="anonymous"></script>

<link href="../css/pieca.css" rel="stylesheet" type="text/css">

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src= 
"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<script type="text/javascript"
   src="http://cdn.ckeditor.com/4.5.7/standard/ckeditor.js">
</script>
<sitemesh:write property="head" />
<style>
@font-face {
    font-family: 'KIMM_Bold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2212@1.0/KIMM_Bold.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}

input::placeholder {
   font-family: 'KIMM_Bold';
}

input[type=password]{
   font-family: "arial";
}

body {
   margin: 0;
   font-family: 'KIMM_Bold';
}
::-webkit-scrollbar {
  display: none;
}

nav ul {
   top: 0px;
   transition-duration: 1.5s;
   box-shadow: 0px 3px 5px 0px #1B1B1B;
   width: 100%;
   position: fixed;
   background-color: #FFFFFF;
   list-style-type: none;
   /* 마진 패딩 지정하지 않으면 브라우저 기본 스타일을 따라 설정되므로 오버라이딩 필요 */
   margin: 0;
   padding: 0;
   z-index: 999;
}

/* li 는 블록요소인데 inline-block 으로 인라인속성 부여해서 나란히 배치*/
nav ul li {
   display: inline-block;
}

.map, .user {
   position: relative;
}

.board-menu {
   font-color: #1B1B1B;
   padding: 16px;
   font-size: 16px;
   cursor: pointer;
}

.board-content {
   display: none;
   position: absolute;
   margin-left: 25px;
   background-color: #f9f9f9;
   border : 1px solid #747474;
   border-radius: 6px;
   width: 100px;
   box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
}

a {
   text-decoration: none; 
}
.board-content a {
   color: black;
   padding: 12px 16px;
   display: block;
   text-align:center;
}

.home, .map, .board-menu, .news, .car, .login, .mypage, .logout{
   text-align:center;
   font-size: 22px;
}

.map, .board, .news, .car{
   width:8%;
}

.home {
   width:33%;
   text-align:center;
}

.login, .mypage {
   width:33%;
   text-align:center;
}


/* map-menu 에는 hover 적용이 안됨 */
.board:hover .board-content {
   display: block;
}

.contents {
   margin-top: 70px;
}
/* Clear floats after the columns */
.contents:after {
   content: "";
   display: table;
   clear: both;
}

#layout_top_btn, #layout_bottom_btn {
  position: fixed;
  width:40px;
  height:40px;
  top: 400px;
  right: 30px;
  background-color: #FFFFFF;
  color: #000000;
  padding: 2px;
  border-radius: 100px;
  font-size:30px;
  cursor: pointer;
}

#layout_bottom_btn {
  top: 460px;
  
}
</style>

</head>
<body>
 <div class="navbar">
   <nav>
      <ul>
         <li class="home">
            <a href="${path}/main/home">
               <img src="${path}/img/PIECA_logo.png" style="width:140px; height:70px;">
            </a>
         </li>
         
         <li class="map"><a href="${path}/place/location">Station</a></li>
         
         <li class="board">
               <div class="board-menu">
                     <span>Board</span>
               </div>
               <div class="board-content">
                     <a href="${path}/board/list?boardid=1">공지 사항</a>
                     <a href="${path}/board/list?boardid=2">정보 공유</a>
               </div>
            </li>
         
         <li class="news"><a href="${path}/news/main">News</a></li>
         <li class="car"><a href="${path}/car/list">Car</a></li>
         <c:if test="${empty sessionScope.loginUser}">
            <li class="login"><a class="fa-regular fa-user" href="${path}/user/login"></a></li>
         </c:if>
         <c:if test="${!empty sessionScope.loginUser}">
            <li class="mypage"style="margin-top:10px;">
               <a class="fa-regular fa-user" href="${path}/user/mypage?userid=${sessionScope.loginUser.userid}" style="margin-top:-15px;"></a>
               &nbsp;&nbsp;
               <a class="fa-solid fa-arrow-right-from-bracket" href="${path}/user/logout"></a>
            </li>
            <li class="logout"></li>
         </c:if>
         
      </ul>
   </nav>
</div>
<div class="contents" style="height:auto; padding-bottom:150px;">
   <button id="layout_top_btn" class="fa-solid fa-caret-up"></button>
   <button id="layout_bottom_btn" class="fa-solid fa-caret-down"></button>
   <sitemesh:write property="body"/>
</div>
  
  <!-- Footer -->
<footer>
   <div style="width:105%; height:180px; background-color: #D5D5D5; box-shadow: 0px 0px 5px 4px #1B1B1B;">
      <div style="float:left; width:20%; margin: 1% 0% 0% 12% ">
         <p style="font-size:25px;">구디 아카데미</p>
          <p style="font-size:20px;">GDJ 62기 <span style="color:#F15F5F">이현우</span></p>
          <p style="font-size:18px;">dlgusdn16@naver.com</p>
          <p style="font-size:18px;">010-2316-8678</p>
       </div>
       <div style="float:left; width:20%; margin: 1% 0% 0% 0% ">
         <p style="font-size:25px;">구디 아카데미</p>
          <p style="font-size:20px;">GDJ 62기 <span style="color:#F15F5F">김도훈</span></p>
          <p style="font-size:18px;">guardian010@naver.com</p>
          <p style="font-size:18px;">010-8850-4119</p>
       </div>
       <div style="float:left; width:20%; margin: 1% 0% 0% 0% ">
         <p style="font-size:25px;"><i class="fa-solid fa-hands-clapping"></i> Thanks to</p>
         <p style="font-size:15px;">카카오맵 API
             <a href="https://apis.map.kakao.com/" target="_blank" style="color:#F15F5F">&nbsp;바로가기</a>
          </p>
         <p style="font-size:15px;">카카오 로그인 API
             <a href="https://developers.kakao.com/product/kakaoLogin" target="_blank" style="color:#F15F5F">&nbsp;바로가기</a>
          </p>
         <p style="font-size:15px;">네이버 로그인 API
             <a href="https://developers.naver.com/products/login/api/api.md" target="_blank" style="color:#F15F5F">&nbsp;바로가기</a>
          </p>
         <p style="font-size:15px;">Port one API (결제)
             <a href="https://portone.io/korea/ko?utm_source=google&utm_medium=google_sa&utm_campaign=pf_conversion_2302_kr&utm_content=homepage&gclid=CjwKCAjw-7OlBhB8EiwAnoOEk9Hc-Vjo-7FGcazTuuPqnhOcj21aya637yAIwGQaRzdSNCmTX1imfRoCBeQQAvD_BwE" target="_blank" style="color:#F15F5F">&nbsp;바로가기</a>
          </p>
          <p style="font-size:15px;">한국전력 API (지역정보) 
             <a href="https://bigdata.kepco.co.kr/cmsmain.do?scode=S01&pcode=000493&pstate=L&redirect=Y" target="_blank" style="color:#F15F5F">&nbsp;바로가기</a>
          </p>
       </div>
       <div style="float:left; width:20%; margin: 2% 0% 0% 0% ">
          <p style="font-size:15px;">Pixlr X
             <a href="https://pixlr.com/kr/x/" target="_blank" style="color:#F15F5F">&nbsp;바로가기</a>
          </p>
          <p style="font-size:15px;">Freepik
             <a href="https://www.freepik.com/" target="_blank" style="color:#F15F5F">&nbsp;바로가기</a>
          </p>
          <p style="font-size:15px;">Noonnu
             <a href="https://noonnu.cc/" target="_blank" style="color:#F15F5F">&nbsp;바로가기</a>
          </p>
          <p style="font-size:15px;">Font-awesome 
             <a href="https://fontawesome.com/search" target="_blank" style="color:#F15F5F">&nbsp;바로가기</a>
          </p>
          <p style="font-size:15px;">공공데이터 API (충전소 정보)
             <a href="https://www.data.go.kr/data/15076352/openapi.do" target="_blank" style="color:#F15F5F">&nbsp;바로가기</a>
          </p>
          <p style="font-size:15px;">공공데이터 API (행정표준코드)
             <a href="https://www.data.go.kr/data/15077871/openapi.do" target="_blank" style="color:#F15F5F">&nbsp;바로가기</a>
          </p>
       </div>
       
      </div>
</footer> 
  <!-- End page content -->

<script>
document.getElementById("layout_top_btn").addEventListener("click", function() {
   window.scrollTo(0, 0);
   this.style.transform = "scale(1.3)";
   setTimeout(() => this.style.transform = "scale(1)", 200);
});

document.getElementById("layout_bottom_btn").addEventListener("click", function() {
   window.scrollTo(0, document.body.scrollHeight);
   this.style.transform = "scale(1.3)";
   setTimeout(() => this.style.transform = "scale(1)", 200);
});

loc = document.location.href.split("pieca/");

if (loc[1] == "main/home") {
   $(window).on('load',function() {
      $("ul").css('background-color', '#1B1B1B');
      $(".home").css('color', '#FFFFFF');
      $(".map").css('color', '#FFFFFF');
      $(".board span").css('color', '#FFFFFF');
      $(".news").css('color', '#FFFFFF');
      $(".car").css('color', '#FFFFFF');
      $(".login").css('color', '#FFFFFF');
      $(".mypage").css('color', '#FFFFFF');
      $(".logout").css('color', '#FFFFFF');
   });
}



$(window).scroll(function() {
   if ((loc[1] == "main/home") && ($(window).scrollTop() > 700)) {
      $("#layout_top_btn").fadeIn(600);
       $("#layout_bottom_btn").fadeIn(600);         
   }

   if ((loc[1] == "main/home") && ($(window).scrollTop() <= 700)) {
      $("#layout_top_btn").fadeOut(600);
       $("#layout_bottom_btn").fadeOut(600);         
   }
   
   if ($(window).scrollTop() > 1) {
       $("ul").css('background-color', '#FFFFFF');
       $(".home").css('color', '#1B1B1B');
       $(".map").css('color', '#1B1B1B');
       $(".board span").css('color', '#1B1B1B');
       $(".news").css('color', '#1B1B1B');
       $(".car").css('color', '#1B1B1B');
       $(".login").css('color', '#1B1B1B');
       $(".mypage").css('color', '#1B1B1B');
       $(".logout").css('color', '#1B1B1B');
   }
   
   if ($(window).scrollTop() == 0) {
      if (loc[1] == "main/home") {
         $("ul").css('background-color', '#1B1B1B');
         $(".home").css('color', '#FFFFFF');
          $(".map").css('color', '#FFFFFF');
          $(".board span").css('color', '#FFFFFF');
          $(".news").css('color', '#FFFFFF');
          $(".car").css('color', '#FFFFFF');
          $(".login").css('color', '#FFFFFF');
          $(".mypage").css('color', '#FFFFFF');
          $(".logout").css('color', '#FFFFFF');
      }
   }
});
function openInNewTab(url) {
     var win = window.open(url, '_blank');
     win.focus();
   }
</script>  
  

</body>
</html>