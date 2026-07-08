<%@page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="com.food_application.model.Order"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
List<Order> orders = (List<Order>)request.getAttribute("orders");
SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy  hh:mm a");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>My Orders | FoodVerse</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}

body{

background:#f1f5f9;

}

/* Navbar */

.navbar{

background:white;

box-shadow:0 2px 12px rgba(0,0,0,.08);

padding:15px 0;

}

.navbar-brand{

font-size:28px;

font-weight:700;

color:#4F46E5!important;

}

/* Heading */

.heading{

padding:40px 0 20px;

text-align:center;

}

.heading h2{

font-weight:700;

color:#1e293b;

}

/* Order Card */

.order-card{

background:white;

border-radius:20px;

padding:25px;

margin-bottom:25px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

transition:.3s;

}

.order-card:hover{

transform:translateY(-5px);

}

.order-id{

font-size:24px;

font-weight:700;

color:#4F46E5;

}

.status{

padding:6px 16px;

border-radius:20px;

font-size:14px;

font-weight:600;

display:inline-block;

}

.pending{

background:#fff3cd;

color:#856404;

}

.preparing{

background:#dbeafe;

color:#1d4ed8;

}

.delivered{

background:#dcfce7;

color:#166534;

}

.cancelled{

background:#fee2e2;

color:#991b1b;

}

.amount{

font-size:26px;

font-weight:bold;

color:#16a34a;

}

.details-btn{

background:#4F46E5;

color:white;

border:none;

padding:10px 22px;

border-radius:10px;

}

.details-btn:hover{

background:#4338ca;

}

.empty{

text-align:center;

padding:80px;

}

footer{

margin-top:60px;

background:#1E293B;

color:white;

text-align:center;

padding:30px;

}

</style>

</head>

<body>

<nav class="navbar navbar-expand-lg">

<div class="container">

<a class="navbar-brand" href="home">

FoodVerse

</a>

<div>

<a href="home" class="btn btn-outline-primary">

<i class="bi bi-house"></i>

Home

</a>

</div>

</div>

</nav>

<div class="container">

<div class="heading">

<h2>

<i class="bi bi-bag-check-fill"></i>

My Orders

</h2>

</div>

<%

if(orders==null || orders.isEmpty()){

%>

<div class="empty">

<i class="bi bi-bag-x"

style="font-size:90px;color:#94a3b8;"></i>

<h3 class="mt-4">

No Orders Found

</h3>

<p class="text-muted">

Looks like you haven't placed any orders yet.

</p>

<a href="home" class="btn btn-primary mt-3">

Start Ordering

</a>

</div>

<%

}else{

for(Order order:orders){

String status=order.getStatus();

String css="pending";

if(status!=null){

if(status.equalsIgnoreCase("PREPARING"))

css="preparing";

else if(status.equalsIgnoreCase("DELIVERED"))

css="delivered";

else if(status.equalsIgnoreCase("CANCELLED"))

css="cancelled";

}

%>

<div class="order-card">

<div class="row align-items-center">

<div class="col-md-8">

<div class="order-id">

Order #<%=order.getOrderId()%>

</div>

<br>

<p>

<i class="bi bi-calendar-event"></i>

<%=sdf.format(order.getOrderDate())%>

</p>

<p>

<i class="bi bi-geo-alt-fill"></i>

<%=order.getDeliveryAddress()%>

</p>

<span class="status <%=css%>">

<%=order.getStatus()%>

</span>

</div>

<div class="col-md-4 text-end">

<div class="amount">

&#8377;

<%=String.format("%.2f",
order.getTotalAmount())%>

</div>

<br>

<a href="orderDetails?orderId=<%=order.getOrderId()%>">

<button class="details-btn">

<i class="bi bi-eye-fill"></i>

View Details

</button>

</a>

</div>

</div>

</div>

<%

}

}

%>

</div>

<footer>

<h4>

FoodVerse

</h4>

<p>

Fresh Food • Better Taste • Faster Delivery

</p>

</footer>

</body>

</html>