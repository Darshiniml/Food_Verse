<%@page language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Add Restaurant</title>

<meta name="viewport"
content="width=device-width, initial-scale=1">

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

.form-card{

background:white;

padding:35px;

border-radius:18px;

box-shadow:0 8px 18px rgba(0,0,0,.08);

}

.preview{

width:180px;

height:180px;

border-radius:15px;

object-fit:cover;

border:2px dashed #CBD5E1;

padding:5px;

}

</style>

</head>

<body>



<div class="main">


<div class="content">

<div class="d-flex justify-content-between align-items-center mb-4">

<div>

<h2>

🍽 Add Restaurant

</h2>

<p class="text-muted">

Register a new restaurant partner.

</p>

</div>

<a

href="<%=request.getContextPath()%>/manageRestaurants"

class="btn btn-secondary">

<i class="bi bi-arrow-left"></i>

Back

</a>

</div>

<div class="row">

<div class="col-lg-8">

<div class="form-card">

<form

action="<%=request.getContextPath()%>/addRestaurant"

method="post">

<div class="mb-3">

<label class="form-label">

Restaurant Name

</label>

<input

type="text"

name="restaurantName"

class="form-control"

required>

</div>

<div class="mb-3">

<label class="form-label">

Cuisine Type

</label>

<select

name="cuisineType"

class="form-select"

required>

<option value="">

Select Cuisine

</option>

<option>Indian</option>

<option>Chinese</option>

<option>Italian</option>

<option>South Indian</option>

<option>North Indian</option>

<option>Fast Food</option>

<option>Bakery</option>

<option>Desserts</option>

<option>Multi Cuisine</option>

</select>

</div>

<div class="mb-3">

<label class="form-label">

Restaurant Address

</label>

<textarea

name="address"

rows="3"

class="form-control"

required>

</textarea>

</div>

<div class="row">

<div class="col-md-6">

<div class="mb-3">

<label class="form-label">

Rating

</label>

<input

type="number"

step="0.1"

min="0"

max="5"

value="4.5"

name="rating"

class="form-control"

required>

</div>

</div>

<div class="col-md-6">

<div class="mb-3">

<label class="form-label">

Image URL

</label>

<input

type="text"

id="image"

name="image"

class="form-control"

placeholder="https://..."

onkeyup="previewImage()">

</div>

</div>

</div>

<button

class="btn btn-success">

<i class="bi bi-check-circle-fill"></i>

Save Restaurant

</button>

<button

type="reset"

class="btn btn-outline-secondary ms-2">

Reset

</button>

</form>

</div>

</div>

<div class="col-lg-4">

<div class="form-card text-center">

<h5>

Image Preview

</h5>

<hr>

<img

id="preview"

class="preview"

src="https://via.placeholder.com/180?text=Restaurant">

<br><br>

<p class="text-muted">

Paste an image URL to preview it.

</p>

</div>

<br>

<div class="form-card">

<h5>

Guidelines

</h5>

<hr>

<ul>

<li>Restaurant name must be unique.</li>

<li>Provide a valid image URL.</li>

<li>Rating should be between 0 and 5.</li>

<li>Address should be complete.</li>

<li>Select the correct cuisine type.</li>

</ul>

</div>

</div>

</div>

</div>

</div>

<script
src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

<script>

function previewImage(){

let url=document.getElementById("image").value;

if(url.trim()!=""){

document.getElementById("preview").src=url;

}

}

const params=new URLSearchParams(window.location.search);

if(params.get("error")){

alert("Unable to add restaurant.");

}

</script>

</body>

</html>