<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PIKA</title>
<style>
#main_list {
	width: 1050px;
	margin: 0 auto; 
	display:flex;
}

#main_list_box {
	width: 350px;
}

#news_list {
	float:left;
	margin:25px 30px 25px 30px; 
	width:300px; 
	height:auto; 
	border:1px solid #FFFFFF; 
	border-radius: 5px; 
	box-shadow: 0px 2px 4px 0px #1B1B1B;
	z-index: -1;
}
    	        	
#news_title {
   	margin:20px 25px 20px 25px; 
   	width:250px; 
   	text-align:left; 
   	font-size:22px;
}
            		
#news_description {
	margin:0px 25px 20px 25px; 
	width:250px; 
	text-align:left; 
	font-size:15px;
}
#news_list:hover {
	transform: scale(1.1);
	transition-duration: 0.8s;
}

#news_list:not(:hover) {
  transform: scale(1);
  transition-duration: 0.8s;
}

#result1, #result2, #result3 {
	display:none;
}
</style>
</head>
<body>
<div id="main_list">
	<div id="main_list_box">
		<div id="result1"></div>
	</div>
	<div id="main_list_box">
		<div id="result2"></div>
	</div>
	<div id="main_list_box">
		<div id="result3"></div>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function () {
	$("#result1").fadeIn(1000);
	$("#result2").fadeIn(1500);
	$("#result3").fadeIn(2000);
  });

$(function(){
	naversearch()
})

function naversearch() {
	 $.ajax({
         type:"POST",
         url:"naversearch",
         data:{},
         success:function(json){
            console.log(json);
            let total=json.total;
            let html1="";
            let html2="";
            let html3="";
            $.each(json.items, function(i,item){
            	if(i%3==0){
					html1 += "<a href='"+item.link+"'><div id='news_list'><div id='news_title'>";
        	    	html1 += "<b>"+item.title+"</b></div><div id='news_description'>";
           			html1 += item.description+"</div></div></a>";
            		$("#result1").html(html1);
            	} else if(i%3==1){
            		html2 += "<a href='"+item.link+"'><div id='news_list'><div id='news_title'>";
        	    	html2 += "<b>"+item.title+"</b></div><div id='news_description'>";
           			html2 += item.description+"</div></div></a>";
            		$("#result2").html(html2);
            	} else if(i%3==2){
            		html3 += "<a href='"+item.link+"'><div id='news_list'><div id='news_title'>";
        	    	html3 += "<b>"+item.title+"</b></div><div id='news_description'>";
           			html3 += item.description+"</div></div></a>";
            		$("#result3").html(html3);;
            	}
            })
         }
      })
   }
</script>  


</body>
</html>