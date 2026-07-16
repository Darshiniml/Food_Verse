<%@page language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>
<%@page import="com.food_application.model.Activity"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>

<%@page import="com.food_application.model.DashboardStats"%>
<%@page import="com.food_application.model.RecentOrder"%>
<%@page import="com.food_application.model.TopRestaurant"%>
<%@page import="com.food_application.model.TopFood"%>

<%
DashboardStats stats =
(DashboardStats)request.getAttribute("stats");

List<RecentOrder> recentOrders =
(List<RecentOrder>)request.getAttribute("recentOrders");

TopRestaurant topRestaurant =
(TopRestaurant)request.getAttribute("topRestaurant");

TopFood topFood =
(TopFood)request.getAttribute("topFood");

Map<String,Integer> orderStatus =
(Map<String,Integer>)request.getAttribute("orderStatus");

Map<String,Double> monthlyRevenue =
(Map<String,Double>)request.getAttribute("monthlyRevenue");
List<Activity> activities =
(List<Activity>)request.getAttribute("activities");
%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>FoodVerse Admin Dashboard</title>

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link
href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<script
src="https://cdn.jsdelivr.net/npm/chart.js">
</script>

<style>

*{

margin:0;

padding:0;

box-sizing:border-box;

font-family:'Poppins',sans-serif;

}

body{

background:#F1F5F9;

overflow-x:hidden;

}

/* ==============================
SIDEBAR
============================== */

.sidebar{

position:fixed;

left:0;

top:0;

width:270px;

height:100vh;

background:linear-gradient(180deg,#0F172A,#1E293B);

padding-top:30px;

box-shadow:10px 0 30px rgba(0,0,0,.18);

z-index:1000;

}

.logo{

font-size:32px;

font-weight:700;

text-align:center;

color:white;

margin-bottom:45px;

}

.logo span{

color:#F97316;

}

.sidebar a{

display:flex;

align-items:center;

gap:15px;

padding:17px 30px;

color:#CBD5E1;

text-decoration:none;

transition:.35s;

font-size:16px;

}

.sidebar a:hover{

background:#334155;

color:white;

padding-left:40px;

border-left:5px solid #F97316;

}

.sidebar i{

font-size:21px;

}

/* ==============================
MAIN
============================== */

.main{

margin-left:270px;

padding:35px;

}

/* ==============================
TOPBAR
============================== */

.topbar{

background:white;

border-radius:22px;

padding:20px 35px;

display:flex;

justify-content:space-between;

align-items:center;

box-shadow:0 10px 25px rgba(0,0,0,.08);

margin-bottom:30px;

}

.topbar h2{

font-weight:700;

margin-bottom:5px;

}

.topbar p{

color:#64748B;

margin:0;

}

.clock{

text-align:right;

}

#clock{

font-size:30px;

font-weight:bold;

color:#1E293B;

}

#date{

color:#64748B;

}

/* ==============================
WELCOME
============================== */

.welcome{

background:linear-gradient(135deg,#4F46E5,#2563EB);

padding:35px;

border-radius:25px;

color:white;

margin-bottom:35px;

box-shadow:0 20px 35px rgba(79,70,229,.25);

}

.welcome h2{

font-size:34px;

font-weight:700;

}

.welcome p{

margin-top:12px;

font-size:18px;

opacity:.95;

}

.welcome-stats{

display:flex;

gap:40px;

margin-top:30px;

}

.welcome-stats div{

text-align:center;

}

.welcome-stats h3{

font-size:34px;

font-weight:bold;

}

.welcome-stats small{

opacity:.9;

}

/* ==============================
CARDS
============================== */

.dashboard-card{

background:white;

border-radius:22px;

padding:30px;

box-shadow:0 12px 30px rgba(0,0,0,.08);

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

top:0;

left:0;

height:6px;

width:100%;

background:#4F46E5;

}

.icon{

font-size:50px;

margin-bottom:20px;

}

.number{

font-size:38px;

font-weight:700;

}

.label{

margin-top:8px;

color:#64748B;

}

.users{

color:#2563EB;

}

.restaurants{

color:#10B981;

}

.foods{

color:#F97316;

}

.orders{

color:#7C3AED;

}

.revenue{

color:#16A34A;

}

.pending{

color:#DC2626;

}

.section-title{

font-size:24px;

font-weight:700;

margin-bottom:25px;

color:#1E293B;

}

</style>

</head>

<body>

<!-- ==========================
SIDEBAR
========================== -->

<div class="sidebar">

<div class="logo">

🍽 <span>FoodVerse</span>

</div>

<a href="adminDashboard">

<i class="bi bi-speedometer2"></i>

Dashboard

</a>

<a href="manageUsers">

<i class="bi bi-people-fill"></i>

Manage Users

</a>

<a href="manageRestaurants">

<i class="bi bi-shop"></i>

Restaurants

</a>

<a href="manageFood">

<i class="bi bi-egg-fried"></i>

Food Menu

</a>

<a href="manageOrders">

<i class="bi bi-bag-check-fill"></i>

Orders

</a>

<a href="logout">

<i class="bi bi-box-arrow-right"></i>

Logout

</a>

</div>

<!-- ==========================
MAIN
========================== -->

<div class="main">

<div class="topbar">

<div>

<h2>

FoodVerse Admin Dashboard

</h2>

<p>
Welcome back,
<b><%=session.getAttribute("loggedUser")!=null?
((com.food_application.model.User)session.getAttribute("loggedUser")).getName()
:"Administrator"%></b> 👋

</p>

</div>

<div class="clock">

<div id="clock">

00:00:00

</div>

<div id="date">

Loading...

</div>

</div>

</div>

<div class="welcome">

<h2>

Good Morning Admin ☀

</h2>

<p>

Manage users, restaurants, food items, payments and orders from one premium dashboard.

</p>

<div class="welcome-stats">

<div>

<h3>

<%=stats.getTotalOrders()%>

</h3>

<small>

Orders

</small>

</div>

<div>

<h3>

₹ <%=String.format("%.0f",stats.getTotalRevenue())%>

</h3>

<small>

Revenue

</small>

</div>

<div>

<h3>

<%=stats.getTotalRestaurants()%>

</h3>

<small>

Restaurants

</small>

</div>

<div>

<h3>

99.9%

</h3>

<small>

Server Uptime

</small>

</div>

</div>

</div>
<!-- ==========================================
            DASHBOARD STATISTICS
========================================== -->

<div class="row g-4">

<!-- USERS -->

<div class="col-xl-4 col-md-6">

<div class="dashboard-card">

<div class="d-flex justify-content-between align-items-center">

<div>

<div class="icon users">

<i class="bi bi-people-fill"></i>

</div>

<div class="number">

<%=stats.getTotalUsers()%>

</div>

<div class="label">

Total Users

</div>

</div>

<div>

<span class="badge bg-success">

↑ 12%

</span>

</div>

</div>

<hr>

<div class="d-flex justify-content-between">

<small class="text-muted">

Registered Customers

</small>

<small class="text-success">

Active

</small>

</div>

</div>

</div>

<!-- RESTAURANTS -->

<div class="col-xl-4 col-md-6">

<div class="dashboard-card">

<div class="d-flex justify-content-between align-items-center">

<div>

<div class="icon restaurants">

<i class="bi bi-shop"></i>

</div>

<div class="number">

<%=stats.getTotalRestaurants()%>

</div>

<div class="label">

Restaurants

</div>

</div>

<div>

<span class="badge bg-primary">

↑ 8%

</span>

</div>

</div>

<hr>

<div class="d-flex justify-content-between">

<small class="text-muted">

Partner Restaurants

</small>

<small class="text-primary">

Growing

</small>

</div>

</div>

</div>

<!-- FOOD ITEMS -->

<div class="col-xl-4 col-md-6">

<div class="dashboard-card">

<div class="d-flex justify-content-between align-items-center">

<div>

<div class="icon foods">

<i class="bi bi-egg-fried"></i>

</div>

<div class="number">

<%=stats.getTotalFoodItems()%>

</div>

<div class="label">

Food Items

</div>

</div>

<div>

<span class="badge bg-warning text-dark">

+24

</span>

</div>

</div>

<hr>

<div class="d-flex justify-content-between">

<small class="text-muted">

Available Menu

</small>

<small class="text-warning">

Updated

</small>

</div>

</div>

</div>

<!-- ORDERS -->

<div class="col-xl-4 col-md-6">

<div class="dashboard-card">

<div class="d-flex justify-content-between align-items-center">

<div>

<div class="icon orders">

<i class="bi bi-bag-check-fill"></i>

</div>

<div class="number">

<%=stats.getTotalOrders()%>

</div>

<div class="label">

Total Orders

</div>

</div>

<div>

<span class="badge bg-info">

Today

</span>

</div>

</div>

<hr>

<div class="d-flex justify-content-between">

<small class="text-muted">

Completed Orders

</small>

<small class="text-info">

Live

</small>

</div>

</div>

</div>

<!-- REVENUE -->

<div class="col-xl-4 col-md-6">

<div class="dashboard-card">

<div class="d-flex justify-content-between align-items-center">

<div>

<div class="icon revenue">

<i class="bi bi-currency-rupee"></i>

</div>

<div class="number">

₹ <%=String.format("%.0f",stats.getTotalRevenue())%>
</div>

<div class="label">

Revenue

</div>

</div>

<div>

<span class="badge bg-success">

+18%

</span>

</div>

</div>

<hr>

<div class="d-flex justify-content-between">

<small class="text-muted">

Total Earnings

</small>

<small class="text-success">

Excellent

</small>

</div>

</div>

</div>

<!-- PAYMENT PENDING -->

<div class="col-xl-4 col-md-6">

<div class="dashboard-card">

<div class="d-flex justify-content-between align-items-center">

<div>

<div class="icon pending">

<i class="bi bi-clock-history"></i>

</div>

<div class="number">

<%=stats.getPendingOrders()%>

</div>

<div class="label">

Pending Orders

</div>

</div>

<div>

<span class="badge bg-danger">

Action

</span>

</div>

</div>

<hr>

<div class="d-flex justify-content-between">

<small class="text-muted">

Need Attention

</small>

<small class="text-danger">

Pending

</small>

</div>

</div>

</div>

</div>

<!-- ==========================================
            TODAY'S SUMMARY
========================================== -->

<br><br>

<h3 class="section-title">

<i class="bi bi-lightning-charge-fill text-warning"></i>

Today's Summary

</h3>

<div class="row g-4">

<div class="col-lg-3">

<div class="dashboard-card text-center">

<i class="bi bi-cart-check-fill text-primary"

style="font-size:45px;"></i>

<h2 class="mt-3">

<%=stats.getTotalOrders()%>

</h2>

<p class="text-muted">

Orders Received

</p>

</div>

</div>

<div class="col-lg-3">

<div class="dashboard-card text-center">

<i class="bi bi-cash-stack text-success"

style="font-size:45px;"></i>

<h2 class="mt-3">

₹<%=String.format("%.0f",stats.getTotalRevenue())%>

</h2>

<p class="text-muted">

Today's Revenue

</p>

</div>

</div>

<div class="col-lg-3">

<div class="dashboard-card text-center">

<i class="bi bi-shop-window text-warning"

style="font-size:45px;"></i>

<h2 class="mt-3">

<%=stats.getTotalRestaurants()%>

</h2>

<p class="text-muted">

Active Restaurants

</p>

</div>

</div>

<div class="col-lg-3">

<div class="dashboard-card text-center">

<i class="bi bi-person-check-fill text-danger"

style="font-size:45px;"></i>

<h2 class="mt-3">

<%=stats.getTotalUsers()%>

</h2>

<p class="text-muted">

Active Users

</p>

</div>

</div>

</div>

<br><br>
<!-- ==========================================
            ANALYTICS SECTION
========================================== -->

<h3 class="section-title">

<i class="bi bi-graph-up-arrow text-success"></i>

Business Analytics

</h3>

<div class="row g-4">

<!-- Revenue Chart -->

<div class="col-lg-8">

<div class="dashboard-card">

<div class="d-flex justify-content-between align-items-center mb-4">

<h4>

Revenue Overview

</h4>

<span class="badge bg-success">

2026

</span>

</div>

<canvas id="revenueChart"

height="120">

</canvas>

</div>

</div>

<!-- Doughnut -->

<div class="col-lg-4">

<div class="dashboard-card">

<h4 class="mb-4">

Order Status

</h4>

<canvas id="statusChart"

height="260">

</canvas>

</div>

</div>

</div>

<br>

<!-- ==========================================
        QUICK ACTIONS
========================================== -->

<h3 class="section-title">

<i class="bi bi-lightning-fill text-warning"></i>

Quick Actions

</h3>

<div class="row g-4">

<div class="col-md-3">

<div class="dashboard-card text-center">

<i class="bi bi-plus-circle-fill"

style="font-size:55px;color:#2563EB;"></i>

<h5 class="mt-3">

Add Restaurant

</h5>

<a href="<%=request.getContextPath()%>/manageRestaurants"

class="btn btn-primary mt-3">

Open

</a>

</div>

</div>

<div class="col-md-3">

<div class="dashboard-card text-center">

<i class="bi bi-egg-fried"

style="font-size:55px;color:#F97316;"></i>

<h5 class="mt-3">

Add Food

</h5>

<a href="<%=request.getContextPath()%>/manageFood"

class="btn btn-warning mt-3 text-white">

Open

</a>

</div>

</div>

<div class="col-md-3">

<div class="dashboard-card text-center">

<i class="bi bi-people-fill"

style="font-size:55px;color:#16A34A;"></i>

<h5 class="mt-3">

Manage Users

</h5>

<a href="<%=request.getContextPath()%>/manageUsers"

class="btn btn-success mt-3">

Open

</a>

</div>

</div>

<div class="col-md-3">

<div class="dashboard-card text-center">

<i class="bi bi-bag-fill"

style="font-size:55px;color:#7C3AED;"></i>

<h5 class="mt-3">

Manage Orders

</h5>

<a href="<%=request.getContextPath()%>/manageOrders"

class="btn btn-dark mt-3">

Open

</a>

</div>

</div>

</div>

<br>

<!-- ==========================================
        TOP PERFORMERS
========================================== -->

<h3 class="section-title">

<i class="bi bi-trophy-fill text-warning"></i>

Top Performers

</h3>

<div class="row g-4">

<div class="col-lg-6">

<div class="dashboard-card">

<h4>

🏆 Top Restaurant

</h4>

<hr>

<div class="d-flex justify-content-between">

<div>

<h5>

<%=topRestaurant.getRestaurantName()%>

</h5>

<p class="text-muted">

Highest Ordered Restaurant

</p>

</div>

<div>

<span class="badge bg-success">

<%=topRestaurant.getTotalOrders()%> Orders

</span>

</div>

</div>

<div class="progress mt-4">

<div class="progress-bar bg-success"

style="width:92%;">

92%

</div>

</div>

</div>

</div>

<div class="col-lg-6">

<div class="dashboard-card">

<h4>

🍕 Best Selling Food

</h4>

<hr>

<div class="d-flex justify-content-between">

<div>

<h5>

<%=topFood.getFoodName()%>

</h5>

<p class="text-muted">

Best Selling Food

</p>

</div>

<div>

<span class="badge bg-warning text-dark">

<%=topFood.getTotalOrders()%> Orders

</span>

</div>

</div>

<div class="progress mt-4">

<div class="progress-bar bg-warning"

style="width:87%;">

87%

</div>

</div>

</div>

</div>

</div>

<br>
<!-- ==========================================
            RECENT ORDERS
========================================== -->

<h3 class="section-title">

<i class="bi bi-bag-check-fill text-primary"></i>

Recent Orders

</h3>

<div class="dashboard-card">

<table class="table table-hover align-middle">

<thead class="table-dark">

<tr>

<th>Order ID</th>

<th>Customer</th>

<th>Restaurant</th>

<th>Amount</th>

<th>Status</th>

</tr>

</thead>

<tbody>

<%

if(recentOrders!=null){

for(RecentOrder order : recentOrders){

%>

<tr>

<td>

#<%=order.getOrderId()%>

</td>

<td>

<%=order.getCustomerName()%>

</td>

<td>

<%=order.getRestaurantName()%>

</td>

<td>

₹ <%=String.format("%.2f",order.getAmount())%>

</td>

<td>

<%

String status=order.getStatus();

String badge="bg-secondary";

if("DELIVERED".equalsIgnoreCase(status))
badge="bg-success";

else if("PENDING".equalsIgnoreCase(status))
badge="bg-danger";

else if("PREPARING".equalsIgnoreCase(status))
badge="bg-warning text-dark";

else if("OUT_FOR_DELIVERY".equalsIgnoreCase(status))
badge="bg-primary";

%>

<span class="badge <%=badge%>">

<%=status%>

</span>

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

<!-- ==========================================
        ACTIVITY + STATUS
========================================== -->

<div class="row g-4">

<div class="col-lg-6">

<div class="dashboard-card">

<h4>

<i class="bi bi-activity text-success"></i>

Recent Activities

</h4>

<hr>

<%

for(Activity activity : activities){

%>

<p>

<i class="bi <%=activity.getIcon()%> text-<%=activity.getColor()%>"></i>

<%=activity.getMessage()%>

</p>

<%

}

%>

</div>

</div>

<div class="col-lg-6">

<div class="dashboard-card">

<h4>

<i class="bi bi-cpu-fill text-primary"></i>

System Status

</h4>

<hr>

<div class="d-flex justify-content-between mb-3">

<span>Database</span>

<span class="badge bg-success">

Connected

</span>

</div>

<div class="d-flex justify-content-between mb-3">

<span>Payment Gateway</span>

<span class="badge bg-success">

Online

</span>

</div>

<div class="d-flex justify-content-between mb-3">

<span>Email Service</span>

<span class="badge bg-success">

Running

</span>

</div>

<div class="d-flex justify-content-between mb-3">

<span>Server</span>

<span class="badge bg-success">

Healthy

</span>

</div>

<div class="d-flex justify-content-between">

<span>API Status</span>

<span class="badge bg-success">

Live

</span>

</div>

</div>

</div>

</div>

<br>

<!-- ==========================================
            FOOTER
========================================== -->


<script>

/*==========================
      LIVE CLOCK
==========================*/

function updateClock(){

const now=new Date();

document.getElementById("clock").innerHTML=

now.toLocaleTimeString();

document.getElementById("date").innerHTML=

now.toDateString();

}

setInterval(updateClock,1000);

updateClock();

/*==========================
      REVENUE CHART
==========================*/

new Chart(document.getElementById("revenueChart"),{

type:'line',

data:{

	labels:[
		<%
		for(String month:monthlyRevenue.keySet()){
		%>
		'<%=month%>',
		<%
		}
		%>
		],

datasets:[{

label:'Revenue',

data:[
	<%
	for(Double amount:monthlyRevenue.values()){
	%>
	<%=amount%>,
	<%
	}
	%>
	],

borderColor:'#4F46E5',

backgroundColor:'rgba(79,70,229,.15)',

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

},

scales:{

y:{

beginAtZero:true

}

}

}

});

/*==========================
      STATUS CHART
==========================*/

new Chart(document.getElementById("statusChart"),{

type:'doughnut',

data:{

	labels:[
		<%
		for(String status:orderStatus.keySet()){
		%>
		'<%=status%>',
		<%
		}
		%>
		],

datasets:[{

	data:[
		<%
		for(Integer total:orderStatus.values()){
		%>
		<%=total%>,
		<%
		}
		%>
		],
backgroundColor:[

'#22C55E',

'#F59E0B',

'#EF4444'

],

borderWidth:0

}]

},

options:{

plugins:{

legend:{

position:'bottom'

}

}

}

});

/*==========================
      CARD ANIMATION
==========================*/

document.querySelectorAll(".dashboard-card").forEach(function(card){

card.style.opacity="0";

card.style.transform="translateY(20px)";

});

window.onload=function(){

document.querySelectorAll(".dashboard-card").forEach(function(card,index){

setTimeout(function(){

card.style.transition=".5s";

card.style.opacity="1";

card.style.transform="translateY(0px)";

},index*120);

});

};

</script>
<div class="text-center mt-5">

<hr>

<h5>

🍽 FoodVerse

</h5>

<p class="text-muted">

Premium Food Delivery Management System

</p>

<p class="text-muted">

© 2026 FoodVerse | Java • JSP • Servlets • MySQL • Bootstrap

</p>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


</body>

</html>
