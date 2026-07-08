<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<%@ page language="java" contentType="text/html;charset=UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.food_application.model.FoodItem"%>
<%@ page import="com.food_application.model.User"%>

<%
List<FoodItem> foods=(List<FoodItem>)request.getAttribute("foods");
User user=(User)session.getAttribute("loggedUser");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Food Menu</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<style>

*{
font-family:'Poppins',sans-serif;
}

body{

background:#eef2ff;

}

/* ---------- Navbar ---------- */

.navbar{

background:white;

box-shadow:0 2px 10px rgba(0,0,0,.08);

}

.navbar-brand{

font-weight:700;

font-size:28px;

color:#4F46E5!important;

}

/* ---------- Header ---------- */

.header{

text-align:center;

padding:45px;

margin-bottom:20px;

}

.header h1{

font-weight:700;

color:#1E293B;

}

.header p{

color:#64748B;

}

/* ---------- Food Card ---------- */

.food-card{

border:none;

border-radius:20px;

overflow:hidden;

transition:.3s;

box-shadow:0 6px 20px rgba(0,0,0,.08);

height:100%;

}

.food-card:hover{

transform:translateY(-8px);

}

.food-card img{

height:220px;

object-fit:cover;

}

.price{

font-size:24px;

font-weight:bold;

color:#4F46E5;

}

.category{

background:#dbeafe;

color:#2563eb;

padding:5px 12px;

border-radius:30px;

font-size:13px;

display:inline-block;

margin-bottom:10px;

}

.available{

color:#16a34a;

font-weight:600;

}

.notavailable{

color:#dc2626;

font-weight:600;

}

.btn-cart{

background:#4F46E5;

color:white;

width:100%;

border-radius:10px;

}

.btn-cart:hover{

background:#4338ca;

color:white;

}

footer{

margin-top:60px;

background:#1E293B;

color:white;

padding:30px;

text-align:center;

}

</style>

</head>

<body>

<!-- NAVBAR -->

<nav class="navbar navbar-expand-lg">

<div class="container">

<a class="navbar-brand" href="home">

🍽 FoodVerse

</a>

<div>

<a class="btn btn-outline-primary me-2"

href="home">

<i class="bi bi-house"></i>

Home

</a>

<a class="btn btn-outline-primary me-2"

href="cart.jsp">

<i class="bi bi-cart3"></i>

Cart

</a>

<%

if(user!=null){

%>

<span class="me-3">

<i class="bi bi-person-circle"></i>

<%=user.getName()%>

</span>

<a class="btn btn-primary"

href="logout">

Logout

</a>

<%

}else{

%>

<a class="btn btn-primary"

href="login.jsp">

Login

</a>

<%

}

%>

</div>

</div>

</nav>

<!-- HEADER -->

<div class="header">

<h1>

Our Delicious Menu 🍴

</h1>

<p>

Choose your favourite meal and enjoy every bite.

</p>

</div>

<!-- FOOD GRID -->

<div class="container">

<div class="row g-4">

<%

for(FoodItem food:foods){

%>

<div class="col-lg-4 col-md-6">

<div class="card food-card">

<img src="<%=food.getImage()%>"

class="card-img-top">

<div class="card-body">

<span class="category">

<%=food.getCategory()%>

</span>

<h4>

<%=food.getFoodName()%>

</h4>

<p class="text-muted">

<%=food.getDescription()%>

</p>

<div class="price">

₹ <%=food.getPrice()%>

</div>

<br>

<%

if(food.isAvailable()){

%>

<div class="available">

<i class="bi bi-check-circle-fill"></i>

Available

</div>

<br>

<a href="cart?action=add&foodId=<%=food.getFoodId()%>">

<button class="btn btn-cart">

<i class="bi bi-cart-plus-fill"></i>

Add To Cart

</button>

</a>

<%

}else{

%>

<div class="notavailable">

<i class="bi bi-x-circle-fill"></i>

Out Of Stock

</div>

<%

}

%>

</div>

</div>

</div>

<%

}

%>

</div>

</div>

<footer>

<h4>

FoodVerse

</h4>

<p>

Fresh Food • Better Taste • Faster Delivery

</p>

</footer>

</body>

</html>