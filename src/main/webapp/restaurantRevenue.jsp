<%@page language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="com.food_application.model.Restaurant"%>
<%@page import="com.food_application.model.Order"%>

<%
Restaurant restaurant =
(Restaurant)request.getAttribute("restaurant");

Integer totalOrders =
(Integer)request.getAttribute("totalOrders");

Integer pendingOrders =
(Integer)request.getAttribute("pendingOrders");

Double totalRevenue =
(Double)request.getAttribute("totalRevenue");

List<Order> completedOrders =
(List<Order>)request.getAttribute("completedOrders");
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Restaurant Revenue</title>

<meta name="viewport"
content="width=device-width, initial-scale=1">

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>

body{

background:#F8FAFC;

font-family:Segoe UI;

}

.sidebar{

position:fixed;

left:0;

top:0;

width:250px;

height:100vh;

background:#1E293B;

padding:25px;

}

.sidebar h3{

color:white;

margin-bottom:40px;

}

.sidebar a{

display:block;

color:white;

padding:12px;

text-decoration:none;

border-radius:10px;

margin-bottom:10px;

}

.sidebar a:hover{

background:#334155;

}

.main{

margin-left:260px;

padding:30px;

}

.card-box{

background:white;

border-radius:15px;

padding:25px;

box-shadow:0 8px 18px rgba(0,0,0,.08);

}

.stat{

font-size:32px;

font-weight:bold;

color:#0F172A;

}

.table td{

vertical-align:middle;

}

</style>

</head>

<body>

<div class="sidebar">

<h3>🍽 FoodVerse</h3>

<a href="restaurantDashboard">

<i class="bi bi-speedometer2"></i>

Dashboard

</a>

<a href="restaurantMenu">

<i class="bi bi-menu-button"></i>

Manage Menu

</a>

<a href="restaurantOrders">

<i class="bi bi-box-seam"></i>

Orders

</a>

<a href="restaurantRevenue">

<i class="bi bi-cash-stack"></i>

Revenue

</a>

<a href="logout">

<i class="bi bi-box-arrow-right"></i>

Logout

</a>

</div>

<div class="main">

<h2>

<%=restaurant.getRestaurantName()%>

Revenue Dashboard

</h2>

<p class="text-muted">

Revenue & Earnings Overview

</p>

<div class="row">

<div class="col-md-4">

<div class="card-box">

<h6>Total Revenue</h6>

<div class="stat">

₹ <%=String.format("%.2f", totalRevenue)%>

</div>

</div>

</div>

<div class="col-md-4">

<div class="card-box">

<h6>Total Orders</h6>

<div class="stat">

<%=totalOrders%>

</div>

</div>

</div>

<div class="col-md-4">

<div class="card-box">

<h6>Pending Orders</h6>

<div class="stat">

<%=pendingOrders%>

</div>

</div>

</div>

</div>

<br>
<div class="card-box">

<h4>

Revenue Details

</h4>

<hr>

<table class="table table-hover align-middle">

<thead>

<tr>

<th>Order ID</th>

<th>Customer</th>

<th>Amount</th>

<th>Status</th>

<th>Date</th>

</tr>

</thead>

<tbody>

<%

if(completedOrders!=null && !completedOrders.isEmpty()){

for(Order order:completedOrders){

String badge="secondary";

if("DELIVERED".equals(order.getStatus())){

badge="success";

}else if("OUT_FOR_DELIVERY".equals(order.getStatus())){

badge="primary";

}else if("READY_FOR_PICKUP".equals(order.getStatus())){

badge="info";

}else if("PREPARING".equals(order.getStatus())){

badge="warning";

}else if("PENDING".equals(order.getStatus())){

badge="danger";

}

%>

<tr>

<td>

#<%=order.getOrderId()%>

</td>

<td>

<%=order.getCustomerName()%>

</td>

<td>

₹ <%=order.getTotalAmount()%>

</td>

<td>

<span class="badge bg-<%=badge%>">

<%=order.getStatus()%>

</span>

</td>

<td>

<%=order.getOrderDate()%>

</td>

</tr>

<%

}

}else{

%>

<tr>

<td colspan="5" class="text-center text-muted">

No Revenue Data Available

</td>

</tr>

<%

}

%>

</tbody>

</table>

</div>

<br>

<div class="row">

<div class="col-md-6">

<div class="card-box">

<h4>

Revenue Summary

</h4>

<hr>

<p>

<b>Total Revenue :</b>

₹ <%=String.format("%.2f",totalRevenue)%>

</p>

<p>

<b>Total Orders :</b>

<%=totalOrders%>

</p>

<p>

<b>Pending Orders :</b>

<%=pendingOrders%>

</p>

<p>

<b>Average Revenue / Order :</b>

₹

<%=totalOrders!=null && totalOrders>0

?

String.format("%.2f",totalRevenue/totalOrders)

:

"0.00"%>

</p>

</div>

</div>

<div class="col-md-6">

<div class="card-box">

<h4>

Quick Actions

</h4>

<hr>

<a

href="restaurantDashboard"

class="btn btn-primary w-100 mb-3">

<i class="bi bi-speedometer2"></i>

Dashboard

</a>

<a

href="restaurantOrders"

class="btn btn-warning w-100 mb-3">

<i class="bi bi-box-seam"></i>

Orders

</a>

<a

href="restaurantMenu"

class="btn btn-success w-100">

<i class="bi bi-menu-button"></i>

Manage Menu

</a>

</div>

</div>

</div>

<br>

<div class="card-box">

<h4>

Performance Insights

</h4>

<hr>

<div class="row">

<div class="col-md-4 text-center">

<h5 class="text-success">

₹ <%=String.format("%.2f",totalRevenue)%>

</h5>

<p>Total Earnings</p>

</div>

<div class="col-md-4 text-center">

<h5 class="text-primary">

<%=totalOrders%>

</h5>

<p>Total Orders</p>

</div>

<div class="col-md-4 text-center">

<h5 class="text-danger">

<%=pendingOrders%>

</h5>

<p>Pending Orders</p>

</div>

</div>

</div>

<br>

<div class="text-center text-muted">

<hr>

<p>

FoodVerse Restaurant Partner Portal

<br>

© 2026 All Rights Reserved

</p>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

const params=new URLSearchParams(window.location.search);

if(params.get("updated")){

showToast("Revenue Updated Successfully","success");

}

function showToast(message,type){

let toast=document.createElement("div");

toast.style.position="fixed";

toast.style.top="20px";

toast.style.right="20px";

toast.style.zIndex="9999";

toast.innerHTML=`

<div class="toast show text-bg-${type} border-0">

<div class="d-flex">

<div class="toast-body">

${message}

</div>

<button

type="button"

class="btn-close btn-close-white me-2 m-auto"

data-bs-dismiss="toast">

</button>

</div>

</div>

`;

document.body.appendChild(toast);

setTimeout(function(){

toast.remove();

},3000);

}

</script>

</body>

</html>