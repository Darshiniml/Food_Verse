
<%@page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="com.food_application.model.Restaurant"%>



<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Restaurant Management</title>

<meta name="viewport"
content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet"
href="admin/css/admin.css">

<style>

.page-title{

font-size:32px;

font-weight:700;

color:#0F172A;

}

.table-card{

background:white;

padding:25px;

border-radius:20px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

}

.restaurant-img{

width:75px;

height:75px;

border-radius:12px;

object-fit:cover;

}

.table th{

background:#EEF2FF;

}

.btn-primary{

background:#4F46E5;

border:none;

}

.btn-primary:hover{

background:#4338CA;

}

.search-box{

width:320px;

}

</style>

</head>

<body>

<%@include file="includes/sidebar.jsp"%>

<div class="main">

<%@include file="includes/navbar.jsp"%>

<div class="page">

<div class="container-fluid">

<div class="d-flex
justify-content-between
align-items-center
mb-4">

<div>

<h2 class="page-title">

Restaurant Management

</h2>

<p class="text-muted">

Manage all restaurants from one place.

</p>

</div>

<button

class="btn btn-primary"

data-bs-toggle="modal"

data-bs-target="#addRestaurantModal">

<i class="bi bi-plus-circle-fill"></i>

Add Restaurant

</button>

</div>

<div class="row mb-4">

<div class="col-md-4">

<input

type="text"

id="searchRestaurant"

class="form-control search-box"

placeholder="Search Restaurant...">

</div>

</div>

<div class="table-card">

<table

class="table table-hover align-middle"

id="restaurantTable">

<thead>

<tr>

<th>ID</th>

<th>Image</th>

<th>Name</th>

<th>Cuisine</th>

<th>Address</th>

<th>Rating</th>

<th width="170">

Action

</th>

</tr>

</thead>

<tbody>

<%

if(restaurants!=null){

for(Restaurant r:restaurants){

%>

<tr>

<td>

<%=r.getRestaurantId()%>

</td>

<td>

<img

src="<%=r.getImage()%>"

class="restaurant-img">

</td>

<td>

<b>

<%=r.getRestaurantName()%>

</b>

</td>

<td>

<%=r.getCuisineType()%>

</td>

<td>

<%=r.getAddress()%>

</td>

<td>

⭐

<%=r.getRating()%>

</td>

<td>

<a

href="<%=request.getContextPath()%>/editRestaurant?id=<%=r.getRestaurantId()%>"

class="btn btn-warning btn-sm">

<i class="bi bi-pencil-fill"></i>

</a>

<a

href="<%=request.getContextPath()%>/deleteRestaurant?id=<%=r.getRestaurantId()%>"

class="btn btn-danger btn-sm"

onclick="return confirm('Delete this restaurant?')">

<i class="bi bi-trash-fill"></i>

</a>

</td>

</tr>

<%

}

}

%>

</tbody>

</table>

</div>
<!-- ==========================
     JAVASCRIPT
=========================== -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

// ===============================
// Live Restaurant Search
// ===============================

const searchInput = document.getElementById("searchRestaurant");

if(searchInput){

searchInput.addEventListener("keyup",function(){

let value = this.value.toLowerCase();

let rows = document.querySelectorAll("#restaurantTable tbody tr");

rows.forEach(function(row){

let text = row.innerText.toLowerCase();

row.style.display = text.includes(value) ? "" : "none";

});

});

}


// ===============================
// Image Preview
// ===============================

const imageURL = document.getElementById("imageURL");

if(imageURL){

imageURL.addEventListener("input",function(){

let preview =
document.getElementById("imagePreview");

if(this.value.trim()!=""){

preview.src=this.value;

}else{

preview.src="https://placehold.co/250x200?text=Restaurant";

}

});

}


// ===============================
// Success / Error Toast
// ===============================

const params =
new URLSearchParams(window.location.search);

if(params.get("success")){

showToast("Restaurant Added Successfully","success");

}

if(params.get("updated")){

showToast("Restaurant Updated Successfully","success");

}

if(params.get("deleted")){

showToast("Restaurant Deleted Successfully","danger");

}

if(params.get("error")){

showToast("Something Went Wrong","warning");

}


function showToast(message,type){

const toastContainer=document.createElement("div");

toastContainer.style.position="fixed";

toastContainer.style.top="20px";

toastContainer.style.right="20px";

toastContainer.style.zIndex="9999";

toastContainer.innerHTML=`

<div class="toast show align-items-center text-bg-${type} border-0">

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

document.body.appendChild(toastContainer);

setTimeout(()=>{

toastContainer.remove();

},3000);

}

</script>

</div>

</div>

</body>

</html>