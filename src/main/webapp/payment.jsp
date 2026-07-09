<%@ page language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>

<%
String key=(String)request.getAttribute("key");

String orderId=(String)request.getAttribute("razorpayOrderId");

Double amount=(Double)request.getAttribute("amount");

String customerName=(String)request.getAttribute("customerName");

String customerEmail=(String)request.getAttribute("customerEmail");

String customerPhone=(String)request.getAttribute("customerPhone");

if(key==null||orderId==null||amount==null){

response.sendRedirect("checkout.jsp");

return;

}

int razorpayAmount=(int)(amount*100);
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>FoodVerse Payment</title>

<meta name="viewport"
content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<style>

body{

background:#f4f7fc;

display:flex;

justify-content:center;

align-items:center;

height:100vh;

font-family:Poppins,sans-serif;

}

.payment-card{

width:500px;

background:white;

padding:40px;

border-radius:20px;

box-shadow:0 10px 30px rgba(0,0,0,.15);

text-align:center;

}

.logo{

font-size:34px;

font-weight:bold;

color:#4F46E5;

margin-bottom:15px;

}

.amount{

font-size:42px;

font-weight:bold;

color:#16A34A;

margin:20px 0;

}

.btn-pay{

width:100%;

padding:15px;

font-size:18px;

font-weight:bold;

border-radius:12px;

}

</style>

</head>

<body>

<div class="payment-card">

<div class="logo">

🍽 FoodVerse

</div>

<h3>

Complete Payment

</h3>

<p class="text-muted">

Powered by Razorpay

</p>

<div class="amount">

₹ <%=String.format("%.2f",amount)%>

</div>

<button

class="btn btn-success btn-pay"

onclick="payNow()">

<i class="bi bi-credit-card-fill"></i>

Pay Now

</button>

</div>

<script>

function payNow(){

var options={

key:"<%=key%>",

amount:"<%=razorpayAmount%>",

currency:"INR",

name:"FoodVerse",

description:"Food Order Payment",

order_id:"<%=orderId%>",

prefill:{

name:"<%=customerName%>",

email:"<%=customerEmail%>",

contact:"<%=customerPhone%>"

},

theme:{

color:"#4F46E5"

},

handler:function(response){

window.location.href=

"verifyPayment?"

+

"razorpay_payment_id="

+

response.razorpay_payment_id

+

"&razorpay_order_id="

+

response.razorpay_order_id

+

"&razorpay_signature="

+

response.razorpay_signature;

}

};

var rzp=new Razorpay(options);

rzp.on("payment.failed",function(){

alert("Payment Failed");

});

rzp.open();

}

</script>

</body>

</html>