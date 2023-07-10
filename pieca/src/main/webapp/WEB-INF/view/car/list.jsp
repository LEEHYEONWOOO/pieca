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
<div style="float:left; width:1920px; margin-top: 100px; height:610px;">
<div style="float:left; width:65%; margin: 0% 0% 0% 17.5%; height:610px;">
<c:set var="rank_index" value="1" />
<div class="prev" onclick="prevSlide()" style="position:relative; float:left;  width:3%; height:610px; font-size:35px;">
      <i class="fa-solid fa-chevron-left" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);"></i>
   </div>
<c:forEach items="${rank5_Car}" var="rank5">
   <c:forEach items="${carList_all}" var="item"> 
      <c:if test="${rank5.carno == item.no}">
         <div class="slideshow-container">
            <c:if test="${rank_index == 1}">
                 <div class="mySlideDiv fade active">
                    <div style="width:37%; float:left; text-align: right;">
                       <c:if test="${rank_index == 1}">
                     <img src="../img/car_rank_1.png" style="width:60px;">
                        </c:if>
                     </div>
                     <div style="width:60%; float:left; font-size:30px; padding:0.5% 0% 0% 1%;">
                  ${item.maker} ${item.name}
                     </div>
                     <div style="width:94%; float:left;">
                       <img src="../img/${item.img}" style="width:90%; height:550px;">
                    </div> 
                 </div>
              </c:if>
            
               <c:if test="${rank_index != 1}">
                 <div class="mySlideDiv fade">
                    <div style="width:37%; float:left; text-align: right;">
                        <c:if test="${rank_index == 2}">
                     <img src="../img/car_rank_2.png" style="width:60px;">
                        </c:if>
                        <c:if test="${rank_index == 3}">
                     <img src="../img/car_rank_3.png" style="width:60px;">
                        </c:if>
                        <c:if test="${rank_index > 3}">
                     <img src="../img/car_rank_45.png" style="width:60px;">
                        </c:if>
                     </div>
                     <div style="width:60%; float:left; font-size:30px; padding:0.5% 0% 0% 1%;">
                  ${item.maker} ${item.name}
                     </div>
                     <div style="width:94%; float:left;">
                        <img src="../img/${item.img}" style="width:90%; height:550px;">
                     </div> 
                 </div>
               </c:if>
         </div>
         <c:set var="rank_index" value="${rank_index+1}" />
      </c:if>
   </c:forEach>
</c:forEach>
<div class="next" onclick="nextSlide()" style="position:relative; float:left; width:3%; margin-top: -4.5%; height:610px; font-size:35px; justify-content: center; align-items: center; text-align: center;">
   <i class="fa-solid fa-chevron-right" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);"></i>
</div>
</div>
</div>

   
<div id="imgDot" style="float:left; width:1920px; padding: 0px 0px 0px 37%;">
   <div id="imgDot_0" style="float:left; width:40px; height:40px; background-color: #E0E0E0; border-radius: 100px; margin-left:50px; box-shadow: 0px 0px 5px 0px #000000;"></div>
   <div id="imgDot_1" style="float:left; width:40px; height:40px; background-color: #E0E0E0; border-radius: 100px; margin-left:50px; box-shadow: 0px 0px 5px 0px #000000;"></div>
      <div id="imgDot_2" style="float:left; width:40px; height:40px; background-color: #E0E0E0; border-radius: 100px; margin-left:50px; box-shadow: 0px 0px 5px 0px #000000;"></div>
      <div id="imgDot_3" style="float:left; width:40px; height:40px; background-color: #E0E0E0; border-radius: 100px; margin-left:50px; box-shadow: 0px 0px 5px 0px #000000;"></div>
      <div id="imgDot_4" style="float:left; width:40px; height:40px; background-color: #E0E0E0; border-radius: 100px; margin-left:50px; box-shadow: 0px 0px 5px 0px #000000;"></div>
</div>



<div style="float:left; width:547px; height:50px; margin:10% 0% 0% 17.5%">
<input type="hidden" value="${mycar.carno}" id="mycar">
<form action="list" method="post">
   <select name="maker" id="maker" style="padding-left:10px; font-size:20px; width:142px; height:47px; border:2px solid #747474; border-radius:6px;">
      <c:if test="${maker_selected!=null}">
            <option value="${maker_selected}">${maker_selected}</option>
            <option value="">- 제조사 -</option>
      </c:if>
      <c:if test="${maker_selected==null}">
         <option style="color: #000000;" value=>- 제조사 -</option>
      </c:if>
        <c:forEach items="${makers}" var="maker_option">
         <c:if test="${maker_selected ne maker_option.maker}">
            <option value="${maker_option.maker}">${maker_option.maker}</option>
         </c:if>
      </c:forEach>
   </select>

   <select name="car_size" id="car_size" style="padding-left:10px; font-size:20px; width:142px; height:47px; border:2px solid #747474; border-radius:6px;">
      <c:if test="${car_size_selected!=null}">
            <option value="${car_size_selected}">${car_size_selected}</option>
            <option value="">- 크기 -</option>
         </c:if>
         <c:if test="${car_size_selected==null}">
         <option style="color: #000000;" value=>- 크기 -</option>
         </c:if>
        <c:forEach items="${car_sizes}" var="car_size_option">
          <c:if test="${car_size_selected ne car_size_option.car_size}">
               <option value="${car_size_option.car_size}">${car_size_option.car_size}</option>
          </c:if>
        </c:forEach>
   </select>

   <select name="car_type" id="car_type" style="padding-left:10px; font-size:20px; width:142px; height:47px; border:2px solid #747474; border-radius:6px;">
      <c:if test="${car_type_selected!=null}">
         <option value="${car_type_selected}">${car_type_selected}</option>
         <option value="">- 차종 -</option>
      </c:if>
      <c:if test="${car_type_selected==null}">
         <option style="color: #000000;" value=>- 차종 -</option>
      </c:if>
      <c:forEach items="${car_types}" var="car_type_option">
      <c:if test="${car_type_selected ne car_type_option.car_type}">
         <option value="${car_type_option.car_type}">${car_type_option.car_type}</option>
      </c:if>
      </c:forEach>
   </select>

<input type="submit" value="선택 조회" style="width:100px; height:45px; margin: 0px 0px 0px 3px; font-size:20px; border:none; border-radius: 6px; background-color: #008000; color: #FFFFFF"/>
</form>
</div>

<div style="float:left; height:45px; font-size:20px; margin:10% 0% 0% 0%;">
   <form action="list" method="post">
      <input type="hidden" value="" name="maker">
      <input type="hidden" value="" name="car_size">
      <input type="hidden" value="" name="car_type">
      <button type="submit" style="font-size:22px; width:45px; height:45px; background-color: #F15F5F; border:none; border-radius:6px; padding:3px 0px 0px 0px">
         <i class="fa-solid fa-rotate-right"></i>
      </button>
   </form>
</div>
<c:if test="${loginUser.userid=='admin'}">
<div style="float:left; height:45px; font-size:20px; margin:10% 0% 0% 0.4%;">
   <button onclick="window.location.href='insert'" style="font-size:22px; height:45px; background-color: #F15F5F; border:none; border-radius:6px; padding:3px 0px 0px 0px">
   		&nbsp;차량추가&nbsp;</button>
</div>
</c:if>


<c:set var="loop_index" value="1" />

<div id="car_list_container" style="float:left; margin:0% 0% 0% 14%;">
<input type="hidden" id="car_list_userid" value="${loginUser.userid}">
<input type="hidden" id="car_list_carno" value="${dbUser.carno}">
   
<c:set var="loop_flag" value="false"/>

   <div id="car_list_out_container" style="float:left; width:40%; margin: 0% 0% 0% 0%;">
   <div id="car_list_in_leftside"  style="float:left; width:746.48px; cursor:pointer; border: 0px solid #747474; border-radius:6px; margin: 0% 0% 10% 10%;"></div>
         <c:forEach items="${carList1}" var="item">
         <div id="car_list_in_container${item.no}" onload="test(${item.no})" onmouseover="zoom('${item.no}')"style="float:left; width:90%; cursor:pointer; border: 0px solid #747474; border-radius:6px; margin: 0% 0% 10% 10%; box-shadow: -2px 2px 5px 2px #747474;">
            <div id="car_list_title_box" >
               
            <c:if test="${loginUser.userid != 'admin'}">
               <div id="car_list_mycar_add_box" onclick="mycar('${item.no}','${loginUser.userid}')" style="text-align:right; float:left; width:100%; font-size:20px; margin:0% 0% 1% 0%; padding-right:2%;">
                  <span id ="car_list_mycar_add${item.no}">내 차량 추가 <i class="fa-regular fa-square-plus"></i></span>
                  <span id ="car_list_mycar${item.no}" style="color: #F15F5F;">내 차량 <i class="fa-solid fa-car"></i></span>
               </div>
            </c:if>
            <c:if test="${loginUser.userid == 'admin'}">
               <div id="car_list_mycar_update_box" style="text-align:right; float:left; width:100%; font-size:20px; margin:0% 0% 1% 0%; padding-right:2%;">
                  <form action="updateForm">
                     <input type="hidden" value="${item.no}" name="carno">
                     <button style="border: none; background-color: white;"><span class="fa-regular fa-pen-to-square" id="show_update${item.no}"></span></button>
                  </form>
               </div>
            </c:if>
               
               <c:if test="${item.imgcnt == 4}">
                  <div id="car_list_left_btn" onclick="imgLeft('${item.no}')" style=" float:left; width:6%; height:247px;; padding: 16.5% 0% 0% 2%;">
                     <span class="fa-solid fa-chevron-left" style="font-size:35px;"></span>
                  </div>
                  <img src="../img/${item.img.substring(0, item.img.length() - 5)}${Math.round(Math.random() * 3) + 1}.png" id="car_list_title${item.no}" onclick="show('${item.no}')" style=" width:85%; transition-duration: 0.5s; margin:0% 0% 0% 1.5%;">
                  <div id="car_list_right_btn" onclick="imgRight('${item.no}')" style=" float:right; width:6%; height:247px; padding: 16.5% 0% 0% 0%;">
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
            <div id="car_list_maker_name" onclick="show('${item.no}')" style="float:left; width:50%; font-size:30px; margin: 0% 0% 0% 9%;">
               ${item.maker}&nbsp;&nbsp;${item.name}
            </div>
            
            <div id ="car_list_like_box" onclick="like('${item.no}','${loginUser.userid}')" style="float:left; font-size:30px;">
         <c:if test="${loginUser.userid != null }">
               <c:forEach items="${liked_Car}" var="liked_Car2">
               <c:if test="${loop_flag == false}">   <!-- 기본 flag값=false일때 forEach돈다 -->
                     <c:if test="${item.no == liked_Car2.carno}">   <!-- 현재 카개게츠이 번호와 과 지금 도는 liked의 차 번호가 같으면  -->
                           <span id="car_list_like_no${item.no}" class="fa-solid fa-heart" style="color: #F15F5F;"></span>
                           <c:set var="loop_flag" value="true" />   <!-- 빨간하트 출력 시 flag값 true로 줘서 forEach 종료 -->
                     </c:if>
                     
                     <c:if test="${liked_Car2 == liked_Car.get(liked_Car.size()-1) && item.no != liked_Car2.carno}">
                        <span id="car_list_like_no${item.no}" class="fa-regular fa-heart"></span>
                     </c:if>
               </c:if>
               
               </c:forEach>
           </c:if>
           <c:if test="${empty liked_Car || loginUser.userid == null}">
                 <span id="car_list_like_no${item.no}" class="fa-regular fa-heart"></span>
           </c:if>
            </div>
            
            <div id="car_list_like_total_box" style="float:left; font-size:30px; margin-left:2%;">
            <c:set var="loop_flag2" value="false" />
               <c:forEach items="${liked_Total}" var="liked_Total2">
                  <c:if test="${loop_flag2 == false}">
                     <c:if test="${item.no == liked_Total2.carno}">
                        <span id ="car_list_like_total${item.no}">${liked_Total2.cnt}</span>
                        <c:set var="loop_flag2" value="true" />
                     </c:if>
                     <c:if test="${item.no != liked_Total2.carno && liked_Total2== liked_Total.get(liked_Total.size()-1)}">
                        <span id ="car_list_like_total${item.no}">0</span>
                     </c:if>
                  </c:if>
               </c:forEach>
            </div>
            
            <div id ="car_list_description" onclick="show('${item.no}')" style="width:100%; height:230px;">
               <div id="car_list_size_type" style="float:left; width:50%; font-size:20px; margin: 0.5% 0% 2% 15%; color:#747474">
                  ${item.car_size}&nbsp;&nbsp;${item.car_type}
               </div>
               
               <div id="car_list_output_sub" style="float:left; font-size:15px; height:45px; padding: 1% 0% 0% 0%;  color:#747474">
                  <c:if test="${item.min_price != 0 && item.max_price != 0}">
                     가격 : <fmt:formatNumber value="${item.min_price}"/> ~ <fmt:formatNumber value="${item.max_price}"/>만원
                  </c:if>
                  <c:if test="${item.min_price != 0 && item.max_price == 0}">
                     가격 : <fmt:formatNumber value="${item.min_price}"/>만원
                  </c:if>
                  <c:if test="${item.min_price == 0 && item.max_price == 0}">
                     가격 : 미제공
                  </c:if>
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
               <div id="car_list_output_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 0% 0%;  color:#747474">
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
            
               <div id="car_list_length" style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  전장 : <fmt:formatNumber value="${item.overall_length}"/>mm
               </div>
            
               <div id="car_list_height" style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  전고 : <fmt:formatNumber value="${item.overall_height}"/>mm
               </div>
            
               <div id="car_list_width" style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  전폭 : <fmt:formatNumber value="${item.overall_width}"/>mm
               </div>
            
               <div id="car_list_whellbase" style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  축거 : <fmt:formatNumber value="${item.wheelbase}"/>mm
               </div>
               </div>
            </div>
         </div> <%-- main --%>
   <c:set var="loop_index" value="${loop_index+1}" /> 
   <c:set var="loop_flag" value="false" /> 
   </c:forEach>
   </div>
   <%-- center --%>
   <%-- center --%>
   <%-- center --%>
   <div id="car_list_out_container" style="float:left; width:40%; margin: 0% 0% 0% 0%;">
   <div id="car_list_in_rightside" style="float:left; width:746.48px; cursor:pointer; border: 0px solid #747474; border-radius:6px; margin: 0% 0% 10% 10%;"></div>
      <c:forEach items="${carList2}" var="item">
         <div id="car_list_in_container${item.no}" onload="test(${item.no})" onmouseover="zoom('${item.no}')"style="float:left; width:90%; cursor:pointer; border: 0px solid #747474; border-radius:6px; margin: 0% 0% 10% 10%; box-shadow: -2px 2px 5px 2px #747474;">
            <div id="car_list_title_box" >
               
               <c:if test="${loginUser.userid != 'admin'}">
               <div id="car_list_mycar_add_box" onclick="mycar('${item.no}','${loginUser.userid}')" style="text-align:right; float:left; width:100%; font-size:20px; margin:0% 0% 1% 0%; padding-right:2%;">
                  <span id ="car_list_mycar_add${item.no}">내 차량 추가 <i class="fa-regular fa-square-plus"></i></span>
                  <span id ="car_list_mycar${item.no}" style="color: #F15F5F;">내 차량 <i class="fa-solid fa-car"></i></span>
               </div>
            </c:if>
            <c:if test="${loginUser.userid == 'admin'}">
               <div id="car_list_mycar_update_box" style="text-align:right; float:left; width:100%; font-size:20px; margin:0% 0% 1% 0%; padding-right:2%;">
                  <form action="updateForm">
                     <input type="hidden" value="${item.no}" name="carno">
                     <button style="border: none; background-color: white;"><span class="fa-regular fa-pen-to-square" id="show_update${item.no}"></span></button>
                  </form>
               </div>
            </c:if>
               
               <c:if test="${item.imgcnt == 4}">
                  <div id="car_list_left_btn" onclick="imgLeft('${item.no}')" style=" float:left; width:6%; height:247px;; padding: 16.5% 0% 0% 2%;">
                     <span class="fa-solid fa-chevron-left" style="font-size:35px;"></span>
                  </div>
                  <img src="../img/${item.img.substring(0, item.img.length() - 5)}${Math.round(Math.random() * 3) + 1}.png" id="car_list_title${item.no}" onclick="show('${item.no}')" style=" width:85%; transition-duration: 0.5s; margin:0% 0% 0% 1.5%;">
                  <div id="car_list_right_btn" onclick="imgRight('${item.no}')" style=" float:right; width:6%; height:247px; padding: 16.5% 0% 0% 0%;">
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
            <div id="car_list_maker_name" onclick="show('${item.no}')" style="float:left; width:50%; font-size:30px; margin: 0% 0% 0% 9%;">
               ${item.maker}&nbsp;&nbsp;${item.name}
            </div>
            <div id ="car_list_like_box" onclick="like('${item.no}','${loginUser.userid}')" style="float:left; font-size:30px;">

         <c:if test="${loginUser.userid != null }">
               <c:set var="loop_flag" value="false" />
               <c:forEach items="${liked_Car}" var="liked_Car2">
               <c:if test="${loop_flag == false}">
                     <c:if test="${item.no == liked_Car2.carno}"><!-- 차객체들과 지금 도는 like차 번호가 같으면  -->
                           <span id="car_list_like_no${item.no}" class="fa-solid fa-heart" style="color: #F15F5F;"></span>
                           <c:set var="loop_flag" value="true" />
                     </c:if>
                     
                     <c:if test="${liked_Car2 == liked_Car.get(liked_Car.size()-1) && item.no != liked_Car2.carno}">
                        <span id="car_list_like_no${item.no}" class="fa-regular fa-heart"></span>
                     </c:if>
               </c:if>
               </c:forEach>
           </c:if>
           <c:if test="${empty liked_Car || loginUser.userid == null}">
                 <span id="car_list_like_no${item.no}" class="fa-regular fa-heart"></span>
           </c:if>
           
               
               
            </div>
            
            <div id="car_list_like_total_box" style="float:left; font-size:30px; margin-left:2%;">
            <c:set var="loop_flag2" value="false" />
               <c:forEach items="${liked_Total}" var="liked_Total2">
                  <c:if test="${loop_flag2 == false}">
                     <c:if test="${item.no == liked_Total2.carno}">
                        <span id ="car_list_like_total${item.no}">${liked_Total2.cnt}</span>
                        <c:set var="loop_flag2" value="true" />
                     </c:if>
                     <c:if test="${item.no != liked_Total2.carno && liked_Total2== liked_Total.get(liked_Total.size()-1)}">
                        <span id ="car_list_like_total${item.no}">0</span>
                     </c:if>
                  </c:if>
               </c:forEach>
            </div>
            
            <div id ="car_list_description" onclick="show('${item.no}')" style="width:100%; height:230px;">
               <div id="car_list_size_type" style="float:left; width:50%; font-size:20px; margin: 0.5% 0% 2% 15%; color:#747474">
                  ${item.car_size}&nbsp;&nbsp;${item.car_type}
               </div>
               
               <div id="car_list_output_sub" style="float:left; font-size:15px; height:45px; padding: 1% 0% 0% 0%;  color:#747474">
                  <c:if test="${item.min_price != 0 && item.max_price != 0}">
                     가격 : <fmt:formatNumber value="${item.min_price}"/> ~ <fmt:formatNumber value="${item.max_price}"/>만원
                  </c:if>
                  <c:if test="${item.min_price != 0 && item.max_price == 0}">
                     가격 : <fmt:formatNumber value="${item.min_price}"/>만원
                  </c:if>
                  <c:if test="${item.min_price == 0 && item.max_price == 0}">
                     가격 : 미제공
                  </c:if>
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
               <div id="car_list_output_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 0% 0%;  color:#747474">
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
            
               <div id="car_list_length" style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  전장 : <fmt:formatNumber value="${item.overall_length}"/>mm
               </div>
            
               <div id="car_list_height" style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  전고 : <fmt:formatNumber value="${item.overall_height}"/>mm
               </div>
            
               <div id="car_list_width" style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  전폭 : <fmt:formatNumber value="${item.overall_width}"/>mm
               </div>
            
               <div id="car_list_whellbase" style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  축거 : <fmt:formatNumber value="${item.wheelbase}"/>mm
               </div>
               </div>
            </div>
         </div> <%-- main --%>
   <c:set var="loop_index" value="${loop_index+1}" /> 
   <c:set var="loop_flag" value="false" /> 
   </c:forEach>
   </div>
</div>


<script>
/*  
function colorReset(kind) {
   if (kind == "maker") {
      $("#maker").css("color","#000000")
   } else if (kind == "car_size") {
      $("#car_size").css("color","#000000")
   } else if (kind == "car_type") {
      $("#car_type").css("color","#000000")
   }
}

$("select[name=maker]").change(function(){
   $("#maker").css("color","#F15F5F")
   
   if ($("#maker").val() == '') {
      colorReset("maker");
   }
});

$("select[name=car_size]").change(function(){
   $("#car_size").css("color","#F15F5F")
   
   if ($("#car_size").val() == '') {
      colorReset("car_size");
   }
});

$("select[name=car_type]").change(function(){
   $("#car_type").css("color","#F15F5F")
   
   if ($("#car_type").val() == '') {
      colorReset("car_type");
   }
});
*/
window.onload = function() {
   mycardec();
   $(".mySlideDiv").not(".active").hide();
   setInterval(nextSlide, 4000);
   $("#imgDot_0").css("background-color", "#747474");
}

function mycardec(){
   carno_max = Number('${maxnum}');
   carno = document.getElementById("mycar").value;
   console.log("초기 mycar : "+carno)
   console.log(carno_max+"carno_max")
   for (var i = 0; i <= 45; i++) {
      $("#car_list_mycar"+i).hide()
        $("#car_list_mycar_add"+i).show()
        $("#car_list_in_container"+i).css("box-shadow","-2px 2px 5px 2px #747474")
   }
   $("#car_list_mycar"+carno).show()
   $("#car_list_mycar_add"+carno).hide()
   $("#car_list_in_container"+carno).css("box-shadow","-2px 2px 5px 2px #F15F5F")
     //$("#car_list_in_container"+carno).css("opacity", 0);
}

function prevSlide() {
      $(".mySlideDiv").hide(); //모든 div 숨김
      var allSlide = $(".mySlideDiv"); //모든 div 객체를 변수에 저장
      var currentIndex = 0; //현재 나타난 슬라이드의 인덱스 변수
      
      //반복문으로 현재 active클래스를 가진 div를 찾아 index 저장
      $(".mySlideDiv").each(function(index,item){ 
         if($(this).hasClass("active")) {
            currentIndex = index;
         }
           
      });
      
      //새롭게 나타낼 div의 index
      var newIndex = 0;
       
      if(currentIndex <= 0) {
         //현재 슬라이드의 index가 0인 경우 마지막 슬라이드로 보냄(무한반복)
         newIndex = allSlide.length-1;
      } else {
         //현재 슬라이드의 index에서 한 칸 만큼 뒤로 간 index 지정
         newIndex = currentIndex-1;
      }

      //모든 div에서 active 클래스 제거
      $(".mySlideDiv").removeClass("active");
       
      //새롭게 지정한 index번째 슬라이드에 active 클래스 부여 후 show()
      $(".mySlideDiv").eq(newIndex).addClass("active");
      $(".mySlideDiv").eq(newIndex).show();
      $("#imgDot_" + newIndex).css("background-color", "#747474");

      for (let i = 0; i < 5; i++) {
        if (i != newIndex) {
          $("#imgDot_" + i).css("background-color", "#E0E0E0");
        }
      }

   }

   //다음 슬라이드
   function nextSlide() {
      $(".mySlideDiv").hide();
      var allSlide = $(".mySlideDiv");
      var currentIndex = 0;
      
      $(".mySlideDiv").each(function(index,item){
         if($(this).hasClass("active")) {
            currentIndex = index;
         }
           
      });
      
      
      var newIndex = 0;
      
      if(currentIndex >= allSlide.length-1) {
         //현재 슬라이드 index가 마지막 순서면 0번째로 보냄(무한반복)
         newIndex = 0;
      } else {
         //현재 슬라이드의 index에서 한 칸 만큼 앞으로 간 index 지정
         newIndex = currentIndex+1;
      }

      $(".mySlideDiv").removeClass("active");
      $(".mySlideDiv").eq(newIndex).addClass("active");
      $(".mySlideDiv").eq(newIndex).show();
      $("#imgDot_" + newIndex).css("background-color", "#747474");

      for (let i = 0; i < 5; i++) {
        if (i != newIndex) {
          $("#imgDot_" + i).css("background-color", "#E0E0E0");
        }
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


$(document).ready(function(){
   var userid = $("#car_list_userid").val() // userid
   var carno = $("#car_list_carno").val() // userid
   console.log(carno)
   carno_max = Number('${maxnum}'); // 45
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
                  //$("#car_list_like_ok"+carno).hide();
                  //$("#car_list_like_no"+carno).show();
                  
               } else if (result == false){
                 // $("#car_list_like_ok"+carno).show();
                 // $("#car_list_like_no"+carno).hide();
               }
            console.log("document.getElementById(car_list_like_no+carno) : "+document.getElementById("car_list_like_no"+carno))            
               var class_status = document.getElementById("car_list_like_no"+carno).className
               console.log("객체의 total : "+document.getElementById("car_list_like_total"+carno).innerHTML)
               var now_like_cnt = document.getElementById("car_list_like_total"+carno).innerHTML;
               if(class_status == "fa-solid fa-heart"){
                  document.getElementById("car_list_like_no"+carno).className = "fa-regular fa-heart";
                  document.getElementById("car_list_like_no"+carno).style.color = "black";
                  document.getElementById("car_list_like_total"+carno).innerHTML =Number(now_like_cnt)-1;
               }else{
                  document.getElementById("car_list_like_no"+carno).className = "fa-solid fa-heart";
                  document.getElementById("car_list_like_no"+carno).style.color = "#F15F5F";
                  document.getElementById("car_list_like_total"+carno).innerHTML = Number(now_like_cnt)+1;
               }
               //liketotal(carno)
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
   /*
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
                  console.log(carno+'//'+result)
                  
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
   */
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
               for (var i = 0; i <= carno_max; i++) {
                  $("#car_list_mycar"+i).hide()
                  $("#car_list_mycar_add"+i).show()
                  $("#car_list_in_container"+i).css("box-shadow","-2px 2px 5px 2px #747474")
                  
               }
               $("#car_list_mycar"+carno).show()
               $("#car_list_mycar_add"+carno).hide()
               $("#car_list_in_container"+carno).css("box-shadow","-2px 2px 5px 2px #F15F5F")
               $("#car_list_in_container"+carno).css("opacity", 0);
               $("#car_list_in_container"+carno).animate({
                  opacity: 1
               }, 500);
            }
         });
      }
   }
   </script>   
      
         
      
   </body>
   </html>