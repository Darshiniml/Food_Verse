<%@page language="java" contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>

<%
int users=(Integer)request.getAttribute("users");
int restaurants=(Integer)request.getAttribute("restaurants");
int foods=(Integer)request.getAttribute("foods");
int orders=(Integer)request.getAttribute("orders");
int pending=(Integer)request.getAttribute("pending");
double revenue=(Double)request.getAttribute("revenue");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Admin Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap"
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

/* Sidebar */

.sidebar{

position:fixed;

left:0;

top:0;

width:260px;

height:100vh;

background:#1e293b;

padding-top:30px;

}

.logo{

color:white;

text-align:center;

font-size:30px;

font-weight:bold;

margin-bottom:40px;

}

.sidebar a{

display:block;

color:#cbd5e1;

padding:15px 30px;

text-decoration:none;

transition:.3s;

font-size:16px;

}

.sidebar a:hover{

background:#334155;

color:white;

padding-left:40px;

}

/* Main */

.main{

margin-left:260px;

padding:40px;

}

.title{

font-size:35px;

font-weight:bold;

color:#1e293b;

margin-bottom:30px;

}

/* Cards */

.dashboard-card{

background:white;

border-radius:18px;

padding:30px;

box-shadow:0 8px 20px rgba(0,0,0,.08);

transition:.3s;

}

.dashboard-card:hover{

transform:translateY(-8px);

}

.icon{

font-size:45px;

margin-bottom:20px;

}

.number{

font-size:34px;

font-weight:bold;

}

.label{

color:gray;

margin-top:8px;

}

.users{

color:#2563eb;

}

.restaurants{

color:#059669;

}

.foods{

color:#ea580c;

}

.orders{

color:#7c3aed;

}

.revenue{

color:#16a34a;

}

.pending{

color:#dc2626;

}

/* Footer */

.footer{

margin-top:60px;

text-align:center;

color:#64748b;

}

</style>

</head>

<body>

<div class="sidebar">

<div class="logo">

FoodVerse

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

Manage Restaurants

</a>

<a href="manageFood">

<i class="bi bi-egg-fried"></i>

Manage Food

</a>

<a href="manageOrders">

<i class="bi bi-bag-check-fill"></i>

Manage Orders

</a>

<a href="logout">

<i class="bi bi-box-arrow-right"></i>

Logout

</a>

</div>

<div class="main">

<div class="title">

Dashboard Overview

</div>

<div class="row g-4">

<div class="col-lg-4">

<div class="dashboard-card">

<div class="icon users">

<i class="bi bi-people-fill"></i>

</div>

<div class="number">

<%=users%>

</div>

<div class="label">

Total Users

</div>

</div>

</div>

<div class="col-lg-4">

<div class="dashboard-card">

<div class="icon restaurants">

<i class="bi bi-shop"></i>

</div>

<div class="number">

<%=restaurants%>

</div>

<div class="label">

Restaurants

</div>

</div>

</div>

<div class="col-lg-4">

<div class="dashboard-card">

<div class="icon foods">

<i class="bi bi-egg-fried"></i>

</div>

<div class="number">

<%=foods%>

</div>

<div class="label">

Food Items

</div>

</div>

</div>

<div class="col-lg-4">

<div class="dashboard-card">

<div class="icon orders">

<i class="bi bi-bag-fill"></i>

</div>

<div class="number">

<%=orders%>

</div>

<div class="label">

Orders

</div>

</div>

</div>

<div class="col-lg-4">

<div class="dashboard-card">

<div class="icon revenue">

<i class="bi bi-currency-rupee"></i>

</div>

<div class="number">

&#8377; <%=String.format("%.2f",revenue)%>

</div>

<div class="label">

Revenue

</div>

</div>

</div>

<div class="col-lg-4">

<div class="dashboard-card">

<div class="icon pending">

<i class="bi bi-clock-history"></i>

</div>

<div class="number">

<%=pending%>

</div>

<div class="label">

Pending Orders

</div>

</div>

</div>

</div>

<div class="footer">

<hr>

FoodVerse Admin Dashboard © 2026

</div>

</div>

</body>

</html>