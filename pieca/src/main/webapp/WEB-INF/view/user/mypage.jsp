<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mypage</title>
<script type="text/javascript"
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
   <div class="mypage_sidenav">
      <a onclick="movePage(1);" id="movepage1" style="cursor: pointer;">
         <span class="fa-regular fa-user"></span> 회원 정보</a>
         
      <a onclick="movePage(2);" id="movepage2" style="cursor: pointer;">
         <c:if test="${login.username == '관리자' }">
            <span class="fa-solid fa-user-plus"></span>
            회원 관리
         </c:if>
         <c:if test="${login.username != '관리자' }">
            <span class="fa-solid fa-car"></span>
            차량 조회
         </c:if>
         </a>
         
      <a onclick="movePage(3);" id="movepage3" style="cursor: pointer;">
         <span class="fa-regular fa-credit-card"></span> PIECA CARD</a>
      <a onclick="movePage(4);" id="movepage4" style="cursor: pointer;">
         <span class="fa-solid fa-lock"></span> 비밀번호 변경</a>
      <a onclick="movePage(5);" id="movepage5" style="cursor: pointer;">
         <span class="fa-regular fa-circle-xmark"></span> 회원 탈퇴</a>         
   </div>

   <div class="mypage_main">
      <div id="basic_info_wrapper">
         <form:form modelAttribute="user" method="post" action="update">

            <div id="basic_info_left_inner">
               <div id="basic_info_left_title">
                  <input type="hidden" id="login_mode" value="${user.channel}">
                  <c:if test="${user.channel eq 'naver' }">
                     <img src="../img/mypage_N.png" id="basic_info_left_naver_img"> 회원<br>
                     <b><form:input path="userid" value="${user.username}"
                           id="basic_info_left_naver_username" readonly="true"
                           spellcheck="false" /></b>
                  </c:if>
                  <c:if test="${user.channel eq 'kakao' }">
                     <img src="../img/mypage_K.png" id="basic_info_left_kakao_img"> 회원<br>
                     <b><form:input path="userid" value="${user.username}"
                           id="basic_info_left_kakao_username" readonly="true"
                           spellcheck="false" /></b>
                  </c:if>
                  <c:if test="${user.channel eq 'pieca' }">
                     <img src="../img/mypage_P.png" id="basic_info_left_pieca_img"> 회원<br>
                     <b><form:input path="userid" value="${user.userid}"
                           readonly="true" spellcheck="false"
                           style="font-size:24px; width:200px; border:none;" /></b>
                  </c:if>
               </div>


               <div id="basic_info_left_desc">
                  <p>위 항목은 개인 정보로써 다른 사람에게 공유되지 않는 개인정보 입니다.</p>
               </div>
            </div>

            <div id="basic_info_right_inner">
               <%-- 이름 --%>
               <div id="basic_info_right_username">
                  <label for="username" style="font-size: 16px; color: #747474;">name</label>
                  <input type="hidden" id="mode_name">
               </div>

               <div id="basic_info_right_username_error">
                  <label id="usernameCheck" for="username">&nbsp;</label>
               </div>

               <div id="basic_info_right_username_input">
                  <input type="hidden" id="start_name">
                  <form:input path="username" id="username" value="${user.username}"
                     oninput="nameChk(); upSubmitChk();" />
               </div>
               <div id="basic_info_right_update">
                  <a class="fa-regular fa-pen-to-square" id="show_update"></a>
               </div>

               <input type="hidden" id="mode" />
               <%-- 이메일 --%>
               <div id="basic_info_right_email_email">
                  <label for="input_email" style="font-size: 16px; color: #747474;">email</label>
                  <input type="hidden" id="mode_email">
               </div>

               <div id="basic_info_right_email_error"
                  style="width: 150px; position: relative; float: left;">
                  <label id="emailCheck" for="input_email"
                     style="font-size: 13px; color: #747474;">&nbsp;</label>
               </div>

               <div id="basic_info_right_email_input"
                  style="float: left; margin: -35px 10px 0px -17px;">
                  <form:hidden path="email" id="email" />
                  <c:set var="email_base" value="${user.email}" />
                  <c:set var="email_be" value="${fn:split(email_base, '@')[0]}" />
                  <c:set var="email_af" value="${fn:split(email_base, '@')[1]}" />
                  <input type="hidden" id="start_email"> <input
                     type="hidden" id="start_email_be"> <input type="hidden"
                     id="start_email_af"> <input type="hidden" id="email_af"
                     value="${email_af}"> <input type="text" id="input_email"
                     value="${email_be}" oninput="emailChk(); upSubmitChk();" />

                  <form:input path="email" id="email_original" value="${user.email}" />

               </div>
               <div id="basic_info_right_email_address">
                  <label for="select_email" style="font-size: 16px; color: #747474;">address</label>
               </div>

               <div id="basic_info_right_email_input">
                  <select name="select_email" id="select_email">
                     <option value="naver.com" id="naver.com">naver.com</option>
                     <option value="gmail.com" id="gmail.com">gmail.com</option>
                     <option value="hanmail.net" id="hanmail.net">hanmail.net</option>
                     <option value="nate.com" id="nate.com">nate.com</option>
                  </select>
               </div>

               <%-- 
         <input type="text" id="input_email" style="border:1px solid #747474; border-radius: 6px; font-size:15px; width:222px; height:40px;" placeholder="   이메일 주소"/>
         <span>@</span>
          <select name="select_email" id="select_email" style="border:1px solid #747474; border-radius: 6px; font-size:15px; width:222px; height:40px;">
               <option value="" disabled selected>E-Mail 선택</option>
               <option value="naver.com" id="naver.com">naver.com</option>
               <option value="gmail.com" id="gmail.com">gmail.com</option>
               <option value="hanmail.net" id="hanmail.net">hanmail.net</option>
               <option value="nate.com" id="nate.com">nate.com</option>
           </select>
         --%>
               <%-- 전화번호 --%>
               <div id="basic_info_right_phoneno">
                  <label for="tel" style="font-size: 16px; color: #747474;">Tel</label>
                  <input type="hidden" id="mode_phone">
               </div>

               <div id="basic_info_right_phoneno_error">
                  <label id="phonenoCheck" for="tel"
                     style="font-size: 13px; color: #747474;">&nbsp;</label>
               </div>

               <div id="basic_info_right_phoneno_input">
                  <input type="hidden" id="start_phoneno">
                  <form:input path="phoneno" id="phoneno" value="${user.phoneno}"
                     oninput="phonenoChk(); upSubmitChk();" />
               </div>

               <%-- 생년월일 --%>
               <div id="basic_info_right_birthday_input_update_s1">
                  <div id="basic_info_right_birth">
                     <label for="tel" style="font-size: 16px; color: #747474;">birth</label>
                  </div>

                  <div id="basic_info_right_birth_error">
                     <label id="birthCheck" for="tel"
                        style="font-size: 13px; color: #747474;">&nbsp;</label>
                  </div>

                  <div id="basic_info_right_birth_input">
                     <fmt:formatDate value="${user.birthday}" var="birth" type="date"
                        pattern="yyyy-MM-dd" />
                     <form:input path="birthday" id="birthday" value="${birth}"
                        oninput="" />
                     <input type="hidden" id="start_birthday">
                  </div>
               </div>

               <%-- 년 --%>
               <div id="basic_info_right_birthday_input_update_s2">

                  <div id="basic_info_right_birthday_year">
                     <label for="year" style="font-size: 16px; color: #747474;">Year</label>
                  </div>
                  <div id="basic_info_right_birthday_input_year">
                     <fmt:formatDate value="${user.birthday}" var="year" type="date"
                        pattern="yyyy" />
                     <select name="yy" id="year" onchange="birthChk();"></select>
                  </div>
                  <%-- 월 --%>
                  <div id="basic_info_right_birthday_month">
                     <label for="month" style="font-size: 16px; color: #747474;">&nbsp;Month</label>
                  </div>
                  <div id="basic_info_right_birthday_input_month">
                     <fmt:formatDate value="${user.birthday}" var="month" type="date"
                        pattern="MM" />
                     <select name="mm" id="month" onchange="birthChk();"></select>
                  </div>
                  <%-- 일 --%>
                  <div id="basic_info_right_birthday_day">
                     <label for="day" style="font-size: 16px; color: #747474;">&nbsp;Day</label>
                  </div>
                  <div id="basic_info_right_birthday_input_day">
                     <fmt:formatDate value="${user.birthday}" var="day" type="date"
                        pattern="dd" />
                     <select name="dd" id="day" onchange="birthChk();"></select>
                  </div>
               </div>

               <%-- 비밀번호 --%>
               <div id="basic_info_right_password">
                  <label for="password" style="font-size: 16px; color: #747474;">password</label>
                  <input type="hidden" id="mode_pass">
               </div>
               <div id="basic_info_right_password_input">
                  <form:password path="password"
                     oninput=" upSubmitChk(); up_pwCheck(password.value);"
                     style="width:355px; border:2px solid #747474; border-radius: 6px; background-color: #FFFFFF; color: #000000; font-size:23px; height:60px; padding:18px 0px 0px 15px;" />
               </div>
               <div id="basic_info_right_password_check">
                  <span id="up_check" class="fa-regular fa-circle-check"></span>
               </div>

               <div id="basic_info_right_password_submit">
                  <input type="submit" id="up_submit" value="수정">
               </div>

               <div id="basic_info_right_password_cancel">
                  <input type="button" id="update_cancel" value="취소">
               </div>

            </div>
         </form:form>
      </div>
      <%-- basic_info_wrapper --%>
      <%-- basic_info_wrapper --%>
      <%-- basic_info_wrapper --%>
      
      <%-- 내 차 조회 --%>
   <c:if test="${login.username == '관리자' }">
   <div id="basic_info_wrapper2">
      <div id="basic_info_left_inner2">
         <span style="font-size:30px;">회원 관리</span>
      </div>
      <div style="font-size: 16px; width:90%; margin:0px 0px 40px 5%;">
         <table class="w3-table"  style="width:100%; text-align: center; border:2px solid #D5D5D5">
         <tr style="border:2px solid #D5D5D5;">
         <th width="20%" style="background-color:red; font-size:18px; color:#F15F5F">회원 이름</th>
            <th width="25%" style="background-color:orange; font-size:18px; color:#F15F5F">전화번호</th>
            <th width="20%" style="background-color:yellow; font-size:18px; color:#F15F5F; padding-left: 18px;">생년월일</th>
            <th width="35%" style="background-color:green; font-size:18px; color:#F15F5F">이메일</th>
            <th width="15%" style="background-color:blue; text-align:center; font-size:18px; color:#F15F5F">수정</th>
      </tr>
      
      <c:set var="userCnt" value="1" /> 
      
        <c:forEach items="${list}" var="user">
            
      <form:form modelAttribute="user" method="post" action="updateAdmin">
        <tr style=" border:2px solid #D5D5D5;">
            <td>
               <c:if test="${user.channel eq 'pieca' }">
                  <img src="../img/mypage_P2.png" style="width:25px;">
                  <form:input path="username" id="adminUsername${userCnt}" value="${user.username}" style="width:65%; background-color:#FFFFFF; border:none; color:#000000; padding-left: 3px; font-size:16px; height:35px;"/>
               </c:if>
               <c:if test="${user.channel eq 'kakao' }">
                  <img src="../img/mypage_K.png" style="width:25px;">
                  <input type="text" value="${user.username}" readonly="readonly" style="width:65%; padding: 0px; font-size:16px; height:35px; border:none; padding-left: 3px;"/>
               </c:if>
               <c:if test="${user.channel eq 'naver' }">
                  <img src="../img/mypage_N.png" style="width:25px;">
                  <input type="text" value="${user.username}" readonly="readonly" style="width:65%; padding: 0px; font-size:16px; height:35px; border:none; padding-left: 3px;"/>
               </c:if>
            </td>
            <td>
               <c:if test="${user.channel eq 'pieca' }">
                  <form:input path="phoneno" id="adminPhoneno${userCnt}" value="${user.phoneno}" style="width:95%; background-color:#FFFFFF; border:none; color:#000000; padding-left: 3px; font-size:16px; height:35px;"/>
               </c:if>
               <c:if test="${user.channel ne 'pieca' }">
                  <input type="text" value="${user.phoneno}" readonly="readonly"style="width:90%; padding: 0px; font-size:16px; height:35px; border:none; padding-left: 3px;"/>
                  
               </c:if>
            </td>
            <td>
               <c:if test="${user.channel eq 'pieca'}">
                  <fmt:formatDate value="${user.birthday}" var="adminBirth" type="date" pattern="yyyy-MM-dd" />
                  <form:input path="birthday" id="adminBirthday${userCnt}" value="${adminBirth}" style="width:100%; background-color:#FFFFFF; border:none; color:#000000; padding-left: 3px; font-size:16px; height:35px;"/>
               </c:if>
               <c:if test="${user.channel ne 'pieca'}">
                  <fmt:formatDate value="${user.birthday}" var="adminBirth" type="date" pattern="****-MM-dd" />
                  <input type="text" readonly="readonly" value="${adminBirth}" style="width:95%; padding: 0px; height:35px; font-size:16px; border:none; padding-left: 12px;"/>
               </c:if>
            </td>
            <td>
               <c:if test="${user.channel eq 'pieca'}">
                  <form:input path="email" value="${user.email}" id="adminEmail${userCnt}" style="width:105%; background-color:#FFFFFF; border:none; color:#000000; padding-left: 3px; font-size:16px; height:35px;"/>
               </c:if>
               <c:if test="${user.channel ne 'pieca'}">
                  <input type="text" value="${user.email}" readonly="readonly" style="width:105%; padding: 0px; height:35px; font-size:16px; border: none; padding-left: 3px;"/>
               </c:if>
            </td>
            <td>
            <input type="button" id="admin_fix${userCnt}" value="수정" onclick="showUserId('${userCnt}')" style="width:50px; height: 35px; background-color: #008000; border:none; color:#FFFFFF; border-radius: 6px;">
            <c:if test="${user.channel eq 'pieca'}">
               <input type="submit" id="admin_submit${userCnt}" value="저장" style="width:50px; height: 35px; background-color: #00B6EF;; border:none; color:#FFFFFF; border-radius: 6px;">
                  </c:if>   
            </td>
         </tr>
         <tr id="AdminUserIdBox${userCnt}">
            <td colspan="4" >
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-share fa-flip-vertical"></i> 아이디 : <form:input path="userid" id="adminUserid" value="${user.userid}" readonly="true" style="width:550px; padding:3px; border:none; height:35px; font-size:16px;"/>
            </td>
         
      </form:form>
      <c:set var="userCnt" value="${userCnt+1}" />
            <td colspan="1">
               <form method="post" action="deleteAdmin" name="deleteForm">
                     <input type="hidden" name="userid" value="${user.userid}">
                     <input type="hidden" name="channel" value="${user.channel}">
                  <input type="submit" id="admin_delete${userCnt}" value="탈퇴" style="width:50px; height: 35px; background-color: #00B6EF;; border:none; color:#FFFFFF; border-radius: 6px;">
               </form>
            </td>
      </c:forEach>
      <c:set var="userCntMax" value="${userCnt}" />
      </table>
      <input type="hidden" id="userCntMax" value="${userCntMax}">
      </div>
      </div>
         </c:if>
         
         
         <c:if test="${login.username != '관리자' }">
      <div id="mypage_car_wrapper" style="transition-duration: 0.5s; border: 1px solid #FFFFFF; border-radius: 5px; margin-bottom: 50px; margin-top: 200px; box-shadow: 0px 2px 4px 0px #1B1B1B; height: 280px;">
         <div id="mypage_car_left_inner" style="float: left; width: 20%; height: 230px; margin: 20px 0px 0px 50px;">
            <div id="mypage_car_left_title" style="font-size: 24px;">
               <span><b>차량 조회</b></span>
            </div>
            <div id="mypage_car_left_desc" style="font-size: 15px;">
               <p>내 차량 정보와 관심차량의 정보를 확인하세요.</p>
            </div>
         </div>
         
         <div id="mypage_car_right_inner" style="float: left; width: 55%; height: 300px; margin: 10px 0px 0px 148px;">
            

            <c:if test="${carData.carno == 0 }">
               <div id="mypage_car_right_car_empty_box" style="width: 430px; position: relative; float: left; margin: 10px 0px 0px 0px;">
                  <div id="mypage_car_right_car_empty" onclick="window.location.href='../car/list'" style="display:flex; width: 420px; height: 220px; font-size:35px; border: 2px dashed #747474; border-radius: 6px; justify-content: center; align-items: center; cursor: pointer;">+</div>
               </div>
            </c:if>
            
            <c:forEach items="${carList}" var="carList">
            <c:if test="${carData.carno > 0 }">
               <c:if test="${carList.no == carData.carno}"> 
                  <div id="mypage_car_right_car_box" onclick="test()" style="width: 430px; position: relative; float: left; margin: 10px 0px 0px 0px;border: 2px solid #747474; border-radius: 6px;">
                     <img src="../img/${carList.img }" id="mypage_car_right_car" style="float:left; width: 420px; height: 220px;">
                     
                     <div id="mypage_car_right_info" style="padding-left: 30px; ">
                        <div id="mypage_car_right_name_box" style="float:left; width:70%; height:80px; font-size:28px; padding: 10px 0px 0px 0px;">
                           ${carList.maker} ${carList.name}
                        </div>
                        <div id="mypage_car_right_type_box" style=" float:left; width:70%; height:40px; font-size:20px; color:#000000;">
                           ${carList.car_size} ${carList.car_type}
                        </div>
                        <div id="mypage_car_right_price_box" style=" float:left; width:30%; height:40px; font-size:16px; color:#000000; padding: 3px 0px 0px 0px;">
                           <c:if test="${carList.min_price != 0 && carList.max_price != 0}">
                              <fmt:formatNumber value="${(carList.min_price + carList.max_price) / 2}"/>만원
                           </c:if>
                           <c:if test="${carList.min_price != 0 && carList.max_price == 0}">
                              <fmt:formatNumber value="${carList.min_price}"/>만원
                           </c:if>
                           <c:if test="${carList.min_price == 0 && carList.max_price == 0}">
                              미제공
                           </c:if>
                        </div>
                        
                        <div id="mypage_car_right_range1_box" style=" float:left; width:70%; height:40px; font-size:20px; color:#000000">
                           <c:if test="${carList.min_range != 0 && carList.max_range != 0}">
                              주행거리 : ${carList.min_range} ~ ${carList.max_range}km
                           </c:if>
                           <c:if test="${carList.min_range != 0 && carList.max_range == 0}">
                              주행거리 : ${carList.min_range}km
                           </c:if>
                           <c:if test="${carList.min_range == 0 && carList.max_range == 0}">
                              주행거리 : 미제공
                           </c:if>
                        </div>
                        <div id="mypage_car_right_range2_box" style=" float:left; width:30%; height:40px; font-size:16px; color:#797979; padding: 5px 0px 0px 0px;">
                           1회 충전시
                        </div>
               
                        <div id="mypage_car_right_fuel1_box" style=" float:left; width:70%; height:60px; font-size:20px; color:#000000">
                           <c:if test="${carList.avg_min_fuel != 0 && carList.avg_max_fuel != 0}">
                              연비 : ${carList.avg_min_fuel / 10} ~ ${carList.avg_max_fuel / 10}km/kWh
                           </c:if>
                           <c:if test="${carList.avg_min_fuel != 0 && carList.avg_max_fuel == 0}">
                              연비 : ${carList.avg_min_fuel / 10}km/kWh
                           </c:if>
                           <c:if test="${carList.avg_min_fuel == 0 && carList.avg_max_fuel == 0}">
                              연비 : 미제공
                           </c:if>
                        </div>
                        <div id="mypage_car_right_fuel2_box" style=" float:left; width:30%; height:60px; font-size:16px; color:#797979; padding: 5px 0px 0px 0px;">
                           <c:if test="${carList.dt_min_fuel != 0 && carList.dt_max_fuel != 0}">
                              <p>도심 : ${(carList.dt_min_fuel + carList.dt_max_fuel) / 20}</p>
                           </c:if>
                           <c:if test="${carList.dt_min_fuel != 0 && carList.dt_max_fuel == 0}">
                              <p>도심 : ${carList.dt_min_fuel / 10}</p>
                           </c:if>
                           <c:if test="${carList.dt_min_fuel == 0 && carList.dt_max_fuel == 0}">
                              <p>도심 : 미제공</p>
                           </c:if>
                           <c:if test="${carList.high_min_fuel != 0 && carList.high_max_fuel != 0}">
                              <p>고속 : ${(carList.high_min_fuel + carList.high_max_fuel) / 20}</p>
                           </c:if>
                           <c:if test="${carList.high_min_fuel != 0 && carList.high_max_fuel == 0}">
                              <p>고속 : ${carList.high_min_fuel / 10}</p>
                           </c:if>
                           <c:if test="${carList.high_min_fuel == 0 && carList.high_max_fuel == 0}">
                              <p>고속 : 미제공</p>
                           </c:if>
                        </div>
                        
                     </div>
                  </div>
            <c:if test="${carLikeData != '[]'}">
               <div id="mypage_car_right_dropdown_box" style="width: 800px; text-align: center; position: relative; float: left;">
                  <div id="mypage_car_right_detail_dropdown_up_box" style="width: 50px; position: relative; float: left; padding-top: 5px;">
                     <span id="mypage_car_right_detail_dropdown_up" class="fa-solid fa-angle-down" style="color: #747474"></span>
                  </div>
                  <div id="mypage_car_right_detail_dropdown_down_box" style="width: 50px; position: relative; float: left; padding-top: 5px;">
                     <span id="mypage_car_right_detail_dropdown_down" class="fa-solid fa-angle-up" style="color: #747474"></span>
                  </div>
               </div>
            </c:if>
               
               </c:if>
               </c:if>
            </c:forEach>
            
            
         </div>
         <div id="mypage_car_right_orderlist_box" style="width: 800px; position: relative; float: left; margin: 0px 0px 0px 50px;">
            <div id="mypage_car_right_orderlist">
            <table>
               <tr style="text-align:left; font-size:18px; color: #747474;">
                  <th width="100px;"></th>
                  <th width="170px;">명칭</th>
                  <th width="130px;">차종</th>
                  <th width="160px;">가격</th>
                  <th width="130px;">주행거리</th>
                  <th width="150px;">연비</th>
               </tr>
            </table>
            <c:forEach items="${carLikeData}" var="carLikeData">
               <c:forEach items="${carList}" var="carList">
               <c:if test="${carLikeData.carno == carList.no}">
                  <table>
                     <tr style="text-align:left; font-size:15px;">
                        <td width=100px;><img src="../img/${carList.img }" id="mypage_car_right_car" style="width:80%"> </td>
                        <td width="170px;"> ${carList.maker} ${carList.name}</td>
                        <td width="130px;">${carList.car_size} ${carList.car_type}</td>
                        <td width="160px;">
                           <c:if test="${carList.min_price != 0 && carList.max_price != 0}">
                              <fmt:formatNumber value="${carList.min_price}"/> ~ <fmt:formatNumber value="${carList.max_price}"/>
                           </c:if>
                           <c:if test="${carList.min_price != 0 && carList.max_price == 0}">
                              <fmt:formatNumber value="${carList.min_price}"/>
                           </c:if>
                           <c:if test="${carList.min_price == 0 && carList.max_price == 0}">
                              미제공
                           </c:if>
                        </td>
                        <td width="130px;">
                           <c:if test="${carList.min_range != 0 && carList.max_range != 0}">
                              ${carList.min_range} ~ ${carList.max_range}
                           </c:if>
                           <c:if test="${carList.min_range != 0 && carList.max_range == 0}">
                              ${carList.min_range}
                           </c:if>
                           <c:if test="${carList.min_range == 0 && carList.max_range == 0}">
                              미제공
                           </c:if>
                        </td>
                        <td width="150px;">
                           <c:if test="${carList.avg_min_fuel != 0 && carList.avg_max_fuel != 0}">
                              ${carList.avg_min_fuel / 10} ~ ${carList.avg_max_fuel / 10}
                           </c:if>
                           <c:if test="${carList.avg_min_fuel != 0 && carList.avg_max_fuel == 0}">
                              ${carList.avg_min_fuel / 10}
                           </c:if>
                           <c:if test="${carList.avg_min_fuel == 0 && carList.avg_max_fuel == 0}">
                              미제공
                           </c:if>                        
                        </td>
                        
                     </tr>
                  </table>
               </c:if>
               </c:forEach>
            </c:forEach>
            
            </div>
         </div>
      </div>
      </c:if>
      
      
      <%-- 카드결제 --%>
      <div id="mypage_card_wrapper" style="transition-duration: 0.5s; border: 1px solid #FFFFFF; border-radius: 5px; margin-bottom: 50px; margin-top: 200px; box-shadow: 0px 2px 4px 0px #1B1B1B; height: 280px;">
         <div id="mypage_card_left_inner" style="float: left; width: 20%; height: 230px; margin: 20px 0px 0px 50px;">
            <div id="mypage_card_left_title" style="font-size: 24px;">
               <span><b>PIECA CARD</b></span>
            </div>
            <div id="mypage_card_left_desc" style="font-size: 15px;">
               <p>카드로 다양한 혜택을 누리세요.</p>
            </div><br><br>
            <c:if test="${loginUser.card != 'y' }">
               <button onclick="win_open('getcard')" style="width: 170px; background-color: #008000; border: 2px solid #008000; border-radius: 6px; color: #FFFFFF; cursor: pointer;">발급하기</button>
            </c:if>
            <c:if test="${loginUser.card == 'y' }">
               <button onclick="win_open('payment')" style="width: 170px; background-color: #008000; border: 2px solid #008000; border-radius: 6px; color: #FFFFFF; cursor: pointer;">충전하기</button>
            </c:if>
         </div>

         <div id="mypage_card_right_inner" style="float: left; width: 55%; height: 300px; margin: 10px 0px 0px 148px;">
            <c:if test="${loginUser.card != 'y' }"> 
               <div id="mypage_card_right_card_empty_box" style="width: 430px; position: relative; float: left; margin: 10px 0px 0px 0px;">
                  <div id="mypage_card_right_card_empty" style="display:flex; width: 420px; height: 220px; font-size:35px; border: 2px dashed #747474; border-radius: 6px; justify-content: center; align-items: center;">+</div>
               </div>
            </c:if>
            
            <c:if test="${loginUser.card == 'y' }"> 
               <div id="mypage_card_right_card_box" style="width: 430px; position: relative; float: left; margin: 10px 0px 0px 0px;">
                  <img src="../img/mypage_card2.png" id="mypage_card_right_card" style="width: 420px; height: 220px; border: 2px solid #747474; border-radius: 6px;">
               </div>
            
            <div id="mypage_card_right_dropdown_box" style="width: 800px; text-align: center; position: relative; float: left;">
               <div id="mypage_card_right_detail_dropdown_up_box" style="width: 50px; position: relative; float: left; padding-top: 5px;">
                  <span id="mypage_card_right_detail_dropdown_up" class="fa-solid fa-angle-down" style="color: #747474"></span>
               </div>
               <div id="mypage_card_right_detail_dropdown_down_box" style="width: 50px; position: relative; float: left; padding-top: 5px;">
                  <span id="mypage_card_right_detail_dropdown_down" class="fa-solid fa-angle-up" style="color: #747474"></span>
               </div>
            </div>
            </c:if>
         </div>
         <div id="mypage_card_right_orderlist_box" style="width: 800px; position: relative; float: left; margin: 0px 0px 0px 50px;">
            <div id="mypage_card_right_orderlist"></div>
         </div>
      </div>
      
      <%-- 비밀번호 수정 --%>
      <div id="basic_pass_wrapper">

         <div id="basic_pass_left_inner">
            <div id="basic_pass_left_title">
               <span><b>비밀번호 변경</b></span>
            </div>
            <div id="basic_pass_left_desc">
               <p>주기적으로 비밀번호를 변경하여 타인의 무단 사용을 방지하세요.</p>
            </div>
         </div>

         <div id="basic_pass_right">

            <form action="password" id="form" method="post" name="f"
               onsubmit="return inchk(this)">

               <%-- xxx --%>

               <div id="change_pass_right_password">
                  <label for="chg_password" id="change_pass_right_password_title">password</label>
               </div>

               <div id="change_pass_right_password_input">
                  <input type="password" id="chg_password" name="password"
                     oninput="chg_pwCheck(password.value)">
               </div>

               <div id="change_pass_right_password_check">
                  <span id="chg_check" class="fa-regular fa-circle-check"></span>
               </div>

               <%-- xxx --%>

               <div id="change_pass_right_current">
                  <label for="chgpass" style="font-size: 16px; color: #747474;">New
                     password</label>
               </div>

               <div id="basic_info_right_password_error">
                  <label id="pwValid" for="chgpass">&nbsp;</label>
               </div>

               <div id="change_pass_right_password_input">
                  <input type="password" id="chgpass" name="chgpass"
                     oninput="passValid()">
               </div>
               <%-- xxx --%>

               <div id="change_pass_right_current2">
                  <label for="chgpass2" style="font-size: 16px; color: #747474;">New
                     password</label>
               </div>

               <div id="change_pass_right_password_input">
                  <input type="password" id="chgpass2" name="chgpass2"
                     oninput="passValid()">
               </div>

               <div id="change_pass_right_button">
                  <input type="submit" id="pw_submit" value="변경">
               </div>
            </form>
         </div>
      </div>
      
      <%-- 회원 탈퇴 --%>
      <div id="basic_delete_wrapper">
         <div id="basic_delete_left_inner">
            <div id="basic_delete_left_title">
               <span><b>회원 탈퇴</b></span>
            </div>
            <div id="basic_delete_left_desc">
               <p>PIECA에서 사용되는 회원님의 정보를 삭제하며, 복구 불가능 합니다.</p>
            </div>
         </div>
         <div id="basic_delete_right">
            <form method="post" action="delete" name="deleteForm">
               <input type="hidden" name="userid" value="${param.userid}">
               <%-- xxx --%>
               <div id="basic_delete_right_password">
                  <input type="hidden" id="userid"
                     value="${sessionScope.loginUser.userid}"> <input
                     type="hidden" id="decesion"> <label for="delete_password"
                     id="basic_delete_right_password_title">password</label>
               </div>

               <div id="basic_delete_right_password_input"
                  style="float: left; margin: -35px 10px 0px -17px;">
                  <input type="password" id="delete_password" name="password"
                     oninput="delete_pwCheck(password.value); security_codeChk();">
               </div>

               <div id="basic_delete_right_password_check">
                  <span id="delete_check" class="fa-regular fa-circle-check"
                     style="color: green;"></span>
               </div>
               <%-- xxx --%>
               <div id="basic_delete_right_password_security">
                  <label for="sec_code" style="font-size: 16px; color: #747474;">보안코드</label>
               </div>
               <div id="basic_delete_right_password_security_show">
                  <input type="text" id="security_code" readonly="readonly">
               </div>
               <%-- xxx --%>
               <div id="basic_delete_right_password_check_logo">
                  <span id="delete_check" class="fa-sharp fa-solid fa-arrows-rotate"
                     onclick="getRandomString();"></span>
               </div>
               <%-- xxx --%>
               <div id="basic_delete_right_password_security2">
                  <label for="sec_code" style="font-size: 16px; color: #747474;">보안코드
                     확인</label>
               </div>
               <%-- xxx --%>
               <div id="basic_delete_right_password_security_input">
                  <input type="text" id="security_code2"
                     oninput="security_codeChk()">
               </div>
               <div id="basic_delete_right_password_check2">
                  <span id="delete_check2" class="fa-regular fa-circle-check"></span>
               </div>

               <div id="basic_delete_right_submit_desc">
                  <p style="font-size: 14px; color: #FFFFFF;">모든 정보가 삭제되며,</p>
                  <p style="font-size: 14px; color: #FFFFFF;">복구는 불가능 합니다.</p>
               </div>
               <div id="basic_delete_right_submit_btn">
                  <input type="submit" id="delete_submit" value="회원 탈퇴">
               </div>
            </form>
         </div>
      </div>
      
</div>
<script type="text/javascript">
function showUserId(cnt) {
   $("#AdminUserIdBox"+cnt).show()
   $("#admin_fix"+cnt).hide()
   $("#admin_submit"+cnt).show()
   $("#adminUsername"+cnt).removeAttr("disabled").css("border","1px solid #000000").css("border-radius","6px").css("padding-left","2px");
   $("#adminPhoneno"+cnt).removeAttr("disabled").css("border","1px solid #000000").css("border-radius","6px").css("padding-left","2px");
   $("#adminBirthday"+cnt).removeAttr("disabled").css("border","1px solid #000000").css("border-radius","6px").css("padding-left","2px");
   $("#adminEmail"+cnt).removeAttr("disabled").css("border","1px solid #000000").css("border-radius","6px").css("padding-left","2px");
}

var isToggled = false;
function test() {
   $("#mypage_car_right_dropdown_box").hide()
  if (!isToggled) {
    $("#mypage_car_right_car").animate({
      "margin": "3% 3% 0% 5%",
      "width": "20%",
      "height": "20%"
    }, {
      "duration": 300
    });
    $("#mypage_car_right_name_box").delay(400).show(500);
    $("#mypage_car_right_type_box").delay(500).show(500);
    $("#mypage_car_right_price_box").delay(600).show(500);
    $("#mypage_car_right_range1_box").delay(700).show(300);
    $("#mypage_car_right_range2_box").delay(800).show(400);
    $("#mypage_car_right_fuel1_box").delay(900).show(400);
    $("#mypage_car_right_fuel2_box").delay(1100).show(500);
    isToggled = true;
  } else {
    $("#mypage_car_right_car").animate({
      "margin": "0% 0% 0% 0%",
      "width": "420",
      "height": "220"
    }, {
      "duration": 500
    });
    $("#mypage_car_right_name_box").hide(0);
    $("#mypage_car_right_type_box").hide(0);
    $("#mypage_car_right_price_box").hide(0);
    $("#mypage_car_right_range1_box").hide(0);
    $("#mypage_car_right_range2_box").hide(0);
    $("#mypage_car_right_fuel1_box").hide(0);
    $("#mypage_car_right_fuel2_box").hide(0);
    isToggled = false;
  }
   $("#mypage_car_right_dropdown_box").show(2500)
}

function win_open(page) {
   var loginUser = sessionStorage.getItem("loginUser");
   if (page == 'payment') {
      var childWindow = window.open("payment", "child", "width=500, height=600, top=150, left=150");
   }
   if (page == 'getcard') {
      var childWindow = window.open("getcard", "child", "width=600, height=600, top=150, left=150");
   }
   childWindow.opener = this;
   childWindow.sessionStorage.setItem("loginUser", loginUser);
}

function movePage(decesion) {
   if (decesion == '1') {
      window.scrollTo(0, 0);
   } else if (decesion == '2') {
      window.scrollTo(0, 400);
   } else if (decesion == '3') {
      window.scrollTo(0, 850);
   } else if (decesion == '4') {
      window.scrollTo(0, 1200);
   } else if (decesion == '5') {
      window.scrollTo(0, 1600);
   }
}

window.onscroll = function() {
   if (window.scrollY < 120) {
      document.getElementById("movepage1").style.color = "#008000";
         document.getElementById("movepage2").style.color = "#5D5D5D";
         document.getElementById("movepage3").style.color = "#5D5D5D";
         document.getElementById("movepage4").style.color = "#5D5D5D";
         document.getElementById("movepage5").style.color = "#5D5D5D";
         document.getElementById("movepage1").style.fontSize = "30px";
         document.getElementById("movepage2").style.fontSize = "22px";
         document.getElementById("movepage3").style.fontSize = "22px";
         document.getElementById("movepage4").style.fontSize = "22px";
         document.getElementById("movepage5").style.fontSize = "22px";
   } else if ((window.scrollY > 350) && (window.scrollY < 750)) {
         document.getElementById("movepage1").style.color = "#5D5D5D";
        document.getElementById("movepage2").style.color = "#008000";
        document.getElementById("movepage3").style.color = "#5D5D5D";
        document.getElementById("movepage4").style.color = "#5D5D5D";
        document.getElementById("movepage5").style.color = "#5D5D5D";
        document.getElementById("movepage1").style.fontSize = "22px";
         document.getElementById("movepage2").style.fontSize = "30px";
         document.getElementById("movepage3").style.fontSize = "22px";
         document.getElementById("movepage4").style.fontSize = "22px";
         document.getElementById("movepage5").style.fontSize = "22px";
   } else if ((window.scrollY > 751) && (window.scrollY < 950)) {
         document.getElementById("movepage1").style.color = "#5D5D5D";
        document.getElementById("movepage2").style.color = "#5D5D5D";
        document.getElementById("movepage3").style.color = "#008000";
        document.getElementById("movepage4").style.color = "#5D5D5D";
        document.getElementById("movepage5").style.color = "#5D5D5D";
        document.getElementById("movepage1").style.fontSize = "22px";
         document.getElementById("movepage2").style.fontSize = "22px";
         document.getElementById("movepage3").style.fontSize = "30px";
         document.getElementById("movepage4").style.fontSize = "22px";
         document.getElementById("movepage5").style.fontSize = "22px";
   } else if ((window.scrollY > 951) && (window.scrollY < 1300)) {
         document.getElementById("movepage1").style.color = "#5D5D5D";
        document.getElementById("movepage2").style.color = "#5D5D5D";
        document.getElementById("movepage3").style.color = "#5D5D5D";
        document.getElementById("movepage4").style.color = "#008000";
        document.getElementById("movepage5").style.color = "#5D5D5D";
        document.getElementById("movepage1").style.fontSize = "22px";
         document.getElementById("movepage2").style.fontSize = "22px";
         document.getElementById("movepage3").style.fontSize = "22px";
         document.getElementById("movepage4").style.fontSize = "30px";
         document.getElementById("movepage5").style.fontSize = "22px";
   } else if ((window.scrollY > 1301) && (window.scrollY < 1600)) {
         document.getElementById("movepage1").style.color = "#5D5D5D";
        document.getElementById("movepage2").style.color = "#5D5D5D";
        document.getElementById("movepage3").style.color = "#5D5D5D";
        document.getElementById("movepage4").style.color = "#5D5D5D";
        document.getElementById("movepage5").style.color = "#008000";
        document.getElementById("movepage1").style.fontSize = "22px";
         document.getElementById("movepage2").style.fontSize = "22px";
         document.getElementById("movepage3").style.fontSize = "22px";
         document.getElementById("movepage4").style.fontSize = "22px";
         document.getElementById("movepage5").style.fontSize = "30px";
   }
   
}
   
$(document).ready(function(){
    $.ajax({
        type:"POST",
        url: "../payment/getOrderList",
        data : {"userid" : $("#userid").val()},
        success:function(result){100000 // 100,000
           let html = "<tr style='text-align:left; font-size:18px; color:#747474;'><th width='300px;'>주문 번호</th><th width='150px'>결제 금액</th><th width='150px'>결제 수단</th><th width='300px'>결제 일시</th></tr>"
           $.each(result,function(i,item){
              html += "<tr style='text-align:left; font-size:15px;'><td>"+result[i].orderno+"</td><td>"+result[i].amount.replace(/\B(?=(\d{3})+(?!\d))/g, ",")+"</td>"
              html += "<td>"+result[i].type+"</td>"
              html += "<td>"+ new Date(result[i].regdate).toLocaleString().replace(/\d+/g,
                 function(match) {
                    if (match.length === 1) { return "0" + match;}
                       else { return match; }
                 }) +"</td></tr>"
           })   
           $("#mypage_card_right_orderlist").html(html);
           if (result == '') {
              $("#mypage_card_right_dropdown_box").hide();
           } else {
              $("#mypage_card_right_dropdown_box").show();
           }
        }
     });
    
let max = $("#userCntMax").val();
for (let i=1; i<=max; i++ ) {
   $("#AdminUserIdBox"+i).hide()
   $("#admin_submit"+i).hide()
   $("#adminUsername"+i).attr("disabled","disabled");
   $("#adminPhoneno"+i).attr("disabled","disabled");
   $("#adminBirthday"+i).attr("disabled","disabled");
   $("#adminEmail"+i).attr("disabled","disabled");
}
      
   $("#mypage_car_right_name_box").hide();
   $("#mypage_car_right_type_box").hide();
   $("#mypage_car_right_price_box").hide();
   $("#mypage_car_right_range1_box").hide();
   $("#mypage_car_right_range2_box").hide();
   $("#mypage_car_right_fuel1_box").hide();
   $("#mypage_car_right_fuel2_box").hide();
   $("#mypage_car_right_orderlist").hide();
   $("#mypage_card_right_orderlist").hide();
   $("#mypage_car_right_detail_dropdown_down_box").hide();
   $("#mypage_card_right_detail_dropdown_down_box").hide();
   $("#username").attr("disabled","disabled");
   $("#email_original").attr("disabled","disabled");
   $("#phoneno").attr("disabled","disabled");
   $("#birthday").attr("disabled","disabled");
   $("#select_email").hide();
   $("#input_email").hide();
   $("#basic_info_right_email_address").hide();
   $("#basic_info_right_birthday_input_update_s2").hide();
   $("#basic_info_right_update").show();
   $("#test11").hide()
   $("#basic_info_right_password").hide()
   $("#basic_info_right_password_input").hide();
   $("#basic_info_right_password_input").hide();
   $("#basic_info_right_password_submit").hide();
   $("#basic_info_right_password_cancel").hide();
   $("#basic_delete_right_password_check_logo").hide();
   $("#basic_delete_right_submit_desc").hide();
   $("#basic_delete_right_submit_btn").hide();   
   $("#chgpass").attr("disabled","disabled");
   $("#chgpass").css("background-color","#D5D5D5");
   $("#chgpass2").css("background-color","#D5D5D5");
   $("#chgpass2").attr("disabled","disabled");
   $("#pw_submit").attr("disabled","disabled");
   $("#up_submit").attr("disabled","disabled");
   $("#delete_submit").attr("disabled","disabled");
   $("#security_code2").attr("disabled","disabled");
   $("#pw_submit").css("background-color","#D5D5D5");
   $("#up_submit").css("background-color","#D5D5D5");
   $("#security_code").css("background-color","#D5D5D5");
   $("#security_code2").css("background-color","#D5D5D5");
   $("#up_check").hide();
   $("#chg_check").hide();
   $("#delete_check").hide();
   $("#delete_check2").hide();
   $("#update_info_wrapper").hide();
      
   if ($("#login_mode").val() == 'pieca') {
      $("#basic_info_right_update").show();
      $("#chg_password").attr('type', 'password');
   } else if ($("#login_mode").val() == 'naver') {
       $("#chg_password").val('Naver회원은 이용 불가능 합니다.');
       $("#delete_password").val('Naver회원은 보안코드로 탈퇴 가능 합니다.');
   } else if ($("#login_mode").val() == 'kakao') {
       $("#phoneno").val('-');
       $("#birthday").val($("#birthday").val().replace(/^0001-/, ""));
       $("#chg_password").val('kakao회원은 이용 불가능 합니다.');
       $("#delete_password").val('kakao회원은 보안코드로 탈퇴 가능 합니다.');
   }
   if ($("#login_mode").val() != 'pieca') {
      $("#basic_info_right_update").hide();
       $("#chg_password").attr('type', 'text');
       $("#chg_password").prop('readonly', true);
       $("#chg_password").css({"background-color":"#F15F5F","border":"2px solid #F15F5F","font-size":"19px","color":"#FFFFFF"});
       $("#change_pass_right_password_title").css("color","#FFFFFF");
       $("#delete_password").attr('type', 'text');
       $("#delete_password").prop('readonly', true);
       $("#delete_password").css({"background-color":"#F15F5F","border":"2px solid #F15F5F","font-size":"19px","color":"#FFFFFF"});
       $("#basic_delete_right_password_title").css("color","#FFFFFF");
       $("#security_code").removeAttr("disabled");
       $("#security_code2").removeAttr("disabled");
       $("#security_code").css("background-color","#FFFFFF");
       $("#security_code2").css("background-color","#FFFFFF");
       $("#basic_delete_right_password_check_logo").show();
       getRandomString()
   }
   
   $("#show_update").click(function(){
      var birthday = $("#birthday").val();
      var email_af = $("#email_af").val();
      
         $("#start_name").val($("#username").val());
         $("#start_birthday").val(birthday);
         $("#start_phoneno").val($("#phoneno").val());
         $("#start_email").val($("#email_original").val());
         $("#start_email_be").val($("#input_email").val());
      
      $("#year").val(birthday.substring(0, 4))
         $("#month").val(birthday.substring(5, 7))
         $("#day").val(birthday.substring(8, 10))
      
        $("#mode_name").val('enable');
         $("#mode_email").val('enable');
         $("#mode_phone").val('enable');
   
         $("#select_email").val(email_af);
         $("#email_original").hide();
         $("#select_email").show();
         $("#input_email").show();
         $("#basic_info_right_email_address").show();
      
         $("#username").removeAttr("disabled");
         $("#email").removeAttr("disabled");
         $("#input_email").removeAttr("disabled");
         $("#phoneno").removeAttr("disabled");
         $("#birthday").removeAttr("disabled");
         $("#username").css("border","2px solid #747474");
         $("#email").css("border","2px solid #747474");
         $("#input_email").css("border","2px solid #747474");
         $("#phoneno").css("border","2px solid #747474");
         $("#birthday").css("border","2px solid #747474");
      
         $("#basic_info_wrapper").css("height","360px");
         $("#basic_info_right_update").hide(0);
      
         $("#basic_info_right_birthday_input_update_s1").hide();
         $("#basic_info_right_birthday_input_update_s2").show();
      
         $("#basic_info_right_password").slideDown(600);
         $("#basic_info_right_password_input").slideDown(610);
         $("#basic_info_right_password_submit").slideDown(610);
         $("#basic_info_right_password_cancel").slideDown(610);
   });
   $("#update_cancel").click(function(){
      var email_af = $("#email_af").val();
       $("#username").val($("#start_name").val());
       $("#birthday").val($("#start_birthday").val());
       $("#phoneno").val($("#start_phoneno").val());
       $("#email_original").val($("#start_email").val());
       $("#input_email").val($("#start_email_be").val());
         
       $("#emailCheck").css("color","#ffffff");
       $("#phonenoCheck").text("");
       $("#password").val('')
         
       $("#mode_email").val('disable');
       $("#mode_phone").val('disable');
         
       $("#select_email").val(email_af);
       $("#email_original").show();
       $("#select_email").hide();
       $("#input_email").hide();
       $("#basic_info_right_email_address").hide();
         
       $("#username").attr("disabled","disabled");
       $("#email").attr("disabled","disabled");
       $("#input_email").attr("disabled","disabled");
       $("#phoneno").attr("disabled","disabled");
       $("#birthday").attr("disabled","disabled");
         
       $("#username").css("border","2px solid #FFFFFF");
       $("#email").css("border","2px solid #FFFFFF");
       $("#input_email").css("border","2px solid #FFFFFF");
       $("#phoneno").css("border","2px solid #FFFFFF");
       $("#birthday").css("border","2px solid #FFFFFF");
         
      $("#basic_info_wrapper").css("height","280px");
       $("#basic_info_right_update").show(0);
         
       $("#basic_info_right_birthday_input_update_s1").show();
       $("#basic_info_right_birthday_input_update_s2").hide();
         
       $("#basic_info_right_password").hide(0);
       $("#basic_info_right_password_input").hide(0);
       $("#basic_info_right_password_submit").hide(0);
       $("#basic_info_right_password_cancel").hide(0);
   });
   
   $("#mypage_card_right_detail_dropdown_up_box").click(function(){
         $("#mypage_card_right_orderlist").fadeIn(1000);
      const div = document.getElementById("mypage_card_right_orderlist");
      const height = div.clientHeight;
      $("#mypage_card_right_detail_dropdown_up_box").hide();
      $("#mypage_card_right_detail_dropdown_down_box").show();
         $("#mypage_card_wrapper").css("height",380+height);
         $("#mypage_card_right_dropdown_box").animate({
           top: height+90
         });
   });
   
   $("#mypage_card_right_detail_dropdown_down").click(function(){
         $("#mypage_card_right_orderlist").fadeOut(100);
      const div = document.getElementById("mypage_card_right_orderlist");
      const height = div.clientHeight;
      $("#mypage_card_right_detail_dropdown_up_box").show();
      $("#mypage_card_right_detail_dropdown_down_box").hide();
      setTimeout(function() {
           $("#mypage_card_wrapper").css("height",280);
         }, 100);
         $("#mypage_card_right_dropdown_box").animate({
           top: -1
         });
   });
   
   $("#mypage_car_right_detail_dropdown_up_box").click(function(){
         $("#mypage_car_right_orderlist").fadeIn(1000);
      const div = document.getElementById("mypage_car_right_orderlist");
      const height = div.clientHeight;
      $("#mypage_car_right_detail_dropdown_up_box").hide();
      $("#mypage_car_right_detail_dropdown_down_box").show();
         $("#mypage_car_wrapper").css("height",380+height);
         $("#mypage_car_right_dropdown_box").animate({
           top: height+90
         });
   });
   
   $("#mypage_car_right_detail_dropdown_down").click(function(){
         $("#mypage_car_right_orderlist").fadeOut(100);
      const div = document.getElementById("mypage_car_right_orderlist");
      const height = div.clientHeight;
      $("#mypage_car_right_detail_dropdown_up_box").show();
      $("#mypage_car_right_detail_dropdown_down_box").hide();
      setTimeout(function() {
           $("#mypage_car_wrapper").css("height",280);
         }, 100);
         $("#mypage_car_right_dropdown_box").animate({
           top: -1
         });
   });
});

function nameChk() {
   var username = $("#username").val();
   const reg = /^[가-힣a-zA-Z]+$/;
   if ((username != '') && (reg.test(username))) {
      $("#usernameCheck").text("사용 가능합니다.");
      $("#usernameCheck").css("color","green");
      $("#mode_name").val("enable");
   } else if (username == '') {
      $("#usernameCheck").text("이름을 입력하세요.");
      $("#usernameCheck").css("color","red");
      $("#mode_name").val("disable");
   } else if (!reg.test(username))  {
      $("#usernameCheck").text("옳바른 형식이 아닙니다.");
      $("#usernameCheck").css("color","red");
      $("#mode_name").val("disable");
   }
}

function emailChk() {
   var email_be = $("#input_email").val();
   var email_af = $("#select_email").val();
   $('#email').val(email_be + '@' + email_af);
   
   if ((email_be != '') && (email_af != null)) {
      $("#emailCheck").text("사용 가능합니다.");
      $("#emailCheck").css("color","green");
      $("#mode_email").val("enable");
   } else if (email_be == '') {
      $("#emailCheck").text("email을 입력하세요.");
      $("#emailCheck").css("color","red");
      $("#mode_email").val("disable");
   } else if (email_af == null)  {
      $("#emailCheck").text("주소를 선택하세요.");
      $("#emailCheck").css("color","red");
      $("#mode_email").val("disable");
   }
}

$("select[name=select_email]").change(function(){
   var email_be = $("#input_email").val();
   var email_af = $(this).val();
   $('#email').val(email_be + '@' + email_af);
});

function phonenoChk() {
   var phoneno = $("#phoneno").val();
   var phonenoLen = $("#phoneno").val().length;
   //
   var reg = /^[0-9]{10,11}$/

   if ((reg.test(phoneno)) && (!phoneno.match(/\-/g) ) ) {
      $("#phonenoCheck").text("사용 가능합니다.");
      $("#phonenoCheck").css("color","green");
      $("#mode_phone").val("enable");
   }  else if (phoneno.match(/\-/g)) {
      $("#phonenoCheck").text("' - '없이 입력하세요.");
      $("#phonenoCheck").css("color","red");
      $("#mode_phone").val("disable");
   } else if (!reg.test(phoneno)) {
      $("#phonenoCheck").text("10, 11자리로 숫자만 입력하세요.");
      $("#phonenoCheck").css("color","red");
      $("#mode_phone").val("disable");
   }
}

$(document).ready(function() {
   var now = new Date();
   var year = now.getFullYear();
   var mon = (now.getMonth() + 1) > 9 ? ''
         + (now.getMonth() + 1) : '0'
         + (now.getMonth() + 1);
   var day = (now.getDate()) > 9 ? ''
         + (now.getDate()) : '0' + (now.getDate());
      //년도 selectbox만들기               
   for (var i = 1900; i <= year; i++) {
      $('#year').append('<option value="' + i + '">' + i + '</option>');
   }
                     // 월별 selectbox 만들기            
   for (var i = 1; i <= 12; i++) {
      var mm = i > 9 ? i : "0" + i;
      $('#month').append('<option value="' + mm + '">' + mm + '</option>');
   }
   
   // 일별 selectbox 만들기
   for (var i = 1; i <= 31; i++) {
      var dd = i > 9 ? i : "0" + i;
      $('#day').append('<option value="' + dd + '">' + dd + '</option>');
   }
   $("#year  > option[value=" + year + "]").attr("selected", "true");
   $("#month  > option[value=" + mon + "]").attr("selected", "true");
   $("#day  > option[value=" + day + "]").attr("selected", "true");
})

function birthChk() {
   var year = $("#year").val();
   var month = $("#month").val();
   var day = $("#day").val();
   $('#birthday').val(year + '-' + month + '-' + day);
}

function upSubmitChk() {
   var mode_name = $("#mode_name").val();
   var mode_email = $("#mode_email").val();
   var mode_phone= $("#mode_phone").val();
   var mode_pass = $("#mode_pass").val();
   
   if ((mode_email == 'enable') && (mode_phone == 'enable') &&
   (mode_pass == 'enable') && (mode_name == 'enable')) {
      $("#up_submit").removeAttr("disabled");
      $("#up_submit").css("background-color","#008000");
      $("#up_submit").css("border","2px solid #008000");
   } else {
      $("#up_submit").attr("disabled","disabled");
      $("#up_submit").css("background-color","#D5D5D5");
      $("#up_submit").css("border","2px solid #D5D5D5");
   }
}


function up_pwCheck(password){
   $.ajax({
      type:"POST",
      url: "pwCheck",
      data : {"userid":$("#userid").val(),
            "password": password },
      success:function(result){
         if (result == true) { // true == 승인 상태
            $("#mode_pass").val("enable");
            $("#up_check").show(500);
         } else {
            $("#mode_pass").val("disable");
            $("#up_check").hide(500);
         }
         upSubmitChk() // delay
      }
   });   
}

function chg_pwCheck(password){
   $.ajax({
      type:"POST",
      url: "pwCheck",
      data : {"userid":$("#userid").val(),
            "password": password },
      success:function(result){
         if (result == true) {
            $("#chg_check").show(500);
            $("#decesion").val("ready");
            $("#chgpass").removeAttr("disabled");
            $("#chgpass").css("background-color","#FFFFFF");
         } else {
            $("#chg_check").hide(500);
            $("#decesion").val("not");
            $("#chgpass").val("");
            $("#chgpass2").val('');
            $("#pwValid").text("");
            $("#chgpass").attr("disabled","disabled");
            $("#chgpass2").attr("disabled","disabled");
            $("#chgpass").css("background-color","#D5D5D5");
            $("#chgpass2").css("background-color","#D5D5D5");
         }
      }
   });
}

function delete_pwCheck(password){
   var security_code = $("#security_code").val();
   var security_code2 = $("#security_code2").val();
   $.ajax({
      type:"POST",
      url: "pwCheck",
      data : {"userid":$("#userid").val(),
            "password": password },
      success:function(result){
         if (result == true) {
            getRandomString();
            $("#delete_check").show(500);
            $("#security_code").removeAttr("disabled");
            $("#security_code2").removeAttr("disabled");
            $("#security_code").css("background-color","#FFFFFF");
            $("#security_code2").css("background-color","#FFFFFF");
            $("#basic_delete_right_password_check_logo").show();
            security_codeChk()
         } else {
            $("#delete_check").hide(500);
            $("#delete_check2").hide(500);
            $("#security_code").val('');
            $("#security_code2").val('');
            $("#security_code").attr("disabled","disabled");
            $("#security_code2").attr("disabled","disabled");
            $("#security_code").css("background-color","#D5D5D5");
            $("#security_code2").css("background-color","#D5D5D5");
            $("#basic_delete_right_password_check_logo").hide();
            security_codeChk()
         }
      }
   });   
}

function security_codeChk(){
   var security_code = $("#security_code").val();
   var security_code2 = $("#security_code2").val();
   if ((security_code == security_code2) && (security_code != '')){
      $("#delete_check2").show(500);
      $("#basic_delete_wrapper").css("height","225px");
        $("#basic_delete_right_submit_desc").show();
         $("#basic_delete_right_submit_btn").show();
         $("#delete_submit").removeAttr("disabled");
      } else {
         $("#delete_check2").hide(500);
         $("#basic_delete_wrapper").css("height","160px");
         $("#basic_delete_right_submit_desc").hide();
         $("#basic_delete_right_submit_btn").hide();
         $("#delete_submit").attr("disabled","disabled");
   }
}

function getRandomString() {
   var letters = "!@#$%^&*ABCDEFGHJKMNPQRSTUVWXYZ23456789";
     var randomString = "";
     $("#security_code2").val('');
     security_codeChk()
     for (var i = 0; i < 6; i++) {
       randomString += letters.charAt(Math.floor(Math.random() * letters.length));
     }
     $('#security_code').val(randomString);
}

function preventCopy(e) {
     e = e || window.event;
     if (e.preventDefault) {
       e.preventDefault();
     } else {
       e.returnValue = false;
     }
   }

$("input").on("copy", preventCopy);
   
//유효성검증
function passValid(){
   var password = $("#chg_password").val();
   var chgpass = $("#chgpass").val();
   var chgpass2 = $("#chgpass2").val();
   var passDec = $("#passDec").val();
   var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~?!@#$%^&*_-]).{8,20}$/
   //reg.test(password) == true => 정규식 일치
   if ((chgpass.length >= 8) && (chgpass.length <= 20) 
         && !(/(\w)\1\1/.test(chgpass))
         && !(chgpass.search(" ") != -1)
         && (reg.test(chgpass))
         && (password != chgpass)){ // 길이 만족할때
      $("#pwValid").text("사용 가능합니다 :)");
      $("#pwValid").css("color","green");
      $("#passDec").val("true");
      $("#chgpass2").removeAttr("disabled");
      $("#chgpass2").css("background-color","#FFFFFF");
   } else if (/(\w)\1\1/.test(chgpass)) {
      $("#pwValid").text("3번이상 반복되는 문자는 불가능 합니다.");
      $("#pwValid").css("color","red");
      $("#passDec").val("false");
      $("#chgpass2").attr("disabled","disabled");
      $("#chgpass2").css("background-color","#D5D5D5");
      $("#chgpass2").val('');
   } else if (chgpass.search(" ") != -1) {
      $("#pwValid").text("공백은 사용 불가능 합니다.");
      $("#pwValid").css("color","red");
      $("#passDec").val("false");
      $("#chgpass2").attr("disabled","disabled");
      $("#chgpass2").css("background-color","#D5D5D5");
      $("#chgpass2").val('');
   } else if (!reg.test(chgpass)) {
      $("#pwValid").text("대소문자, 숫자, 특수문자, 8~20자리");
      $("#pwValid").css("color","red");
      $("#passDec").val("false");
      $("#chgpass2").attr("disabled","disabled");
      $("#chgpass2").css("background-color","#D5D5D5");
      $("#chgpass2").val('');
   } else if (password == chgpass) {
      $("#pwValid").text("기존 비밀번호와 다르게 입력 하세요.");
      $("#pwValid").css("color","red");
      $("#passDec").val("false");
      $("#chgpass2").attr("disabled","disabled");
      $("#chgpass2").css("background-color","#D5D5D5");
      $("#chgpass2").val('');
      
   }
   
   if (chgpass != "" || chgpass2 != "") {
      if ((chgpass == chgpass2)) {
         $("#pw_submit").removeAttr("disabled");
         $("#pw_submit").css("background-color","#008000");
         $("#pw_submit").css("border","2px solid #008000");
      } else if (chgpass != chgpass2) {
         $("#pw_submit").attr("disabled","disabled");
         $("#pw_submit").css("background-color","#D5D5D5");
         $("#pw_submit").css("border","2px solid #D5D5D5");
      }   
   }
}


</script>

</body>

</html>