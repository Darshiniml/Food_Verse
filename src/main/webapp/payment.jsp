<<<<<<< HEAD
<%@page language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>
<jsp:include page="admin/includes/chatbot.jsp"/>
<%@page import="org.json.JSONObject"%>

<%
String key = (String) request.getAttribute("key");
String orderJson = (String) request.getAttribute("razorpayOrder");

if(key == null || orderJson == null){
    response.sendRedirect("checkout.jsp");
    return;
}

JSONObject order = new JSONObject(orderJson);

String orderId = order.getString("id");
int amount = order.getInt("amount");
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>FoodVerse Payment</title>

<meta name="viewport"
content="width=device-width, initial-scale=1">

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<style>

body{

background:#F8FAFC;

font-family:Segoe UI;

display:flex;

justify-content:center;

align-items:center;

height:100vh;

}

.card-box{

width:500px;

background:white;

padding:40px;

border-radius:20px;

box-shadow:0 10px 25px rgba(0,0,0,.12);

text-align:center;

}

.logo{

font-size:32px;

font-weight:bold;

color:#FF6B35;

margin-bottom:20px;

}

.amount{

font-size:40px;

font-weight:bold;

color:#198754;

margin:25px 0;

}

.btn-pay{

width:100%;

padding:15px;

font-size:18px;

font-weight:bold;

border-radius:10px;

}

.info{

margin-top:20px;

color:#6C757D;

}

</style>

</head>

<body>

<div class="card-box">

<div class="logo">

🍽 FoodVerse

</div>

<h3>

Complete Your Payment

</h3>

<p class="text-muted">

Secure Payment Powered by Razorpay

</p>

<div class="amount">

₹ <%=amount/100%>

</div>

<button
class="btn btn-success btn-pay"
onclick="payNow()">

<i class="bi bi-credit-card-fill"></i>

Pay Now

</button>

<div class="info">

<i class="bi bi-shield-lock-fill"></i>

100% Secure Payment

</div>

</div>

<script>

function payNow(){

var options={

"key":"<%=key%>",

"amount":"<%=amount%>",

"currency":"INR",

"name":"FoodVerse",

"description":"Food Order Payment",

"image":"https://cdn-icons-png.flaticon.com/512/3075/3075977.png",

"order_id":"<%=orderId%>",

"theme":{

"color":"#FF6B35"

},

"handler":function(response){

window.location.href=

"verifyPayment?"

+

"razorpay_payment_id="

+response.razorpay_payment_id

+

"&razorpay_order_id="

+response.razorpay_order_id

+

"&razorpay_signature="

+response.razorpay_signature;

}

};

var rzp=new Razorpay(options);

rzp.on('payment.failed',function(response){

alert("Payment Failed");

console.log(response.error);

});

rzp.open();

}

</script>

</body>

=======
<!DOCTYPE html>
<html>
<head>
<title>Payment</title>
</head>
<body>

<h1>Payment</h1>

<form action="payment" method="post">

<select name="paymentMethod">

<option>UPI</option>

<option>Credit Card</option>

<option>Debit Card</option>

<option>Cash On Delivery</option>

</select>

<br><br>

<input type="submit"
value="Pay Now">

</form>

</body>
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
</html>