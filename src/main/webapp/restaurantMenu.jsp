<%@page language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="com.food_application.model.Restaurant"%>
<%@page import="com.food_application.model.FoodItem"%>

<%
Restaurant restaurant =
(Restaurant)request.getAttribute("restaurant");

List<FoodItem> foods =
(List<FoodItem>)request.getAttribute("foods");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Restaurant Menu</title>

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

.food-img{

width:80px;

height:80px;

border-radius:10px;

object-fit:cover;

}

.badge-available{

background:#22C55E;

}

.badge-unavailable{

background:#EF4444;

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

<a href="restaurantOrders">

<i class="bi bi-box-seam"></i>

Orders

</a>

<a href="restaurantMenu">

<i class="bi bi-menu-button"></i>

Manage Menu

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

<div class="d-flex justify-content-between align-items-center mb-4">

<div>

<h2>

<%=restaurant.getRestaurantName()%>

Menu

</h2>

<p class="text-muted">

Manage your food items

</p>

</div>

<a href="addFood"

class="btn btn-success">

<i class="bi bi-plus-circle-fill"></i>

Add Food

</a>

</div>

<div class="row mb-4">

<div class="col-md-5">

<input

type="text"

id="searchFood"

class="form-control"

placeholder="Search Food Item...">

</div>

</div>

<div class="card-box">

<table

class="table table-hover align-middle"

id="foodTable">

<thead>

<tr>

<th>Image</th>

<th>Name</th>

<th>Category</th>

<th>Price</th>

<th>Status</th>

<th width="220">

Action

</th>

</tr>

</thead>

<tbody>
<br>

<div class="row">

<div class="col-md-4">

<div class="card-box text-center">

<h5>Total Items</h5>

<hr>

<h2>

<%=foods==null?0:foods.size()%>

</h2>

</div>

</div>

<div class="col-md-4">

<div class="card-box text-center">

<h5>Available</h5>

<hr>

<h2 id="availableCount"></h2>

</div>

</div>

<div class="col-md-4">

<div class="card-box text-center">

<h5>Unavailable</h5>

<hr>

<h2 id="unavailableCount"></h2>

</div>

</div>

</div>

<br>

<div class="card-box">

<h5>Quick Actions</h5>

<hr>

<a href="addFood"

class="btn btn-success me-2">

<i class="bi bi-plus-circle"></i>

Add Food

</a>

<a href="restaurantOrders"

class="btn btn-warning me-2">

<i class="bi bi-box-seam"></i>

Orders

</a>

<a href="restaurantDashboard"

class="btn btn-primary">

<i class="bi bi-speedometer2"></i>

Dashboard

</a>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

document.getElementById("searchFood")
.addEventListener("keyup",function(){

let value=this.value.toLowerCase();

let rows=document.querySelectorAll("#foodTable tbody tr");

rows.forEach(function(row){

let txt=row.innerText.toLowerCase();

row.style.display=

txt.includes(value)

? ""

: "none";

});

});

let available=0;

let unavailable=0;

document.querySelectorAll(".badge").forEach(function(b){

if(b.innerText.trim()=="Available")

available++;

else

unavailable++;

});

document.getElementById("availableCount").innerHTML=available;

document.getElementById("unavailableCount").innerHTML=unavailable;

const params=new URLSearchParams(window.location.search);

if(params.get("success")){

showToast("Operation Completed Successfully","success");

}

function showToast(msg,type){

let div=document.createElement("div");

div.style.position="fixed";

div.style.top="20px";

div.style.right="20px";

div.style.zIndex="9999";

div.innerHTML=`

<div class="toast show text-bg-${type} border-0">

<div class="d-flex">

<div class="toast-body">

${msg}

</div>

<button

class="btn-close btn-close-white me-2 m-auto"

data-bs-dismiss="toast">

</button>

</div>

</div>

`;

document.body.appendChild(div);

setTimeout(function(){

div.remove();

},3000);

}

</script>

</body>

</html>