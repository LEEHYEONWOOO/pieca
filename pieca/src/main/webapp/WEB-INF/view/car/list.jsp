<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>차량 목록</title>
<style>

</style>
</head>
<body>
<div style="float:left; margin:5% 0% 0% 10%;">
   <input type="hidden" id="car_list_userid" value="${loginUser.userid}">
   <div id="car_list_out_container" style="float:left; width:40%; margin: 0% 0% 11% 0%;">
      <c:forEach items="${carList}" var="item">
      <c:if test="${item.no%2==1}">
         <div id="car_list_in_container${item.no}" onload="test(${item.no})" onmouseover="zoom('${item.no}')"style="float:left; width:90%; cursor:pointer; border: 0px solid #747474; border-radius:6px; margin: 0% 0% 10% 10%; box-shadow: rgba(17, 17, 26, 0.1) 0px 8px 24px, rgba(17, 17, 26, 0.1) 0px 16px 56px, rgba(17, 17, 26, 0.1) 0px 24px 80px;">
            <div id="car_list_title_box" >
            
            
               <div id="car_list_mycar_box" style="background-color:red; float:left; width:100%; font-size:20px; margin:0% 0% 1% 0%;">
                  <button id="car_mycar${item.no}" onclick="mycar('${item.no}','${loginUser.userid}')" style="float:right; background-color: #FFFFFF; border:0px; cursor: pointer;"><i class="fa-solid fa-car"></i> 내 차량 추가</button>
               </div>
               
               
               <c:if test="${item.imgcnt == 4}">
                  <div id="car_list_left_btn" onclick="imgLeft('${item.no}')" style="background-color:red; float:left; width:6%; height:247px;; padding: 16.5% 0% 0% 1%;">
                     <span class="fa-solid fa-chevron-left" style="font-size:35px;"></span>
                  </div>
                  <img src="../img/${item.img.substring(0, item.img.length() - 5)}${Math.round(Math.random() * 3) + 1}.png" id="car_list_title${item.no}" onclick="show('${item.no}')" style="background-color:yellow; width:85%; transition-duration: 0.5s; margin:0% 0% 0% 1.5%;">
                  <div id="car_list_right_btn" onclick="imgRight('${item.no}')" style="background-color:red; float:right; width:6%; height:247px; padding: 16.5% 0% 0% 0%;">
                     <span class="fa-solid fa-chevron-right" style="font-size:35px;"></span>
                  </div>
               </c:if>
               <c:if test="${item.imgcnt != 4}">
                  <div id="car_list_left_btn" style="float:left; width:6%; height:187px; padding: 16.5% 0% 0% 1%;">
                  </div>
                  <img src="../img/${item.img}" id="car_list_title${item.no}" onclick="show('${item.no}')" style="width:85%; transition-duration: 0.5s; margin:0% 0% 0% 1.5%;">
                  <div id="car_list_right_btn" style="float:right; width:6%; height:187px;padding: 16.5% 0% 0% 0%;">
                  </div>
               </c:if>
            </div>
            <div id="car_list_maker_name" onclick="show('${item.no}')" style="float:left; width:50%; font-size:30px; margin: 0% 0% 0% 15%;">
               ${item.maker}&nbsp;&nbsp;${item.name}
            </div>
            <div id ="car_list_like_box" onclick="like('${item.no}','${loginUser.userid}')" style="float:left; font-size:30px;">
               <span id="car_list_like_ok${item.no}" class="fa-solid fa-heart" style="color: #F15F5F;"></span>
               <span id="car_list_like_no${item.no}" class="fa-regular fa-heart"></span>
            </div>
            
            <div id="car_list_like_total_box" style="float:left; font-size:30px; margin-left:2%;">
               <span id ="car_list_like_total${item.no}"></span>
            </div>
            
            <div id ="car_list_description" onclick="show('${item.no}')" style="width:100%; height:230px;">
            <div id="car_list_size_type" style="float:left; width:50%; font-size:20px; margin: 0.5% 0% 2% 15%; color:#747474">
               ${item.car_size}&nbsp;&nbsp;${item.car_type}
            </div>
            <div id="car_list_capacity_main" style="float:left; width:50%; height:45px; font-size:18px; margin: 0% 0% 0% 15%">
               <c:if test="${item.min_capacity != 0 && item.max_capacity != 0}">
                  용량 : ${item.min_capacity / 10} ~ ${item.max_capacity/ 10}kWh
               </c:if>
               <c:if test="${item.min_capacity != 0 && item.max_capacity == 0}">
                  용량 : ${item.min_capacity/ 10}kWh
               </c:if>
               <c:if test="${item.min_capacity == 0 && item.max_capacity == 0}">
                  용량 : 미제공
               </c:if>
            </div>
            <div id="car_list_capacity_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 0% 0%;  color:#747474">
               배터리
            </div>
            
            <div id="car_list_range_main" style="float:left; width:50%; height:45px; font-size:18px; margin: 0% 0% 0% 15%">
               <c:if test="${item.min_range != 0 && item.max_range != 0}">
                  주행거리 : ${item.min_range} ~ ${item.max_range}km
               </c:if>
               <c:if test="${item.min_range != 0 && item.max_range == 0}">
                  주행거리 : ${item.min_range}km
               </c:if>
               <c:if test="${item.min_range == 0 && item.max_range == 0}">
                  주행거리 : 미제공
               </c:if>
            </div>
            <div id="car_list_range_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 0% 0%;  color:#747474">
               1회 충전시
            </div>
            
            <div id="car_list_fuel_main" style="float:left; width:50%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
               <c:if test="${item.avg_min_fuel != 0 && item.avg_max_fuel != 0}">
                  연비 : ${item.avg_min_fuel / 10} ~ ${item.avg_max_fuel / 10}km/kWh
               </c:if>
               <c:if test="${item.avg_min_fuel != 0 && item.avg_max_fuel == 0}">
                  연비 : ${item.avg_min_fuel / 10}km/kWh
               </c:if>
               <c:if test="${item.avg_min_fuel == 0 && item.avg_max_fuel == 0}">
                  연비 : 미제공
               </c:if>
            </div>
            <div id="car_list_fuel_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 3% 0%;  color:#747474">
               <c:if test="${item.dt_min_fuel != 0 && item.dt_max_fuel != 0}">
                  <p>도심 : ${item.dt_min_fuel / 10} ~ ${item.dt_max_fuel / 10}km/kWh</p>
               </c:if>
               <c:if test="${item.dt_min_fuel != 0 && item.dt_max_fuel == 0}">
                  <p>도심 : ${item.dt_min_fuel / 10}km/kWh</p>
               </c:if>
               <c:if test="${item.dt_min_fuel == 0 && item.dt_max_fuel == 0}">
                  <p>도심 : 미제공</p>
               </c:if>
               <c:if test="${item.high_min_fuel != 0 && item.high_max_fuel != 0}">
                  <p>고속 : ${item.high_min_fuel / 10} ~ ${item.high_max_fuel / 10}km/kWh</p>
               </c:if>
               <c:if test="${item.high_min_fuel != 0 && item.high_max_fuel == 0}">
                  <p>고속 : ${item.high_min_fuel / 10}km/kWh</p>
               </c:if>
               <c:if test="${item.high_min_fuel == 0 && item.high_max_fuel == 0}">
                  <p>고속 : 미제공</p>
               </c:if>
            </div>
            
            <div id="car_list_etc${item.no}" style="display: none;">
               <div id="car_list_output_main" style="float:left; width:50%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  <c:if test="${item.min_output != 0 && item.max_output != 0}">
                     출력 : ${item.min_output} ~ ${item.max_output}kW
                  </c:if>
                  <c:if test="${item.min_output != 0 && item.max_output == 0}">
                     출력 : ${item.min_output}kW
                  </c:if>
                  <c:if test="${item.min_output == 0 && item.max_output == 0}">
                     출력 : 미제공
                  </c:if>
               </div>
               <div id="car_list_fuel_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 0% 0%;  color:#747474">
                  <c:if test="${item.min_output_motor != 0 && item.max_output_motor != 0}">
                     모터 : ${item.min_output_motor} ~ ${item.max_output_motor}hp
                  </c:if>
                  <c:if test="${item.min_output_motor != 0 && item.max_output_motor == 0}">
                     모터 : ${item.min_output_motor}hp
                  </c:if>
                  <c:if test="${item.min_output_motor == 0 && item.max_output_motor == 0}">
                     모터 : 미제공
                  </c:if>
               </div>
               
               <div id="car_list_torque_main" style="float:left; width:50%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  <c:if test="${item.min_torque != 0 && item.max_torque != 0}">
                     토크 : ${item.min_torque} ~ ${item.max_torque}Nm
                  </c:if>
                  <c:if test="${item.min_torque != 0 && item.max_torque == 0}">
                     토크 : ${item.min_torque}Nm
                  </c:if>
                  <c:if test="${item.min_torque == 0 && item.max_torque == 0}">
                     토크 : 미제공
                  </c:if>
               </div>
               <div id="car_list_torque_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 0% 0%;  color:#747474">
                  <c:if test="${item.min_torque_motor != 0 && item.max_torque_motor != 0}">
                     모터 : ${item.min_torque_motor / 10} ~ ${item.max_torque_motor / 10}kg.m
                  </c:if>
                  <c:if test="${item.min_torque_motor != 0 && item.max_torque_motor == 0}">
                     모터 : ${item.min_torque_motor / 10}kg.m
                  </c:if>
                  <c:if test="${item.min_torque_motor == 0 && item.max_torque_motor == 0}">
                     모터 : 미제공
                  </c:if>
               </div>
            
               <div style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  전장 : <fmt:formatNumber value="${item.overall_length}"/>mm
               </div>
            
               <div style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  전고 : <fmt:formatNumber value="${item.overall_height}"/>mm
               </div>
            
               <div style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  전폭 : <fmt:formatNumber value="${item.overall_width}"/>mm
               </div>
            
               <div style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  축거 : <fmt:formatNumber value="${item.wheelbase}"/>mm
               </div>
               </div>
            </div>
         </div> <%-- main --%>
      </c:if>
      </c:forEach>
   </div>
   
   <div id="car_list_out_container" style="float:left; width:40%; margin: 0% 0% 13% 1%;">
      <c:forEach items="${carList}" var="item">
      <c:if test="${item.no%2==0}">
         <div id="car_list_in_container${item.no}" onload="test(${item.no})" onmouseover="zoom('${item.no}')"style="float:left; width:90%; cursor:pointer; border: 0px solid #747474; border-radius:6px; margin: 0% 0% 10% 10%; box-shadow: rgba(17, 17, 26, 0.1) 0px 8px 24px, rgba(17, 17, 26, 0.1) 0px 16px 56px, rgba(17, 17, 26, 0.1) 0px 24px 80px;">
            <div id="car_list_title_box" >
               <c:if test="${item.imgcnt == 4}">
                  <div id="car_list_left_btn" onclick="imgLeft('${item.no}')" style="float:left; width:6%; height:187px; padding: 16.5% 0% 0% 1%;">
                     <span class="fa-solid fa-chevron-left" style="font-size:35px;"></span>
                  </div>
                  <img src="../img/${item.img.substring(0, item.img.length() - 5)}${Math.round(Math.random() * 3) + 1}.png" id="car_list_title${item.no}" onclick="show('${item.no}')" style="width:85%; transition-duration: 0.5s; margin:0% 0% 0% 1.5%;">
                  <div id="car_list_right_btn" onclick="imgRight('${item.no}')" style="float:right; width:6%; height:187px;padding: 16.5% 0% 0% 0%;">
                     <span class="fa-solid fa-chevron-right" style="font-size:35px;"></span>
                  </div>
               </c:if>
               <c:if test="${item.imgcnt != 4}">
                  <div id="car_list_left_btn" style="float:left; width:6%; height:187px; padding: 16.5% 0% 0% 1%;">
                  </div>
                  <img src="../img/${item.img}" id="car_list_title${item.no}" onclick="show('${item.no}')" style="width:85%; transition-duration: 0.5s; margin:0% 0% 0% 1.5%;">
                  <div id="car_list_right_btn" style="float:right; width:6%; height:187px;padding: 16.5% 0% 0% 0%;">
                  </div>
               </c:if>
            </div>
            <div id="car_list_maker_name" onclick="show('${item.no}')" style="float:left; width:50%; font-size:30px; margin: 0% 0% 0% 15%;">
               ${item.maker}&nbsp;&nbsp;${item.name}
            </div>
            <div id ="car_list_like_box" onclick="like('${item.no}','${loginUser.userid}')" style="float:left; font-size:30px;">
               <span id="car_list_like_ok${item.no}" class="fa-solid fa-heart" style="color: #F15F5F;"></span>
               <span id="car_list_like_no${item.no}" class="fa-regular fa-heart"></span>
            </div>
            
            <div id="car_list_like_total_box" style="float:left; font-size:30px; margin-left:2%;">
               <span id ="car_list_like_total${item.no}"></span>
            </div>
            
            <div id ="car_list_description" onclick="show('${item.no}')" style="width:100%; height:230px;">
            <div id="car_list_size_type" style="float:left; width:100%; font-size:20px; margin: 0.5% 0% 2% 15%; color:#747474">
               ${item.car_size}&nbsp;&nbsp;${item.car_type}
            </div>
            
            <div id="car_list_capacity_main" style="float:left; width:50%; height:45px; font-size:18px; margin: 0% 0% 0% 15%">
               <c:if test="${item.min_capacity != 0 && item.max_capacity != 0}">
                  용량 : ${item.min_capacity / 10} ~ ${item.max_capacity/ 10}kWh
               </c:if>
               <c:if test="${item.min_capacity != 0 && item.max_capacity == 0}">
                  용량 : ${item.min_capacity/ 10}kWh
               </c:if>
               <c:if test="${item.min_capacity == 0 && item.max_capacity == 0}">
                  용량 : 미제공
               </c:if>
            </div>
            <div id="car_list_capacity_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 0% 0%;  color:#747474">
               배터리
            </div>
            
            <div id="car_list_range_main" style="float:left; width:50%; height:45px; font-size:18px; margin: 0% 0% 0% 15%">
               <c:if test="${item.min_range != 0 && item.max_range != 0}">
                  주행거리 : ${item.min_range} ~ ${item.max_range}km
               </c:if>
               <c:if test="${item.min_range != 0 && item.max_range == 0}">
                  주행거리 : ${item.min_range}km
               </c:if>
               <c:if test="${item.min_range == 0 && item.max_range == 0}">
                  주행거리 : 미제공
               </c:if>
            </div>
            <div id="car_list_range_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 0% 0%;  color:#747474">
               1회 충전시
            </div>
            
            <div id="car_list_fuel_main" style="float:left; width:50%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
               <c:if test="${item.avg_min_fuel != 0 && item.avg_max_fuel != 0}">
                  연비 : ${item.avg_min_fuel / 10} ~ ${item.avg_max_fuel / 10}km/kWh
               </c:if>
               <c:if test="${item.avg_min_fuel != 0 && item.avg_max_fuel == 0}">
                  연비 : ${item.avg_min_fuel / 10}km/kWh
               </c:if>
               <c:if test="${item.avg_min_fuel == 0 && item.avg_max_fuel == 0}">
                  연비 : 미제공
               </c:if>
            </div>
            <div id="car_list_fuel_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 3% 0%;  color:#747474">
               <c:if test="${item.dt_min_fuel != 0 && item.dt_max_fuel != 0}">
                  <p>도심 : ${item.dt_min_fuel / 10} ~ ${item.dt_max_fuel / 10}km/kWh</p>
               </c:if>
               <c:if test="${item.dt_min_fuel != 0 && item.dt_max_fuel == 0}">
                  <p>도심 : ${item.dt_min_fuel / 10}km/kWh</p>
               </c:if>
               <c:if test="${item.dt_min_fuel == 0 && item.dt_max_fuel == 0}">
                  <p>도심 : 미제공</p>
               </c:if>
               <c:if test="${item.high_min_fuel != 0 && item.high_max_fuel != 0}">
                  <p>고속 : ${item.high_min_fuel / 10} ~ ${item.high_max_fuel / 10}km/kWh</p>
               </c:if>
               <c:if test="${item.high_min_fuel != 0 && item.high_max_fuel == 0}">
                  <p>고속 : ${item.high_min_fuel / 10}km/kWh</p>
               </c:if>
               <c:if test="${item.high_min_fuel == 0 && item.high_max_fuel == 0}">
                  <p>고속 : 미제공</p>
               </c:if>
            </div>
            
            <div id="car_list_etc${item.no}" style="display: none;">
               <div id="car_list_output_main" style="float:left; width:50%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  <c:if test="${item.min_output != 0 && item.max_output != 0}">
                     출력 : ${item.min_output} ~ ${item.max_output}kW
                  </c:if>
                  <c:if test="${item.min_output != 0 && item.max_output == 0}">
                     출력 : ${item.min_output}kW
                  </c:if>
                  <c:if test="${item.min_output == 0 && item.max_output == 0}">
                     출력 : 미제공
                  </c:if>
               </div>
               <div id="car_list_fuel_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 0% 0%;  color:#747474">
                  <c:if test="${item.min_output_motor != 0 && item.max_output_motor != 0}">
                     모터 : ${item.min_output_motor} ~ ${item.max_output_motor}hp
                  </c:if>
                  <c:if test="${item.min_output_motor != 0 && item.max_output_motor == 0}">
                     모터 : ${item.min_output_motor}hp
                  </c:if>
                  <c:if test="${item.min_output_motor == 0 && item.max_output_motor == 0}">
                     모터 : 미제공
                  </c:if>
               </div>
               
               <div id="car_list_torque_main" style="float:left; width:50%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  <c:if test="${item.min_torque != 0 && item.max_torque != 0}">
                     토크 : ${item.min_torque} ~ ${item.max_torque}Nm
                  </c:if>
                  <c:if test="${item.min_torque != 0 && item.max_torque == 0}">
                     토크 : ${item.min_torque}Nm
                  </c:if>
                  <c:if test="${item.min_torque == 0 && item.max_torque == 0}">
                     토크 : 미제공
                  </c:if>
               </div>
               <div id="car_list_torque_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 0% 0%;  color:#747474">
                  <c:if test="${item.min_torque_motor != 0 && item.max_torque_motor != 0}">
                     모터 : ${item.min_torque_motor / 10} ~ ${item.max_torque_motor / 10}kg.m
                  </c:if>
                  <c:if test="${item.min_torque_motor != 0 && item.max_torque_motor == 0}">
                     모터 : ${item.min_torque_motor / 10}kg.m
                  </c:if>
                  <c:if test="${item.min_torque_motor == 0 && item.max_torque_motor == 0}">
                     모터 : 미제공
                  </c:if>
               </div>
            
               <div style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  전장 : <fmt:formatNumber value="${item.overall_length}"/>mm
               </div>
            
               <div style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  전고 : <fmt:formatNumber value="${item.overall_height}"/>mm
               </div>
            
               <div style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  전폭 : <fmt:formatNumber value="${item.overall_width}"/>mm
               </div>
            
               <div style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  축거 : <fmt:formatNumber value="${item.wheelbase}"/>mm
               </div>
               </div>
            </div>
         </div> <%-- main --%>
      </c:if>
</c:forEach>
   </div>
   
   
</div>


<script>
function test() {
   alert('test 함수 동작')
}

$(document).ready(function(){
   var userid = $("#car_list_userid").val() // userid
   carno_max = Number('${maxnum}'); // 45
   for (var i = 1; i <= carno_max; i++ ){
      likedec(i,userid)
      liketotal(i)
   }
})

function setimg(no) {
   const img = document.getElementById("car_list_title"+no);
   const src = img.src;
   const cardata = src.split("car_");
   const numdata = src.split("img/");
   const carName = cardata[1].slice(0,-5);
   const imgNum = numdata[1].slice(-5,-4);
   
   if (imgNum == 1) {
      img.src = "../img/car_"+carName+"4.png";
   } else if (imgNum == 4) {
      img.src = "../img/car_"+carName+"3.png";
   } else if (imgNum == 3) {
      img.src = "../img/car_"+carName+"2.png";
   } else if (imgNum == 2) {
      img.src = "../img/car_"+carName+"1.png";
   }
}

function show(no) {
   var div_etc = document.getElementById("car_list_etc" + no);
   if (div_etc.style.display == "block") {
      div_etc.style.display = "none";
   } else {
      div_etc.style.display = "block";
   }
}

function zoom(no) {
   var div_title = document.getElementById("car_list_title" + no);
   div_title.style.transform = "scale(1.05)";
   
   car_list_in_container = document.getElementById("car_list_in_container" + no);
   car_list_in_container.addEventListener("mouseleave", function() {
      div_title.style.transform = "scale(1)";
   });
}

function imgLeft(no) {
   const img = document.getElementById("car_list_title"+no);
   const src = img.src;
   const cardata = src.split("car_");
   const numdata = src.split("img/");
   const carName = cardata[1].slice(0,-5);
   const imgNum = numdata[1].slice(-5,-4);
   
   if (imgNum == 1) {
      img.src = "../img/car_"+carName+"4.png";
   } else if (imgNum == 4) {
      img.src = "../img/car_"+carName+"3.png";
   } else if (imgNum == 3) {
      img.src = "../img/car_"+carName+"2.png";
   } else if (imgNum == 2) {
      img.src = "../img/car_"+carName+"1.png";
   }
}

function imgRight(no) {
   const img = document.getElementById("car_list_title"+no);
   const src = img.src;
   const data = src.split("img/");
   const cardata = src.split("car_");
   const numdata = src.split("img/");
   const carName = cardata[1].slice(0,-5);
   const imgNum = numdata[1].slice(-5,-4);
   
   if (imgNum == 1) {
      img.src = "../img/car_"+carName+"2.png";
   } else if (imgNum == 2) {
      img.src = "../img/car_"+carName+"3.png";
   } else if (imgNum == 3) {
      img.src = "../img/car_"+carName+"4.png";
   } else if (imgNum == 4) {
      img.src = "../img/car_"+carName+"1.png";
   }
}

function like(carno,userid){
   if (userid == '') {
      alert('로그인이 필요한 기능입니다.')
   } else {
      $.ajax({
         type:"POST",
         url: "../car/carlike",
         data : {"carno":carno,
               "userid": userid},
         success:function(result){
            //console.log(result)
            if (result == true) {
               $("#car_list_like_ok"+carno).hide();
               $("#car_list_like_no"+carno).show();
            } else if (result == false){
               $("#car_list_like_ok"+carno).show();
               $("#car_list_like_no"+carno).hide();
            }
            liketotal(carno)
            $("#car_list_like_ok"+carno).css("opacity", 0);
            $("#car_list_like_ok"+carno).animate({
               opacity: 1
            }, 300);
            $("#car_list_like_no"+carno).css("opacity", 0);
            $("#car_list_like_no"+carno).animate({
               opacity: 1
            }, 300);
         }
      });
   }
}

function likedec(carno,userid){
   if (userid == '') {
      $("#car_list_like_ok"+carno).hide();
   } else {
      $.ajax({
            type:"POST",
            url: "../car/carlikedec",
            data : {"carno":carno,
                  "userid": userid},
            success:function(result){
               //console.log(carno+'//'+result)
               if (result == false) {
                  $("#car_list_like_ok"+carno).hide();
                  $("#car_list_like_no"+carno).show();
               } else if (result == true){
                  $("#car_list_like_ok"+carno).show();
                  $("#car_list_like_no"+carno).hide();
               }
            }
         });
   }
}

function liketotal(carno){
   $.ajax({
      type : "POST",
      url : "../car/carliketotal",
      data : {
         "carno" : carno
      },
      success : function(result) {
         $("#car_list_like_total"+carno).text(result);
         $("#car_list_like_total"+carno).css("opacity", 0);
         $("#car_list_like_total"+carno).animate({
            opacity: 1
         }, 500);
      }
   });
}

function mycar(carno,userid){
   if (userid == '') {
      alert('로그인이 필요한 기능입니다.')
   } else {
      $.ajax({
         type:"POST",
         url: "../car/mycar",
         data : {"carno":carno,
               "userid": userid},
         success:function(result){
            console.log(result)
            if (result == true) {
            } else if (result == false){
            }
            /*
            liketotal(carno)
            $("#car_list_like_ok"+carno).css("opacity", 0);
            $("#car_list_like_ok"+carno).animate({
               opacity: 1
            }, 300);
            $("#car_list_like_no"+carno).css("opacity", 0);
            $("#car_list_like_no"+carno).animate({
               opacity: 1
            }, 300);
            */
         }
      });
   }
}
</script>   
   
      
   
</body>
</html>