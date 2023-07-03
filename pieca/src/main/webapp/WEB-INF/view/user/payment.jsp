<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PIECA Payment</title>
<link href="../css/pieca.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div id="payment_container">
   <div id="payment_left_inner" style="float:left; width:480px; height:300px;">
      
      <div id="payment_left_title_box" style="width:250px; margin: 10px 0px 10px 10px;">
         <p id="payment_left_title" style="font-size:25px;">PIECA CARD 충전</p>
         <input type="hidden" id="payment_hidden_userid" value="${loginUser.userid}">
      </div>
      
      <div id="payment_left_select_box" style="float: left; width: 200px; margin: 5px 0px 10px 10px; display: inline-block;">
         <select id="payment_left_select" name="amount" onchange="balanceAfter()" style="width: 190px; height: 55px; font-size:18px; border: 2px solid #797979; border-radius: 6px;">
              <option value="0">금액 선택</option>
              <option value="10000">10,000원</option>
              <option value="30000">30,000원</option>
              <option value="50000">50,000원</option>
              <option value="100000">100,000원</option>
         </select>
      </div>
      <%-- 
      <div id="payment_left_input_box" style="float:left; width:250px; margin: 5px 0px 10px 0px;">
           <option value="direct">직접 입력</option>
         <input type="text" id="payment_left_input" name="selboxDirect" oninput="payment_inputChk();" placeholder="금액을 입력 해주세요." style="width: 234px; height: 44px; margin:0px 0px 0px 10px; border-radius:6px; font-size:20px; border: 2px solid #797979; padding-left:10px;"/>
      </div>
      --%>
      <div id="payment_left_balance_box" style="float:left; width:230px; margin: 5px 0px 10px 10px; display: inline-block;">
         <span>충전 전 잔액 : </span><div id="payment_left_balance_now" style="display:inline-block;"></div><br><br>
         <span>충전 후 잔액 : </span><div id="payment_left_balance_after" style="display:inline-block;"></div>
      </div>
      
   </div>

   <div id="payment_right_inner" style=" float:left; width:350px; height:250px; margin: 0px 0px 0px 10px;">
      <div id="payment_right_select_type_box" style=" float:left; width:100px; margin: 10px 0px 10px 0px;">
          <img src="../img/payment_kakao.png" id="payment_right_select_kakao" onclick="kakaopay()" style="width:200px; height: 100px; cursor: pointer;">   
      </div>
      
      <div id="payment_left_input_error_box" style="float:left; width:250px; margin: 5px 0px 10px 10px;">
         <label id="payment_left_input_error" for="payment_left_input"></label>
      </div>
      
      <%-- 
      <div id="payment_left_title_box" style=" float:left; width:100px; margin: 10px 0px 10px 10px;">
         <button onclick="tosspay()" style="width:100px; height:100px;">xxx</button>
      </div>
      --%>
   </div>
   
</div>

<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<script type="text/javascript">
//$("#payment_left_input_box").hide();
function numberWithCommas(balance) {
   return balance.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
   
$(document).ready(function(){
   $.ajax({
         type:"POST",
         url: "../payment/getBalance",
         data : {"userid" : $("#payment_hidden_userid").val()},
         success:function(result){
            console.log(result)
            if (result != '') {
               $("#payment_left_balance_now").text(numberWithCommas(result)+'원');
            } else {
               $("#payment_left_balance_now").text(numberWithCommas(0)+'원');
            }
         }
      });   
});

function balanceAfter() {
   const now = document.querySelector("#payment_left_balance_now");
   const after = document.querySelector("#payment_left_select");
   const nowValue = parseInt(now.textContent.replace(/,/g, ""));
   const afterValue = parseInt(after.value);
   const totalValue = nowValue + afterValue;
   console.log(totalValue);
     $("#payment_left_balance_after").text(numberWithCommas(totalValue)+'원');
   }

function kakaopay() {
   let IMP = window.IMP
   IMP.init("imp65420547")
   $.ajax("../payment/kakao", {
      data: {amount: $("#payment_left_select").val()},
      success : function(json) {
         kakao(json)
      }
   })
}

function kakao(json) {
   IMP.request_pay({
      pg : "kakaopay", // 상점 구문, 카카오페이
      pay_method : "card", // 카드 결제
      merchant_uid : json.merchant_uid, // 주문번호 : 주문별 유일한값이 필요. userid-session id 값
      name : "PIECA CARD 충전", // 상품명
      amount : json.amount, // 주문금액
      //buyer_email : "guardian010@naver.com", // 주문자의 이메일, 테스트용
      buyer_name : json.buyer_name, // 주문자 성명
      buyer_tel : json.buyer_tel, // 주문자 전화번호
      //buyer_addr : json.buyer_addr, // 주문자 주소
      //buyer_postcode : json.buyer_postcode
      // 주문자 우편변호
   }, function(rsp) {
      if (rsp.success) {
         //const orderno = rsp.merchant_uid;
         //const amount = rsp.paid_amount;
         insertkakaopay(rsp.merchant_uid,rsp.paid_amount);
         //msg += "\n:교유ID : "+rsp.imp_uid
         //msg += "\n:상점ID : "+rsp.merchant_uid
         //msg += "\n:결제금액 : "+rsp.paid_amount
         let msg = "결제가 완료 되었습니다."
       msg += "\n:고유ID : " + rsp.imp_uid
       msg += "\n:상점ID : " + rsp.merchant_uid
       msg += "\n:결제금액 : " + rsp.paid_amount
       alert(msg)
         opener.document.location.reload();
         self.close();
      } else {
         alert("결제 실패:" + rsp.error_msg)
      }
   })
}

function tosspay() {
   let IMP = window.IMP
   IMP.init("imp65420547")
   $.ajax("../payment/toss", {
      data: {amount: $("#payment_left_select").val()
         },
      success : function(json) {
         toss(json)
      }
   })
}

function toss(json) {
   IMP.request_pay({
      pg : "tosspay", // 상점 구문, 카카오페이
      pay_method : "card", // 카드 결제
      merchant_uid : json.merchant_uid, // 주문번호 : 주문별 유일한값이 필요. userid-session id 값
      name : "PIECA CARD 충전", // 상품명
      amount : json.amount, // 주문금액
      //buyer_email : "guardian010@naver.com", // 주문자의 이메일, 테스트용
      buyer_name : json.buyer_name, // 주문자 성명
      buyer_tel : json.buyer_tel, // 주문자 전화번호
      //buyer_addr : json.buyer_addr, // 주문자 주소
      //buyer_postcode : json.buyer_postcode
      // 주문자 우편변호
   }, function(rsp) {
      if (rsp.success) {
         //const orderno = rsp.merchant_uid;
         //const amount = rsp.paid_amount;
         insertkakaopay(rsp.merchant_uid,rsp.paid_amount);
         //msg += "\n:교유ID : "+rsp.imp_uid
         //msg += "\n:상점ID : "+rsp.merchant_uid
         //msg += "\n:결제금액 : "+rsp.paid_amount
         let msg = "결제가 완료 되었습니다."
       msg += "\n:고유ID : " + rsp.imp_uid
       msg += "\n:상점ID : " + rsp.merchant_uid
       msg += "\n:결제금액 : " + rsp.paid_amount
       alert(msg)
         self.close();
      } else {
         alert("결제 실패:" + rsp.error_msg)
      }
   })
}


function insertkakaopay(orderno,amount) {
$.ajax({
   type : "POST",
   url : "../payment/insertkakaopay",
   data : {"orderno" : orderno,
         "userid" : $("#payment_hidden_userid").val(),
         "amount" : amount},
   success : function(result) {
      if (result == true) {
      }
   }
});
}
</script>
</body>
</html>