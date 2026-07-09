<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.food_application.model.Restaurant"%>
<%@ page import="com.food_application.model.User"%>

<%
List<Restaurant> restaurants =
(List<Restaurant>)request.getAttribute("restaurants");

User user=(User)session.getAttribute("loggedUser");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>FoodVerse - Home</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}

body{

background:#f6f7fb;

}

/* ================= NAVBAR ================= */

.navbar{

display:flex;
justify-content:space-between;
align-items:center;

padding:18px 60px;

background:white;

box-shadow:0 3px 10px rgba(0,0,0,.08);

position:sticky;

top:0;

z-index:999;

}

.logo{

font-size:30px;

font-weight:bold;

color:#ff7a00;

}

.nav-links{

display:flex;

align-items:center;

gap:18px;

}

.nav-links a{

text-decoration:none;

color:#333;

font-weight:600;

transition:.3s;

}

.nav-links a:hover{

color:#ff7a00;

}

.nav-btn{

background:#ff7a00;

padding:10px 18px;

border-radius:8px;

color:white!important;

}

.welcome{

font-weight:bold;

color:#444;

}

/* ================= HERO ================= */

.hero{

height:420px;

background:linear-gradient(135deg,#ff7a00,#ffb347);

display:flex;

justify-content:center;

align-items:center;

text-align:center;

color:white;

padding:20px;

}

.hero-content{

max-width:700px;

}

.hero h1{

font-size:50px;

margin-bottom:15px;

}

.hero p{

font-size:20px;

margin-bottom:30px;

}

.hero input{

width:100%;

padding:18px;

border:none;

border-radius:40px;

font-size:18px;

outline:none;

box-shadow:0 5px 15px rgba(0,0,0,.2);

}

/* ================= TITLE ================= */

.heading{

text-align:center;

margin:50px 0 20px;

font-size:38px;

color:#333;

}

/* ================= GRID ================= */

.container{

width:92%;

margin:auto;

display:grid;

grid-template-columns:repeat(auto-fill,minmax(320px,1fr));

gap:30px;

padding-bottom:50px;

}

/* ================= CARD ================= */

.card{

background:white;

border-radius:18px;

overflow:hidden;

box-shadow:0 8px 20px rgba(0,0,0,.12);

transition:.35s;

}

.card:hover{

transform:translateY(-8px);

}

.card img{

width:100%;

height:220px;

object-fit:cover;

}

.card-body{

padding:20px;

}

.card-body h2{

margin-bottom:12px;

color:#222;

}

.card-body p{

margin:10px 0;

color:#666;

}

.rating{

font-weight:bold;

color:#ff9800;

}

.btn{

width:100%;

margin-top:15px;

padding:12px;

background:#ff7a00;

border:none;

color:white;

font-size:16px;

border-radius:10px;

cursor:pointer;

transition:.3s;

}

.btn:hover{

background:#e56d00;

}

/* ================= FOOTER ================= */

footer{

background:#2c3e50;

color:white;

padding:40px;

text-align:center;

margin-top:40px;

}

footer h2{

margin-bottom:10px;

}

/* ================= MOBILE ================= */

@media(max-width:768px){

.navbar{

flex-direction:column;

gap:15px;

padding:20px;

}

.hero h1{

font-size:35px;

}

.hero input{

width:100%;

}

}

</style>

</head>

<body>

<!-- ================= NAVBAR ================= -->

<div class="navbar">

<div class="logo">

🍽 FoodVerse

</div>

<div class="nav-links">

<a href="home">Home</a>

<%

if(user==null){

%>

<a href="login.jsp">

Login

</a>

<a class="nav-btn" href="register.jsp">

Register

</a>

<%

}else{

%>

<a href="myOrders">

My Orders

</a>

<a href="cart.jsp">

Cart

</a>

<span class="welcome">

Welcome,

<%=user.getName()%>

</span>

<a class="nav-btn" href="logout">

Logout

</a>

<%

}

%>

</div>

</div>

<!-- ================= HERO ================= -->

<section class="hero">

<div class="hero-content">

<h1>

Delicious Food Delivered Fast 🍕

</h1>

<p>

Discover your favourite restaurants and order fresh meals anytime.

</p>

<input

type="text"

placeholder="🔍 Search Restaurants..."

id="searchBox"

onkeyup="searchRestaurant()"

>

</div>

</section>

<!-- ================= RESTAURANTS ================= -->

<h2 class="heading">

Popular Restaurants

</h2>

<div class="container">

<%

for(Restaurant restaurant:restaurants){

%>

<div class="card restaurant">

<img src="<%=restaurant.getImage()%>">

<div class="card-body">

<h2 class="restaurant-name">

<%=restaurant.getRestaurantName()%>

</h2>

<p>

🍽

<b>Cuisine :</b>

<%=restaurant.getCuisineType()%>

</p>

<p>

📍

<%=restaurant.getAddress()%>

</p>

<p class="rating">

⭐

<%=restaurant.getRating()%>

</p>

<a href="menu?restaurantId=<%=restaurant.getRestaurantId()%>">
    <button class="btn">
        Explore Restaurant
    </button>
</a>

</div>

</div>

<%

}

%>

</div>

<!-- ================= FOOTER ================= -->

<footer>

<h2>

🍽 FoodVerse

</h2>

<p>

Fresh Food • Fast Delivery • Great Taste

</p>

<br>

<p>

© 2026 FoodVerse. All Rights Reserved.

</p>

</footer>

<script>

function searchRestaurant(){

let input=document.getElementById("searchBox").value.toLowerCase();

let cards=document.getElementsByClassName("restaurant");

for(let i=0;i<cards.length;i++){

let name=cards[i]
.getElementsByClassName("restaurant-name")[0]
.innerText
.toLowerCase();

if(name.includes(input)){

cards[i].style.display="block";

}else{

cards[i].style.display="none";

}

}

}

</script>

</body>

</html>