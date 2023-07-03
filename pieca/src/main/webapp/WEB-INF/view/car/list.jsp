<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<style>
#car_list_in_container:hover {
   transform: scale(1.05);
   transition-duration: 0.8s;
}

#car_list_in_container:not(:hover) {
  transform: scale(1);
  transition-duration: 0.8s;
}



</style>
</head>
<body>
   <div id="car_list_out_container" style="width:80%; background-color: yellow; margin: 10% 0px 0px 6%;">
      <c:forEach items="${carList}" var="item">
         <div id="car_list_in_container" style="float:left; width:39%; border: 0px solid #747474; border-radius:6px; margin: 0% 0% 10% 10%; box-shadow: rgba(17, 17, 26, 0.1) 0px 8px 24px, rgba(17, 17, 26, 0.1) 0px 16px 56px, rgba(17, 17, 26, 0.1) 0px 24px 80px;">
            <div id="car_list_title_box">
               <img src="../img/${item.img}" id="car_list_title" style="width:100%;">
            </div>
            <div id="car_list_maker_name" style="width:70%; font-size:30px; margin: 0% 0% 0% 15%;">
               ${item.maker}&nbsp;&nbsp;${item.name}
            </div>
            <div id="car_list_size_type" style="font-size:20px; margin: 0% 0% 0% 15%; color:#747474">
               ${item.car_size}&nbsp;&nbsp;${item.car_type}
            </div><br>
            
            <div id="car_list_capacity_main" style="float:left; width:50%; height:45px; font-size:18px; margin: 0% 0% 0% 15%">
               <c:if test="${item.max_capacity != 0}">
                  용량 : ${item.min_capacity} ~ ${item.max_capacity}kWh
               </c:if>
               <c:if test="${item.max_capacity == 0}">
                  용량 : ${item.min_capacity}kWh
               </c:if>
            </div>
            <div id="car_list_capacity_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 0% 0%;  color:#747474">
               배터리
            </div>
            
            <div id="car_list_range_main" style="float:left; width:50%; height:45px; font-size:18px; margin: 0% 0% 0% 15%">
               주행거리 : ${item.min_range} ~ ${item.max_range}km
            </div>
            <div id="car_list_range_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 0% 0%;  color:#747474">
               1회 충전시
            </div>
            
            <div id="car_list_fuel_main" style="float:left; width:50%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
               연비 : ${item.avg_min_fuel / 10} ~ ${item.avg_max_fuel / 10}km/kWh
            </div>
            <div id="car_list_fuel_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 3% 0%;  color:#747474">
               <p>도심 ${item.dt_min_fuel / 10} ~ ${item.dt_max_fuel / 10}</p>
               <p>고속 ${item.high_min_fuel / 10} ~ ${item.high_max_fuel / 10}</p>
            </div>
            
            <div id="car_list_etc">
               <div id="car_list_output_main" style="float:left; width:50%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  출력 : ${item.min_output} ~ ${item.max_output}kW
               </div>
               <div id="car_list_fuel_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 0% 0%;  color:#747474">
                  <p>모터 ${item.min_output_motor} ~ ${item.max_output_motor}hp</p>
               </div>
               
               <div id="car_list_torque_main" style="float:left; width:50%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  토크 : ${item.min_torque} ~ ${item.max_torque}Nm
               </div>
               <div id="car_list_torque_sub" style="float:left; font-size:15px; height:45px; margin: 0% 0% 0% 0%;  color:#747474">
                  <p>모터 ${item.min_torque_motor} ~ ${item.max_torque_motor}kg.m</p>
               </div>
            
               <div style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  전장 : ${item.overall_length}mm
               </div>
            
               <div style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  전고 : ${item.overall_height}mm
               </div>
            
               <div style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  전폭 : ${item.overall_width}mm
               </div>
            
               <div style="float:left; width:35%; height: 45px; font-size:18px; margin: 0% 0% 0% 15%">
                  축거 : ${item.wheelbase}mm
               </div>
            </div>
         </div> <%-- main --%>
      </c:forEach>
   </div>
<script>

</script>   
   
      
   
</body>
</html>