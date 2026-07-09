
<%@page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="com.food_application.model.FoodItem"%>
<%@page import="com.food_application.model.Restaurant"%>

<%
List<FoodItem> foods =
(List<FoodItem>)request.getAttribute("foods");

List<Restaurant> restaurants =
(List<Restaurant>)request.getAttribute("restaurants");
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Food Management</title>

<meta name="viewport"
content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet"
href="css/admin.css">

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

.food-img{

width:70px;

height:70px;

border-radius:12px;

object-fit:cover;

}

.badge-available{

background:#22C55E;

}

.badge-unavailable{

background:#EF4444;

}

.search-box{

width:300px;

}

</style>

</head>

<body>



<div class="main">



<div class="page">

<div class="container-fluid">

<div class="d-flex
justify-content-between
align-items-center
mb-4">

<div>

<h2 class="page-title">

Food Management

</h2>

<p class="text-muted">

Manage all food items.

</p>

</div>

<button

class="btn btn-primary"

data-bs-toggle="modal"

data-bs-target="#addFoodModal">

<i class="bi bi-plus-circle-fill"></i>

Add Food

</button>

</div>

<div class="row mb-4">

<div class="col-md-4">

<input

type="text"

id="searchFood"

class="form-control search-box"

placeholder="Search Food...">

</div>

<div class="col-md-4">

<select

id="restaurantFilter"

class="form-select">

<option value="">

All Restaurants

</option>

<%

for(Restaurant r:restaurants){

%>

<option>

<%=r.getRestaurantName()%>

</option>

<%

}

%>

</select>

</div>

</div>

<div class="table-card">

<table

class="table table-hover align-middle"

id="foodTable">

<thead>

<tr>

<th>ID</th>

<th>Image</th>

<th>Food Name</th>

<th>Restaurant</th>

<th>Category</th>

<th>Price</th>

<th>Status</th>

<th width="180">

Action

</th>

</tr>

</thead>

<tbody>

<%

if(foods!=null){

for(FoodItem food:foods){

String restaurantName="";

for(Restaurant r:restaurants){

if(r.getRestaurantId()==food.getRestaurantId()){

restaurantName=r.getRestaurantName();

break;

}

}

%>

<tr>

<td>

<%=food.getFoodId()%>

</td>

<td>

<img

src="<%=food.getImage()%>"

class="food-img">

</td>

<td>

<b>

<%=food.getFoodName()%>

</b>

</td>

<td>

<%=restaurantName%>

</td>

<td>

<span class="badge bg-primary">

<%=food.getCategory()%>

</span>

</td>

<td>

&#8377;

<%=food.getPrice()%>

</td>

<td>

<%

if(food.isAvailable()){

%>

<span class="badge badge-available">

Available

</span>

<%

}else{

%>

<span class="badge badge-unavailable">

Unavailable

</span>

<%

}

%>

</td>

<td>

<a

href="<%=request.getContextPath()%>/editFood?id=<%=food.getFoodId()%>"

class="btn btn-warning btn-sm">

<i class="bi bi-pencil-fill"></i>

</a>

<a

href="<%=request.getContextPath()%>/deleteFood?id=<%=food.getFoodId()%>"

class="btn btn-danger btn-sm"

onclick="return confirm('Delete this food item?')">

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
<!-- ==========================================
            ADD FOOD MODAL
=========================================== -->

<div class="modal fade"
     id="addFoodModal"
     tabindex="-1">

<div class="modal-dialog modal-xl modal-dialog-centered">

<div class="modal-content">

<div class="modal-header">

<h4>

<i class="bi bi-egg-fried"></i>

Add New Food Item

</h4>

<button
type="button"
class="btn-close"
data-bs-dismiss="modal">
</button>

</div>

<form action="<%=request.getContextPath()%>/addFood"
      method="post">

<div class="modal-body">

<div class="row">

<!-- Left Side -->

<div class="col-md-8">

<div class="mb-3">

<label class="form-label">

Restaurant

</label>

<select

class="form-select"

name="restaurantId"

required>

<option value="">

Select Restaurant

</option>

<%

for(Restaurant r:restaurants){

%>

<option value="<%=r.getRestaurantId()%>">

<%=r.getRestaurantName()%>

</option>

<%

}

%>

</select>

</div>

<div class="mb-3">

<label class="form-label">

Food Name

</label>

<input

type="text"

class="form-control"

name="foodName"

placeholder="Enter Food Name"

required>

</div>

<div class="mb-3">

<label class="form-label">

Description

</label>

<textarea

class="form-control"

rows="3"

name="description"

placeholder="Food Description"

required>

</textarea>

</div>

<div class="row">

<div class="col-md-6">

<label class="form-label">

Category

</label>

<select

class="form-select"

name="category"

required>

<option>Starter</option>

<option>Main Course</option>

<option>Pizza</option>

<option>Burger</option>

<option>Chinese</option>

<option>South Indian</option>

<option>North Indian</option>

<option>Dessert</option>

<option>Beverage</option>

</select>

</div>

<div class="col-md-6">

<label class="form-label">

Price (₹)

</label>

<input

type="number"

step="0.01"

class="form-control"

name="price"

placeholder="299"

required>

</div>

</div>

<br>

<div class="mb-3">

<label class="form-label">

Image URL

</label>

<input

type="text"

class="form-control"

id="foodImage"

name="image"

placeholder="https://example.com/image.jpg"

required>

</div>

<div class="form-check form-switch mt-4">

<input

class="form-check-input"

type="checkbox"

name="available"

value="true"

checked>

<label class="form-check-label">

Available for Ordering

</label>

</div>

</div>

<!-- Right Side -->

<div class="col-md-4 text-center">

<label class="form-label">

Preview

</label>

<br>

<img

id="foodPreview"

src="https://placehold.co/250x220?text=Food"

style="width:230px;
height:220px;
object-fit:cover;
border-radius:15px;
border:2px dashed #CBD5E1;">

</div>

</div>

</div>

<div class="modal-footer">

<button

type="button"

class="btn btn-secondary"

data-bs-dismiss="modal">

Cancel

</button>

<button

type="submit"

class="btn btn-success">

<i class="bi bi-check-circle-fill"></i>

Save Food

</button>

</div>

</form>

</div>

</div>

</div>
<!-- ==========================================
        BOOTSTRAP JS
=========================================== -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

/* ==========================================
      FOOD SEARCH
========================================== */

document.getElementById("searchFood").addEventListener("keyup", function () {

    let value = this.value.toLowerCase();

    let rows = document.querySelectorAll("#foodTable tbody tr");

    rows.forEach(function (row) {

        let text = row.innerText.toLowerCase();

        row.style.display = text.includes(value) ? "" : "none";

    });

});


/* ==========================================
      RESTAURANT FILTER
========================================== */

document.getElementById("restaurantFilter").addEventListener("change", function () {

    let restaurant = this.value.toLowerCase();

    let rows = document.querySelectorAll("#foodTable tbody tr");

    rows.forEach(function (row) {

        if (restaurant === "") {

            row.style.display = "";

            return;

        }

        let restaurantName = row.cells[3].innerText.toLowerCase();

        row.style.display = restaurantName.includes(restaurant) ? "" : "none";

    });

});


/* ==========================================
      IMAGE PREVIEW
========================================== */

document.getElementById("foodImage").addEventListener("input", function () {

    let preview = document.getElementById("foodPreview");

    if (this.value.trim() === "") {

        preview.src = "https://placehold.co/250x220?text=Food";

    }

    else {

        preview.src = this.value;

    }

});


/* ==========================================
      TOAST MESSAGE
========================================== */

const params = new URLSearchParams(window.location.search);

if (params.get("success")) {

    showToast("Food Item Added Successfully", "success");

}

if (params.get("updated")) {

    showToast("Food Item Updated Successfully", "primary");

}

if (params.get("deleted")) {

    showToast("Food Item Deleted Successfully", "danger");

}

if (params.get("error")) {

    showToast("Something Went Wrong", "warning");

}

function showToast(message, type) {

    const toast = document.createElement("div");

    toast.style.position = "fixed";

    toast.style.top = "20px";

    toast.style.right = "20px";

    toast.style.zIndex = "9999";

    toast.innerHTML =

    `<div class="toast show text-bg-${type} border-0">

        <div class="d-flex">

            <div class="toast-body">

                ${message}

            </div>

            <button type="button"

            class="btn-close btn-close-white me-2 m-auto"

            data-bs-dismiss="toast">

            </button>

        </div>

    </div>`;

    document.body.appendChild(toast);

    setTimeout(function(){

        toast.remove();

    },3000);

}

</script>

</div>

</div>

</body>

</html>