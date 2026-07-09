<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<%
Integer orderId=(Integer)request.getAttribute("orderId");

if(orderId==null){

orderId=0;

}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Order Success</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<style>

*{

font-family:'Poppins',sans-serif;

}

body{

background:linear-gradient(135deg,#eef2ff,#ffffff);

display:flex;

justify-content:center;

align-items:center;

height:100vh;

}

/* Card */

.success-card{

width:700px;

background:white;

padding:50px;

border-radius:25px;

text-align:center;

box-shadow:0 15px 40px rgba(0,0,0,.12);

animation:popup .6s ease;

}

/* Success Icon */
.btn-danger{

padding:12px 30px;

border-radius:12px;

font-weight:600;

text-decoration:none;

}

.btn-danger:hover{

transform:translateY(-2px);

}
.icon{

width:120px;

height:120px;

margin:auto;

border-radius:50%;

background:#22c55e;

display:flex;

justify-content:center;

align-items:center;

font-size:60px;

color:white;

margin-bottom:25px;

animation:bounce 1.2s infinite;

}

h1{

font-weight:700;

color:#1e293b;

margin-bottom:15px;

}

p{

color:#64748b;

font-size:18px;

}

.info{

margin-top:35px;

background:#f8fafc;

padding:20px;

border-radius:15px;

text-align:left;

}

.info h5{

margin:12px 0;

}

.buttons{

margin-top:40px;

display:flex;

justify-content:center;

gap:20px;

}

.btn-home{

background:#4F46E5;

color:white;

padding:12px 30px;

border-radius:12px;

text-decoration:none;

font-weight:600;

}

.btn-home:hover{

background:#4338ca;

color:white;

}

.btn-orders{

background:#10b981;

color:white;

padding:12px 30px;

border-radius:12px;

text-decoration:none;

font-weight:600;

}

.btn-orders:hover{

background:#059669;

color:white;

}

@keyframes popup{

0%{

transform:scale(.5);

opacity:0;

}

100%{

transform:scale(1);

opacity:1;

}

}

@keyframes bounce{

0%{

transform:scale(1);

}

50%{

transform:scale(1.08);

}

100%{

transform:scale(1);

}

}

</style>

</head>

<body>

<div class="success-card">

<div class="icon">

<i class="bi bi-check-lg"></i>

</div>

<h1>

Order Placed Successfully!

</h1>

<p>

Thank you for choosing FoodVerse.

Your delicious meal is being prepared.

</p>

<div class="info">

<h5>

<b>Order ID :</b>

#<%=orderId%>

</h5>

<h5>

<b>Payment Status :</b>

<span class="text-success">

Paid Successfully

</span>

</h5>

<h5>

<b>Estimated Delivery :</b>

25 - 35 Minutes

</h5>

<h5>

<b>Status :</b>

Preparing Your Order

</h5>

</div>

<div class="buttons">

<a href="home"
class="btn-home">

<i class="bi bi-house-fill"></i>

Continue Shopping

</a>

<a href="myOrders"
class="btn-orders">

<i class="bi bi-bag-check-fill"></i>

My Orders

</a>

<a href="downloadInvoice?orderId=<%=orderId%>"
class="btn btn-danger">

<i class="bi bi-file-earmark-pdf-fill"></i>

Download Invoice

</a>

</div>
</div>

</body>

</html>