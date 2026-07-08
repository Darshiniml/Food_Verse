<<<<<<< HEAD
<%@page language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>

=======
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
<%@page import="java.util.List"%>
<%@page import="com.food_application.model.Restaurant"%>

<%
List<Restaurant> restaurants =
(List<Restaurant>)request.getAttribute("restaurants");
<<<<<<< HEAD
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Manage Restaurants</title>

<meta name="viewport"
content="width=device-width, initial-scale=1">

<link rel="preconnect"
href="https://fonts.googleapis.com">

<link rel="preconnect"
href="https://fonts.gstatic.com"
crossorigin>

<link
href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link
rel="stylesheet"
href="<%=request.getContextPath()%>/admin/css/admin.css">

<style>

.restaurant-img{

width:70px;

height:70px;

object-fit:cover;

border-radius:12px;

}

.rating{

font-weight:bold;

color:#F59E0B;

}

.table td{

vertical-align:middle;

}

</style>

</head>

<body>

<%@include file="admin/includes/sidebar.jsp"%>

<div class="main">

<%@include file="admin/includes/navbar.jsp"%>

<div class="content">

<div class="d-flex
justify-content-between
align-items-center
mb-4">

<div>

<h2>

🍽 Restaurant Management

</h2>

<p class="text-muted">

Manage all partner restaurants.

</p>

</div>

<a
href="<%=request.getContextPath()%>/admin/addRestaurant.jsp">

<i class="bi bi-plus-circle-fill"></i>

Add Restaurant

</a>

</div>

<div class="card-box">

<div class="row mb-4">

<div class="col-md-4">

<input

id="searchRestaurant"

class="form-control"

placeholder="Search Restaurant...">

</div>

</div>

<table
class="table table-hover align-middle"
id="restaurantTable">

<thead class="table-dark">

<tr>

<th>ID</th>

<th>Image</th>

<th>Name</th>

<th>Cuisine</th>

<th>Rating</th>

<th>Address</th>

<th width="220">

Action

</th>

</tr>

</thead>

<tbody>

<%

if(restaurants!=null){

for(Restaurant restaurant:restaurants){

%>

<tr>

<td>

#<%=restaurant.getRestaurantId()%>

</td>

<td>

<img
class="restaurant-img"
src="<%=restaurant.getImage()%>">

</td>

<td>

<b>

<%=restaurant.getRestaurantName()%>

</b>

</td>

<td>

<%=restaurant.getCuisineType()%>

</td>

<td>

<span class="rating">

⭐ <%=restaurant.getRating()%>

</span>

</td>

<td>

<%=restaurant.getAddress()%>

</td>

<td>
<a
href="<%=request.getContextPath()%>/editRestaurant?id=<%=restaurant.getRestaurantId()%>"
class="btn btn-primary btn-sm">

<i class="bi bi-pencil-square"></i>

Edit

</a>

<a
href="<%=request.getContextPath()%>/manageRestaurants?action=delete&id=<%=restaurant.getRestaurantId()%>"
class="btn btn-danger btn-sm"
onclick="return confirm('Are you sure you want to delete this restaurant?');">

<i class="bi bi-trash-fill"></i>

Delete

</a>

</td>

</tr>

<%

}

}else{

%>

<tr>

<td colspan="7" class="text-center py-5">

<i
class="bi bi-shop"
style="font-size:70px;color:#CBD5E1;"></i>

<h4 class="mt-3">

No Restaurants Found

</h4>

<p class="text-muted">

There are no restaurants available.

</p>

<a
href="addRestaurant.jsp"
class="btn btn-orange">

Add Restaurant

</a>

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

<div class="col-md-4">

<div class="card-box text-center">

<h6>

Total Restaurants

</h6>

<h2 class="text-primary">

<%=restaurants!=null ? restaurants.size() : 0%>

</h2>

<p class="text-muted">

Registered Restaurants

</p>

</div>

</div>

<div class="col-md-4">

<div class="card-box text-center">

<h6>

Average Rating

</h6>

<%

double avg=0;

if(restaurants!=null && restaurants.size()>0){

for(Restaurant r:restaurants){

avg+=r.getRating();

}

avg/=restaurants.size();

}

%>

<h2 class="text-warning">

⭐ <%=String.format("%.1f",avg)%>

</h2>

<p class="text-muted">

Overall Rating

</p>

</div>

</div>

<div class="col-md-4">

<div class="card-box text-center">

<h6>

Quick Action

</h6>

<a

href="addRestaurant.jsp"

class="btn btn-success mt-2">

<i class="bi bi-plus-circle-fill"></i>

Add New Restaurant

</a>

</div>

</div>

</div>

<br>

<div class="card-box">

<h4>

Restaurant Guidelines

</h4>

<hr>

<ul>

<li>

✔ Restaurant Name should be unique.

</li>

<li>

✔ Cuisine Type should be specified correctly.

</li>

<li>

✔ Restaurant image should be a valid image URL.

</li>

<li>

✔ Maintain accurate address information.

</li>

<li>

✔ Ratings are calculated automatically based on customer reviews.

</li>

</ul>

</div>

<br>

<div class="text-center text-muted">

<hr>

<p>

FoodVerse Admin Portal

<br>

© 2026 All Rights Reserved

</p>

</div>

</div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

/*=========================================
        SEARCH RESTAURANT
=========================================*/

document.getElementById("searchRestaurant")
.addEventListener("keyup",function(){

    let value=this.value.toLowerCase();

    let rows=document.querySelectorAll("#restaurantTable tbody tr");

    rows.forEach(function(row){

        let text=row.innerText.toLowerCase();

        row.style.display=text.includes(value)
        ? ""
        : "none";

    });

});


/*=========================================
        SUCCESS TOAST
=========================================*/

const params=new URLSearchParams(window.location.search);

if(params.get("added")){

    showToast("Restaurant Added Successfully","success");

}

if(params.get("updated")){

    showToast("Restaurant Updated Successfully","primary");

}

if(params.get("deleted")){

    showToast("Restaurant Deleted Successfully","danger");

}


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


/*=========================================
      DELETE CONFIRMATION
=========================================*/

document.querySelectorAll(".btn-danger").forEach(function(btn){

    btn.addEventListener("click",function(e){

        if(!confirm("Are you sure you want to delete this restaurant?")){

            e.preventDefault();

        }

    });

});


/*=========================================
      TABLE ROW HOVER EFFECT
=========================================*/

document.querySelectorAll("#restaurantTable tbody tr")
.forEach(function(row){

    row.addEventListener("mouseenter",function(){

        row.style.transition=".25s";

    });

});


/*=========================================
      AUTO REFRESH (Optional)
=========================================*/

// Uncomment if you want auto refresh

// setTimeout(function(){

//     location.reload();

// },60000);

</script>

</body>

</html>
=======
%>
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
