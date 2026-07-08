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
(Integer)request.getAttribute("orders");

Integer pendingOrders =
(Integer)request.getAttribute("pending");

Double revenue =
(Double)request.getAttribute("revenue");

List<Order> recentOrders =
(List<Order>)request.getAttribute("recentOrders");
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Restaurant Dashboard</title>

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>

body{

background:#F1F5F9;

font-family:Segoe UI;

}

.sidebar{

width:250px;

height:100vh;

position:fixed;

background:#1E293B;

color:white;

padding:25px;

}

.sidebar h3{

margin-bottom:40px;

}

.sidebar a{

display:block;

color:white;

text-decoration:none;

padding:12px;

border-radius:8px;

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

box-shadow:0 5px 15px rgba(0,0,0,.08);

}

.profile{

width:120px;

height:120px;

object-fit:cover;

border-radius:15px;

}

.stat{

font-size:30px;

font-weight:bold;

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

Welcome,

<%=restaurant.getRestaurantName()%>

</h2>

<p class="text-muted">

Restaurant Owner Dashboard

</p>

<div class="row">

<div class="col-md-3">

<div class="card-box">

<h6>Total Orders</h6>

<div class="stat">

<%=totalOrders%>

</div>

</div>

</div>

<div class="col-md-3">

<div class="card-box">

<h6>Pending Orders</h6>

<div class="stat">

<%=pendingOrders%>

</div>

</div>

</div>

<div class="col-md-3">

<div class="card-box">

<h6>Revenue</h6>

<div class="stat">

₹ <%=revenue%>

</div>

</div>

</div>

<div class="col-md-3">

<div class="card-box text-center">

<img
class="profile"
src="<%=restaurant.getImage()%>">

<h5 class="mt-3">

<%=restaurant.getCuisineType()%>

</h5>

</div>

</div>

</div>

<br>

<div class="card-box">

<h4>

Recent Orders

</h4>

<table class="table table-hover">

<thead>

<tr>

<th>ID</th>

<th>Customer</th>

<th>Amount</th>

<th>Status</th>

<th>Date</th>

</tr>

</thead>

<tbody>

<%

if(recentOrders!=null){

for(Order order:recentOrders){

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
<%

String status = order.getStatus();

String badge = "";

switch(status){

case "PENDING":
    badge="warning";
    break;

case "PREPARING":
    badge="primary";
    break;

case "READY_FOR_PICKUP":
    badge="info";
    break;

case "OUT_FOR_DELIVERY":
    badge="secondary";
    break;

case "DELIVERED":
    badge="success";
    break;

default:
    badge="danger";

}

%>

<span class="badge bg-<%=badge%>">

<%=status%>

</span>

</td>

<td>

<%=order.getOrderDate()%>

</td>

</tr>

<%

}

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

Quick Actions

</h4>

<hr>

<a href="restaurantMenu"

class="btn btn-success w-100 mb-3">

<i class="bi bi-plus-circle-fill"></i>

Manage Menu

</a>

<a href="restaurantOrders"

class="btn btn-primary w-100 mb-3">

<i class="bi bi-box-seam"></i>

Manage Orders

</a>

<a href="restaurantRevenue"

class="btn btn-warning w-100">

<i class="bi bi-graph-up-arrow"></i>

Revenue Report

</a>

</div>

</div>

<div class="col-md-6">

<div class="card-box">

<h4>

Restaurant Information

</h4>

<hr>

<p>

<b>Name :</b>

<%=restaurant.getRestaurantName()%>

</p>

<p>

<b>Cuisine :</b>

<%=restaurant.getCuisineType()%>

</p>

<p>

<b>Rating :</b>

⭐ <%=restaurant.getRating()%>

</p>

<p>

<b>Address :</b>

<%=restaurant.getAddress()%>

</p>

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

</body>

</html>