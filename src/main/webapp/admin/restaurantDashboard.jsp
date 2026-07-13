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

if(totalOrders==null) totalOrders=0;
if(pendingOrders==null) pendingOrders=0;
if(revenue==null) revenue=0.0;
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1">

<title>Restaurant Dashboard | FoodVerse</title>

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link
href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<style>

*{

margin:0;

padding:0;

box-sizing:border-box;

font-family:'Poppins',sans-serif;

}

body{

background:#EEF2FF;

overflow-x:hidden;

}

/*==========================
SIDEBAR
==========================*/

.sidebar{

position:fixed;

left:0;

top:0;

width:270px;

height:100vh;

background:#1E293B;

padding:30px 20px;

}

.logo{

font-size:30px;

font-weight:bold;

color:white;

margin-bottom:40px;

text-align:center;

}

.sidebar a{

display:block;

padding:15px 20px;

color:#CBD5E1;

text-decoration:none;

border-radius:12px;

margin-bottom:10px;

transition:.3s;

font-size:16px;

}

.sidebar a:hover{

background:#334155;

color:white;

padding-left:30px;

}

.sidebar i{

margin-right:10px;

}

/*==========================
MAIN
==========================*/

.main{

margin-left:270px;

padding:35px;

}

/*==========================
HERO
==========================*/

.hero{

background:linear-gradient(135deg,#F97316,#EA580C);

padding:35px;

border-radius:25px;

color:white;

box-shadow:0 15px 35px rgba(249,115,22,.25);

margin-bottom:30px;

}

.hero h2{

font-size:35px;

font-weight:700;

margin-bottom:8px;

}

.hero p{

opacity:.95;

margin-bottom:0;

}

.hero-right{

text-align:right;

}

.hero-right img{

width:110px;

height:110px;

border-radius:20px;

object-fit:cover;

border:4px solid white;

}

/*==========================
CARDS
==========================*/

.dashboard-card{

background:white;

padding:28px;

border-radius:20px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

transition:.35s;

height:100%;

position:relative;

overflow:hidden;

}

.dashboard-card:hover{

transform:translateY(-8px);

}

.dashboard-card::before{

content:"";

position:absolute;

left:0;

top:0;

height:5px;

width:100%;

background:#F97316;

}

.card-icon{

width:70px;

height:70px;

border-radius:18px;

display:flex;

justify-content:center;

align-items:center;

font-size:30px;

color:white;

margin-bottom:18px;

}

.orders{

background:#2563EB;

}

.pending{

background:#F59E0B;

}

.revenue{

background:#10B981;

}

.rating{

background:#7C3AED;

}

.card-value{

font-size:35px;

font-weight:700;

}

.card-title{

color:#64748B;

margin-top:8px;

}

/*==========================
PROFILE CARD
==========================*/

.profile-card{

background:white;

padding:30px;

border-radius:20px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

text-align:center;

height:100%;

}

.profile-card img{

width:140px;

height:140px;

border-radius:20px;

object-fit:cover;

margin-bottom:20px;

}

.profile-card h4{

font-weight:700;

}

.profile-card p{

color:#64748B;

margin-bottom:8px;

}

</style>

</head>

<body>

<div class="sidebar">

<div class="logo">

🍽 FoodVerse

</div>

<a href="restaurantDashboard">

<i class="bi bi-speedometer2"></i>

Dashboard

</a>

<a href="restaurantMenu">

<i class="bi bi-grid-fill"></i>

Manage Menu

</a>

<a href="restaurantOrders">

<i class="bi bi-bag-check-fill"></i>

Orders

</a>

<a href="restaurantRevenue">

<i class="bi bi-graph-up-arrow"></i>

Revenue

</a>

<a href="logout">

<i class="bi bi-box-arrow-right"></i>

Logout

</a>

</div>

<div class="main">

<!-- HERO -->

<div class="hero">

<div class="row align-items-center">

<div class="col-lg-8">

<h2>

Welcome,

<%=restaurant.getRestaurantName()%>

</h2>

<p>

Manage orders, menu, revenue and customer experience from one dashboard.

</p>

</div>

<div class="col-lg-4 hero-right">

<img

src="<%=restaurant.getImage()%>">

</div>

</div>

</div>

<!-- STATS -->

<div class="row g-4">

<div class="col-lg-3">

<div class="dashboard-card">

<div class="card-icon orders">

<i class="bi bi-bag-fill"></i>

</div>

<div class="card-value">

<%=totalOrders%>

</div>

<div class="card-title">

Total Orders

</div>

</div>

</div>

<div class="col-lg-3">

<div class="dashboard-card">

<div class="card-icon pending">

<i class="bi bi-clock-history"></i>

</div>

<div class="card-value">

<%=pendingOrders%>

</div>

<div class="card-title">

Pending Orders

</div>

</div>

</div>

<div class="col-lg-3">

<div class="dashboard-card">

<div class="card-icon revenue">

<i class="bi bi-currency-rupee"></i>

</div>

<div class="card-value">

₹ <%=String.format("%.0f",revenue)%>

</div>

<div class="card-title">

Revenue

</div>

</div>

</div>

<div class="col-lg-3">

<div class="dashboard-card">

<div class="card-icon rating">

<i class="bi bi-star-fill"></i>

</div>

<div class="card-value">

<%=restaurant.getRating()%>

</div>

<div class="card-title">

Restaurant Rating

</div>

</div>

</div>

</div>

<br>

<div class="row">

<div class="col-lg-8">
<!-- ==========================
     RECENT ORDERS
=========================== -->

<div class="card-box">

<div class="d-flex justify-content-between align-items-center mb-4">

<div>

<h4>

<i class="bi bi-bag-check-fill text-success"></i>

Recent Orders

</h4>

<p class="text-muted mb-0">

Latest customer orders

</p>

</div>

<a
href="restaurantOrders"
class="btn btn-outline-primary">

View All

</a>

</div>

<table class="table table-hover align-middle">

<thead class="table-dark">

<tr>

<th>Order</th>

<th>Customer</th>

<th>Amount</th>

<th>Status</th>

<th>Date</th>

</tr>

</thead>

<tbody>

<%

if(recentOrders!=null && !recentOrders.isEmpty()){

for(Order order:recentOrders){

String badge="secondary";

String icon="bi-clock";

if("PENDING".equalsIgnoreCase(order.getStatus())){

badge="warning";

icon="bi-hourglass-split";

}
else if("PREPARING".equalsIgnoreCase(order.getStatus())){

badge="primary";

icon="bi-fire";

}
else if("READY_FOR_PICKUP".equalsIgnoreCase(order.getStatus())){

badge="info";

icon="bi-bag-check-fill";

}
else if("OUT_FOR_DELIVERY".equalsIgnoreCase(order.getStatus())){

badge="secondary";

icon="bi-truck";

}
else if("DELIVERED".equalsIgnoreCase(order.getStatus())){

badge="success";

icon="bi-check-circle-fill";

}

%>

<tr>

<td>

<b>

#<%=order.getOrderId()%>

</b>

</td>

<td>

<div>

<b>

<%=order.getCustomerName()%>

</b>

<br>

<small class="text-muted">

Customer

</small>

</div>

</td>

<td>

<b>

₹ <%=order.getTotalAmount()%>

</b>

</td>

<td>

<span class="badge bg-<%=badge%>">

<i class="bi <%=icon%>"></i>

<%=order.getStatus().replace("_"," ")%>

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

<td colspan="5" class="text-center py-5">

<i class="bi bi-bag-x"
style="font-size:60px;color:#CBD5E1;"></i>

<h5 class="mt-3">

No Orders Yet

</h5>

<p class="text-muted">

Customer orders will appear here.

</p>

</td>

</tr>

<%

}

%>

</tbody>

</table>

</div>

</div>

<!-- ==========================
     RIGHT SIDE
=========================== -->

<div class="col-lg-4">

<!-- Restaurant Profile -->

<div class="profile-card">

<img
src="<%=restaurant.getImage()%>">

<h4>

<%=restaurant.getRestaurantName()%>

</h4>

<p>

<%=restaurant.getCuisineType()%>

</p>

<hr>

<div class="row text-center">

<div class="col-4">

<h5>

⭐

</h5>

<b>

<%=restaurant.getRating()%>

</b>

</div>

<div class="col-4">

<h5>

🍽

</h5>

<b>

<%=totalOrders%>

</b>

</div>

<div class="col-4">

<h5>

💰

</h5>

<b>

₹<%=String.format("%.0f",revenue)%>

</b>

</div>

</div>

</div>

<br>

<!-- Quick Actions -->

<div class="dashboard-card">

<h5>

<i class="bi bi-lightning-charge-fill text-warning"></i>

Quick Actions

</h5>

<hr>

<div class="d-grid gap-3">

<a
href="restaurantMenu"
class="btn btn-success">

<i class="bi bi-plus-circle-fill"></i>

Manage Menu

</a>

<a
href="restaurantOrders"
class="btn btn-primary">

<i class="bi bi-box-seam"></i>

Manage Orders

</a>

<a
href="restaurantRevenue"
class="btn btn-warning text-white">

<i class="bi bi-graph-up-arrow"></i>

Revenue Report

</a>

</div>

</div>

<br>

<!-- Restaurant Details -->

<div class="dashboard-card">

<h5>

<i class="bi bi-shop-window text-danger"></i>

Restaurant Information

</h5>

<hr>

<p>

<b>Name</b>

<br>

<%=restaurant.getRestaurantName()%>

</p>

<p>

<b>Cuisine</b>

<br>

<%=restaurant.getCuisineType()%>

</p>

<p>

<b>Rating</b>

<br>

⭐ <%=restaurant.getRating()%>

</p>

<p>

<b>Address</b>

<br>

<%=restaurant.getAddress()%>

</p>

</div>

</div>

</div>

<br>
<div class="row g-4">

<div class="col-lg-8">

<div class="dashboard-card">

<div class="d-flex justify-content-between align-items-center mb-4">

<h4>

<i class="bi bi-graph-up-arrow text-success"></i>

Revenue Analytics

</h4>

<span class="badge bg-success">

Live

</span>

</div>

<canvas id="revenueChart" height="120"></canvas>

</div>

</div>

<div class="col-lg-4">

<div class="dashboard-card">

<h4>

<i class="bi bi-speedometer2 text-primary"></i>

Today's Summary

</h4>

<hr>

<div class="d-flex justify-content-between mb-3">

<span>Total Orders</span>

<b><%=totalOrders%></b>

</div>

<div class="d-flex justify-content-between mb-3">

<span>Pending</span>

<b class="text-warning">

<%=pendingOrders%>

</b>

</div>

<div class="d-flex justify-content-between mb-3">

<span>Completed</span>

<b class="text-success">

<%=totalOrders-pendingOrders%>

</b>

</div>

<div class="d-flex justify-content-between">

<span>Revenue</span>

<b class="text-success">

₹ <%=String.format("%.0f",revenue)%>

</b>

</div>

</div>

</div>

</div>

<br>
<div class="row g-4">

<div class="col-lg-6">

<div class="dashboard-card">

<h4>

<i class="bi bi-pie-chart-fill text-danger"></i>

Restaurant Performance

</h4>

<hr>

<canvas id="performanceChart"></canvas>

</div>

</div>

<div class="col-lg-6">

<div class="dashboard-card">

<h4>

<i class="bi bi-award-fill text-warning"></i>

Achievements

</h4>

<hr>

<div class="mb-3">

🏆 Trusted Restaurant Partner

</div>

<div class="mb-3">

⭐ Rating

<b>

<%=restaurant.getRating()%>

</b>

</div>

<div class="mb-3">

🍽 Orders Served

<b>

<%=totalOrders%>

</b>

</div>

<div class="mb-3">

💰 Total Revenue

<b>

₹ <%=String.format("%.0f",revenue)%>

</b>

</div>

<div>

🚀 Growing Business

</div>

</div>

</div>

</div>

<br>
<div class="dashboard-card">

<h4>

<i class="bi bi-clock-history text-primary"></i>

Recent Activity

</h4>

<hr>

<%

if(recentOrders!=null){

int count=0;

for(Order order:recentOrders){

if(count==5) break;

count++;

%>

<div class="d-flex justify-content-between align-items-center border-bottom py-3">

<div>

<b>

Order #<%=order.getOrderId()%>

</b>

<br>

<small class="text-muted">

<%=order.getCustomerName()%>

</small>

</div>

<span class="badge bg-success">

<%=order.getStatus()%>

</span>

</div>

<%

}

}

%>

</div>

<br>
<div class="text-center mt-5">

<hr>

<h4>

🍽 FoodVerse Restaurant Partner

</h4>

<p class="text-muted">

Premium Restaurant Management Dashboard

</p>

<p class="text-muted">

Java • JSP • Servlets • MySQL • Bootstrap • Razorpay

</p>

<p class="text-muted">

© 2026 FoodVerse | All Rights Reserved

</p>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
const revenueCtx=document.getElementById("revenueChart");

new Chart(revenueCtx,{

type:"line",

data:{

labels:["Jan","Feb","Mar","Apr","May","Jun"],

datasets:[{

label:"Revenue",

data:[12,18,10,22,28,35],

fill:true,

tension:.4,

borderWidth:3

}]

},

options:{

responsive:true,

plugins:{

legend:{

display:false

}

}

}

});
const performanceCtx=document.getElementById("performanceChart");

new Chart(performanceCtx,{

type:"doughnut",

data:{

labels:[

"Completed",

"Pending"

],

datasets:[{

data:[

<%=totalOrders-pendingOrders%>,

<%=pendingOrders%>

]

}]

},

options:{

responsive:true,

plugins:{

legend:{

position:"bottom"

}

}

}

});
document.querySelectorAll(".card-value")
.forEach(function(counter){

let target=parseInt(counter.innerText.replace(/[₹,]/g,""));

if(isNaN(target)) return;

let current=0;

let timer=setInterval(function(){

current++;

counter.innerText=current;

if(current>=target){

clearInterval(timer);

}

},15);

});
function showToast(message,type){

const toast=document.createElement("div");

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

class="btn-close btn-close-white me-2 m-auto"

data-bs-dismiss="toast">

</button>

</div>

</div>

`;

document.body.appendChild(toast);

setTimeout(()=>toast.remove(),3000);

}
</script>

</body>

</html>