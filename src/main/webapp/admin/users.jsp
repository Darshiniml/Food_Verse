<%@page language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="com.food_application.model.User"%>

<%
List<User> users =
(List<User>)request.getAttribute("users");

int totalUsers=0;
int customers=0;
int restaurants=0;
int delivery=0;
int admins=0;

if(users!=null){

    totalUsers=users.size();

    for(User user:users){

        if(user.getRole()==null)
            continue;

        switch(user.getRole()){

        case "CUSTOMER":
            customers++;
            break;

        case "RESTAURANT":
            restaurants++;
            break;

        case "DELIVERY_AGENT":
            delivery++;
            break;

        case "ADMIN":
            admins++;
            break;

        }

    }

}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1">

<title>FoodVerse | User Management</title>

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
MAIN
==========================*/

.main{

padding:35px;

}

/*==========================
HERO
==========================*/

.hero{

background:linear-gradient(135deg,#4F46E5,#2563EB);

padding:40px;

border-radius:25px;

color:white;

box-shadow:0 20px 35px rgba(79,70,229,.25);

margin-bottom:35px;

}

.hero h2{

font-size:38px;

font-weight:700;

margin-bottom:12px;

}

.hero p{

font-size:17px;

opacity:.95;

margin-bottom:0;

}

.hero-right{

text-align:right;

}

.hero-right h1{

font-size:55px;

font-weight:bold;

margin:0;

}

.hero-right small{

font-size:15px;

opacity:.9;

}

/*==========================
STAT CARDS
==========================*/

.stats-card{

background:white;

padding:28px;

border-radius:22px;

box-shadow:0 12px 25px rgba(0,0,0,.08);

transition:.35s;

height:100%;

position:relative;

overflow:hidden;

}

.stats-card:hover{

transform:translateY(-8px);

}

.stats-card::before{

content:"";

position:absolute;

left:0;

top:0;

width:100%;

height:5px;

background:#4F46E5;

}

.stats-icon{

width:70px;

height:70px;

border-radius:18px;

display:flex;

justify-content:center;

align-items:center;

font-size:32px;

color:white;

margin-bottom:18px;

}

.bg-users{

background:#2563EB;

}

.bg-customers{

background:#10B981;

}

.bg-restaurants{

background:#F97316;

}

.bg-delivery{

background:#DC2626;

}

.bg-admin{

background:#7C3AED;

}

.stats-value{

font-size:36px;

font-weight:700;

}

.stats-title{

color:#64748B;

margin-top:5px;

}

/*==========================
SEARCH PANEL
==========================*/

.search-panel{

background:white;

padding:25px;

border-radius:20px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

margin-bottom:30px;

}

.section-title{

font-size:24px;

font-weight:700;

margin-bottom:25px;

}

.form-control,
.form-select{

height:48px;

border-radius:12px;

}

.btn-refresh{

height:48px;

border-radius:12px;

}

/*==========================
TABLE
==========================*/

.card-box{

background:white;

padding:25px;

border-radius:22px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

}

.table{

margin-bottom:0;

}

.table thead{

background:#1E293B;

color:white;

}

.table td{

vertical-align:middle;

padding:18px;

}

.table tbody tr{

transition:.3s;

}

.table tbody tr:hover{

background:#EEF4FF;

transform:scale(1.003);

}

</style>

</head>

<body>

<div class="main">

<!-- HERO -->

<div class="hero">

<div class="row align-items-center">

<div class="col-lg-8">

<h2>

👥 User Management

</h2>

<p>

Manage Customers, Restaurant Owners, Delivery Partners and Administrators from one dashboard.

</p>

</div>

<div class="col-lg-4 hero-right">

<h1>

<%=totalUsers%>

</h1>

<small>

Registered Users

</small>

</div>

</div>

</div>

<!-- STATISTICS -->

<div class="row g-4 mb-4">

<div class="col-lg">

<div class="stats-card">

<div class="stats-icon bg-users">

<i class="bi bi-people-fill"></i>

</div>

<div class="stats-value">

<%=totalUsers%>

</div>

<div class="stats-title">

Total Users

</div>

</div>

</div>

<div class="col-lg">

<div class="stats-card">

<div class="stats-icon bg-customers">

<i class="bi bi-person-fill"></i>

</div>

<div class="stats-value">

<%=customers%>

</div>

<div class="stats-title">

Customers

</div>

</div>

</div>

<div class="col-lg">

<div class="stats-card">

<div class="stats-icon bg-restaurants">

<i class="bi bi-shop"></i>

</div>

<div class="stats-value">

<%=restaurants%>

</div>

<div class="stats-title">

Restaurants

</div>

</div>

</div>

<div class="col-lg">

<div class="stats-card">

<div class="stats-icon bg-delivery">

<i class="bi bi-bicycle"></i>

</div>

<div class="stats-value">

<%=delivery%>

</div>

<div class="stats-title">

Delivery Partners

</div>

</div>

</div>

<div class="col-lg">

<div class="stats-card">

<div class="stats-icon bg-admin">

<i class="bi bi-shield-lock-fill"></i>

</div>

<div class="stats-value">

<%=admins%>

</div>

<div class="stats-title">

Administrators

</div>

</div>

</div>

</div>

<!-- SEARCH PANEL -->

<div class="search-panel">

<h4 class="section-title">

<i class="bi bi-search"></i>

Search & Filter Users

</h4>

<div class="row g-3">

<div class="col-lg-5">

<input

type="text"

id="searchUser"

class="form-control"

placeholder="Search by Name, Email or Phone">

</div>

<div class="col-lg-3">

<select

id="roleFilter"

class="form-select">

<option value="">

All Roles

</option>

<option>

ADMIN

</option>

<option>

CUSTOMER

</option>

<option>

RESTAURANT

</option>

<option>

DELIVERY_AGENT

</option>

</select>

</div>

<div class="col-lg-2">

<button

class="btn btn-outline-primary w-100 btn-refresh"

onclick="location.reload()">

<i class="bi bi-arrow-clockwise"></i>

Refresh

</button>

</div>

<div class="col-lg-2">

<button

class="btn btn-success w-100 btn-refresh">

<i class="bi bi-download"></i>

Export

</button>

</div>

</div>

</div>

<!-- PREMIUM USER TABLE -->

<div class="card-box">

<h4 class="mb-4">

<i class="bi bi-table"></i>

Registered Users

</h4>

<table class="table table-hover align-middle" id="userTable">

<thead>

<tr>

<th>ID</th>

<th>User</th>

<th>Email</th>

<th>Phone</th>

<th>Role</th>

<th>Status</th>

<th>Actions</th>

</tr>

</thead>

<tbody>
<%

if(users != null && !users.isEmpty()){

    for(User user : users){

        String role = user.getRole();

        if(role == null || role.trim().isEmpty()){

            role = "CUSTOMER";

        }

        String badge = "bg-primary";
        String roleIcon = "bi-person-fill";

        if(role.equalsIgnoreCase("ADMIN")){

            badge = "bg-danger";
            roleIcon = "bi-shield-lock-fill";

        }
        else if(role.equalsIgnoreCase("RESTAURANT")){

            badge = "bg-success";
            roleIcon = "bi-shop";

        }
        else if(role.equalsIgnoreCase("DELIVERY_AGENT")){

            badge = "bg-warning text-dark";
            roleIcon = "bi-bicycle";

        }

        String firstLetter = "";

        if(user.getName()!=null && !user.getName().isEmpty()){

            firstLetter = user.getName()
                              .substring(0,1)
                              .toUpperCase();

        }

%>

<tr>

<td>

<b>#<%=user.getUserId()%></b>

</td>

<td>

<div class="d-flex align-items-center">

<div
style="
width:50px;
height:50px;
border-radius:50%;
background:#4F46E5;
color:white;
display:flex;
align-items:center;
justify-content:center;
font-size:20px;
font-weight:bold;
margin-right:15px;">

<%=firstLetter%>

</div>

<div>

<h6 class="mb-1">

<%=user.getName()%>

</h6>

<small class="text-muted">

User ID :
#<%=user.getUserId()%>

</small>

</div>

</div>

</td>

<td>

<%=user.getEmail()%>

</td>

<td>

<%=user.getPhone()%>

</td>

<td>

<span class="badge <%=badge%>">

<i class="bi <%=roleIcon%>"></i>

<%=role.replace("_"," ")%>

</span>

</td>

<td>

<span class="badge bg-success">

<i class="bi bi-check-circle-fill"></i>

Active

</span>

</td>

<td>

<div class="btn-group">

<button
class="btn btn-outline-primary btn-sm"
title="View">

<i class="bi bi-eye-fill"></i>

</button>

<button
class="btn btn-outline-success btn-sm"
title="Edit">

<i class="bi bi-pencil-fill"></i>

</button>

<%

User loggedUser =
(User)session.getAttribute("loggedUser");

if(loggedUser!=null &&
loggedUser.getUserId()!=user.getUserId()){

%>

<a
href="<%=request.getContextPath()%>/deleteUser?id=<%=user.getUserId()%>"
class="btn btn-outline-danger btn-sm"
onclick="return confirm('Delete this user?');">

<i class="bi bi-trash-fill"></i>

</a>

<%

}else{

%>

<button
class="btn btn-secondary btn-sm"
disabled>

Current Admin

</button>

<%

}

%>

</div>

</td>

</tr>

<%

    }

}else{

%>

<tr>

<td colspan="7">

<div class="text-center py-5">

<i
class="bi bi-people"
style="font-size:70px;color:#CBD5E1;"></i>

<h3 class="mt-3">

No Users Found

</h3>

<p class="text-muted">

No registered users available.

</p>

</div>

</td>

</tr>

<%

}

%>

</tbody>

</table>

</div>

<br><br>

<div class="row mt-4">

<div class="col-lg-6">

<div class="card-box">

<h4>

<i class="bi bi-pie-chart-fill text-primary"></i>

Role Distribution

</h4>

<hr>

<canvas id="roleChart" height="220"></canvas>

</div>

</div>

<div class="col-lg-6">

<div class="card-box">

<h4>

<i class="bi bi-bar-chart-fill text-success"></i>

User Statistics

</h4>

<hr>

<table class="table">

<tr>

<td>Total Users</td>

<td><b><%=totalUsers%></b></td>

</tr>

<tr>

<td>Customers</td>

<td><%=customers%></td>

</tr>

<tr>

<td>Restaurants</td>

<td><%=restaurants%></td>

</tr>

<tr>

<td>Delivery Partners</td>

<td><%=delivery%></td>

</tr>

<tr>

<td>Administrators</td>

<td><%=admins%></td>

</tr>

</table>

</div>

</div>

</div>

<br>
<div class="card-box">

<h4>

<i class="bi bi-clock-history text-warning"></i>

Recent Registrations

</h4>

<hr>

<%

if(users!=null){

int count=0;

for(int i=users.size()-1;i>=0 && count<5;i--){

User u=users.get(i);

count++;

%>

<div class="d-flex justify-content-between border-bottom py-2">

<div>

<b><%=u.getName()%></b>

<br>

<small class="text-muted">

<%=u.getRole()%>

</small>

</div>

<div>

<span class="badge bg-success">

New

</span>

</div>

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

🍽 FoodVerse

</h4>

<p class="text-muted">

Enterprise User Management System

</p>

<p class="text-muted">

Java • JSP • Servlets • MySQL • Bootstrap • Razorpay

</p>

<p class="text-muted">

© 2026 FoodVerse. All Rights Reserved.

</p>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

const ctx=document.getElementById("roleChart");

new Chart(ctx,{

type:"doughnut",

data:{

labels:[

"Customers",

"Restaurants",

"Delivery",

"Admins"

],

datasets:[{

data:[

<%=customers%>,

<%=restaurants%>,

<%=delivery%>,

<%=admins%>

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
document.getElementById("searchUser")
.addEventListener("keyup",function(){

let value=this.value.toLowerCase();

document.querySelectorAll("#userTable tbody tr")
.forEach(function(row){

row.style.display=

row.innerText.toLowerCase().includes(value)

? ""

: "none";

});


});
document.getElementById("roleFilter")
.addEventListener("change",function(){

let role=this.value.toLowerCase();

document.querySelectorAll("#userTable tbody tr")
.forEach(function(row){

if(role==""){

row.style.display="";

return;

}

let text=row.cells[4].innerText.toLowerCase();

row.style.display=text.includes(role)

? ""

: "none";

});

});
document.querySelectorAll(".stats-value")
.forEach(function(counter){

let target=parseInt(counter.innerText);

let current=0;

let speed=20;

let timer=setInterval(function(){

current++;

counter.innerText=current;

if(current>=target){

clearInterval(timer);

}

},speed);

});

function showToast(message,type){

const toast=document.createElement("div");

toast.style.position="fixed";

toast.style.top="20px";

toast.style.right="20px";

toast.style.zIndex="9999";

toast.innerHTML=`

<div class="toast show text-bg-${type}">

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
document.querySelectorAll(".btn-outline-danger")
.forEach(function(btn){

btn.onclick=function(){

return confirm("Delete this user?");

};

});
</script>

</body>

</html>
