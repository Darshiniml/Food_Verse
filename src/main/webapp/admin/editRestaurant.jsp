<<<<<<< HEAD
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
=======
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
<%@page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@page import="com.food_application.model.Restaurant"%>

<%
Restaurant restaurant =
(Restaurant)request.getAttribute("restaurant");
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Edit Restaurant</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet"
href="admin/css/admin.css">

<style>

.form-card{

background:white;

padding:35px;

border-radius:20px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

}

.preview{

width:180px;

height:180px;

border-radius:15px;

object-fit:cover;

border:3px solid #e2e8f0;

}

</style>

</head>

<body>

<%@include file="includes/sidebar.jsp"%>

<div class="main">

<%@include file="includes/navbar.jsp"%>

<div class="page">

<div class="container">

<div class="form-card">

<h2 class="mb-4">

<i class="bi bi-pencil-square"></i>

Edit Restaurant

</h2>

<form action="<%=request.getContextPath()%>/updateRestaurant"
method="post">

<input
type="hidden"
name="restaurantId"
value="<%=restaurant.getRestaurantId()%>">

<div class="row">

<div class="col-md-8">

<div class="mb-3">

<label class="form-label">

Restaurant Name

</label>

<input
type="text"
class="form-control"
name="restaurantName"
value="<%=restaurant.getRestaurantName()%>"
required>

</div>

<div class="mb-3">

<label class="form-label">

Cuisine Type

</label>

<input
type="text"
class="form-control"
name="cuisineType"
value="<%=restaurant.getCuisineType()%>"
required>

</div>

<div class="mb-3">

<label class="form-label">

Address

</label>

<textarea
class="form-control"
rows="3"
name="address"
required><%=restaurant.getAddress()%></textarea>

</div>

<div class="row">

<div class="col-md-6">

<label>

Rating

</label>

<input
type="number"
step="0.1"
min="0"
max="5"
class="form-control"
name="rating"
value="<%=restaurant.getRating()%>">

</div>

<div class="col-md-6">

<label>

Image URL

</label>

<input
type="text"
class="form-control"
id="imageInput"
name="image"
value="<%=restaurant.getImage()%>">

</div>

</div>

</div>

<div class="col-md-4 text-center">

<img

id="preview"

class="preview"

src="<%=restaurant.getImage()%>">

</div>

</div>

<hr>

<div class="text-end">

<a href="<%=request.getContextPath()%>/manageRestaurants"

class="btn btn-secondary">

Cancel

</a>

<button

class="btn btn-success">

<i class="bi bi-check-circle"></i>

Update Restaurant

</button>

</div>

</form>

</div>

</div>

</div>

</div>

<script>

document.getElementById("imageInput").addEventListener("keyup",function(){

document.getElementById("preview").src=this.value;

});

</script>

</body>

</html>