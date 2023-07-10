<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>차량 정보 수정</title>
</head>
<body>
<div style="width:70%; background-color:yellow; margin:5% 0% 0% 7%; align-content: center; justify-content: center; align-items: center;">
<form:form modelAttribute="car" action="updateForm" method="post">
<form:hidden path="no" />
<form:errors path="no" />
	<div id="car_list_container" style="float:left; margin:5% 0% 0% 14%;">
		<div id="car_list_in_container${car.no}" onload="test(${car.no})" onmouseover="zoom('${car.no}')"style="float:left; width:90%; cursor:pointer; border: 0px solid #747474; border-radius:6px; margin: 0% 0% 10% 10%; box-shadow: -2px 2px 5px 2px #747474;">
            <div id="car_list_title_box" >
               
               <div id="car_list_mycar_add_box"  style="text-align:right; float:left; width:100%; font-size:20px; margin:0% 0% 1% 0%; padding-right:2%;">
                  <button style="border: none; background-color: white;">[수정]</button>
               </div>
               
               <c:if test="${car.imgcnt == 4}">
                  <div id="car_list_left_btn"  style=" float:left; width:6%; height:247px;; padding: 16.5% 0% 0% 2%;">
                     <span class="fa-solid fa-chevron-left" style="font-size:35px;"></span>
                  </div>
                  <img src="../img/${car.img.substring(0, car.img.length() - 5)}${Math.round(Math.random() * 3) + 1}.png" id="car_list_title${car.no}" style=" width:85%; transition-duration: 0.5s; margin:0% 0% 0% 1.5%;">
                  <div id="car_list_right_btn" style=" float:right; width:6%; height:247px; padding: 16.5% 0% 0% 0%;">
                     <span class="fa-solid fa-chevron-right" style="font-size:35px;"></span>
                  </div>
               </c:if>
               <c:if test="${car.imgcnt != 4}">
                  <div id="car_list_left_btn" style="float:left; width:6%; height:187px; padding: 16.5% 0% 0% 1%;">
                  </div>
                  <img src="../img/${car.img}" id="car_list_title${car.no}" style="width:85%; transition-duration: 0.5s; margin:0% 0% 0% 1.5%;">
                  <div id="car_list_right_btn" style="float:right; width:6%; height:187px;padding: 16.5% 0% 0% 0%;">
                  </div>
               </c:if>
            </div>
            <div id="car_list_maker_name"  style="float:left; width:50%; font-size:30px; margin: 0% 0% 0% 9%;">
               <form:input path="maker" style="width:160px;"/>
               <form:errors path="maker" />&nbsp;&nbsp;
               <form:input path="name" style="width:300px;"/>
               <form:errors path="name" />
            </div>
            
            <div id ="car_list_description"  style="width:100%; height:230px;">
               <div id="car_list_size_type" style="float:left; width:50%; font-size:20px; margin: 0.5% 0% 2% 15%; color:#747474">
                  <form:input path="car_size" style="width:110px;"/><form:errors path="car_size" />
                  &nbsp;&nbsp;
                  <form:input path="car_type" style="width:110px;"/>
                  <form:errors path="car_type" />
               </div>
               
               <div id="car_list_output_sub" style="float:left; font-size:15px; height:45px; padding: 1% 0% 0% 0%;  color:#747474">
                     가격 : <form:input path="min_price" style="width:110px;"/> ~ <form:input path="max_price" style="width:110px;"/>만원
               </div>
               <div id="car_list_capacity_main" style="float:left; width:50%; height:45px; font-size:18px; margin: 0% 0% 0% 15%">
                     용량 : <form:input path="min_capacity" style="width:110px;" value="${car.min_capacity}"/> ~ <form:input path="max_capacity" style="width:110px;" value="${car.max_capacity}"/>kWh
               </div>
               <div id="car_list_capacity_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 0% 0%;  color:#747474">
                  배터리
               </div>
               
               <div id="car_list_range_main" style="float:left; width:50%; height:45px; font-size:18px; margin: 0% 0% 0% 15%">
                     주행거리 : <form:input path="min_range" style="width:110px;"/> ~ <form:input path="max_range" style="width:110px;"/>km
               </div>
               <div id="car_list_range_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 0% 0%;  color:#747474">
                  1회 충전시
               </div>
               
               <div id="car_list_fuel_main" style="float:left; width:50%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                     연비 : <form:input path="avg_min_fuel" value="${car.avg_min_fuel}" style="width:110px;"/> ~ <form:input path="avg_max_fuel" value="${car.avg_max_fuel}" style="width:110px;"/>km/kWh
               </div>
               <div id="car_list_fuel_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 3% 0%;  color:#747474">
                     <p>도심 : <form:input path="dt_min_fuel" value="${car.dt_min_fuel} " style="width:110px;"/> ~ <form:input path="dt_max_fuel" value="${car.dt_max_fuel}" style="width:110px;"/>km/kWh</p>
                     <p>고속 : <form:input path="high_min_fuel" value="${car.high_min_fuel}" style="width:110px;"/> ~ <form:input path="high_max_fuel" value="${car.high_max_fuel}" style="width:110px;"/>km/kWh</p>
               </div>
            
            <div id="car_list_etc${car.no}">
               <div id="car_list_output_main" style="float:left; width:50%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                     출력 : <form:input path="min_output" value="${car.min_output}" style="width:110px;"/> ~ <form:input path="max_output" value="${car.max_output}" style="width:110px;"/>kW
               </div>
               <div id="car_list_output_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 0% 0%;  color:#747474">
                     모터 : <form:input path="min_output_motor" value="${car.min_output_motor}" style="width:110px;"/> ~ <form:input path="max_output_motor" value="${car.max_output_motor}" style="width:110px;"/>hp
               </div>
               
               <div id="car_list_torque_main" style="float:left; width:50%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                     토크 : <form:input path="min_torque" value="${car.min_torque}" style="width:110px;"/> ~ <form:input path="max_torque" value="${car.max_torque}" style="width:110px;"/>Nm
               </div>
               <div id="car_list_torque_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 0% 0%;  color:#747474">
                     모터 : <form:input path="min_torque_motor" value="${car.min_torque_motor}" style="width:110px;"/> ~ <form:input path="max_torque_motor" value="${car.max_torque_motor}" style="width:110px;"/>kg.m
               </div>
            
               <div id="car_list_length" style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  전장 : <form:input path="overall_length" value="${car.overall_length}" style="width:110px;"/>mm
               </div>
            
               <div id="car_list_height" style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  전고 : <form:input path="overall_height" value="${car.overall_height}" style="width:110px;"/>mm
               </div>
            
               <div id="car_list_width" style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  전폭 : <form:input path="overall_width" value="${car.overall_width}" style="width:110px;"/>mm
               </div>
            
               <div id="car_list_whellbase" style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  축거 : <form:input path="wheelbase" value="${car.wheelbase}" style="width:110px;"/>mm
               </div>
               </div>
            </div>
         </div> <%-- main --%>
	</div>
</form:form>
</div>	
</body>
</html>