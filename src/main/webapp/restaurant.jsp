<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="com.food_application.model.Restaurant"%>
<%@ page import="com.food_application.model.User"%>

<%
Restaurant restaurant=(Restaurant)request.getAttribute("restaurant");
User user=(User)session.getAttribute("loggedUser");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title><%=restaurant.getRestaurantName()%></title>

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

background:#f5f6fa;

}

/* NAVBAR */

.navbar{

display:flex;
justify-content:space-between;
align-items:center;

padding:18px 60px;

background:white;

box-shadow:0 3px 10px rgba(0,0,0,.08);

}

.logo{

font-size:30px;

font-weight:bold;

color:#ff7a00;

}

.nav-links{

display:flex;

gap:20px;

align-items:center;

}

.nav-links a{

text-decoration:none;

font-weight:600;

color:#333;

transition:.3s;

}

.nav-links a:hover{

color:#ff7a00;

}

.logout{

background:#ff7a00;

padding:10px 18px;

border-radius:8px;

color:white!important;

}

/* BANNER */

.banner{

width:90%;

height:380px;

margin:35px auto;

border-radius:20px;

overflow:hidden;

box-shadow:0 8px 20px rgba(0,0,0,.15);

}

.banner img{

width:100%;

height:100%;

object-fit:cover;

}

/* DETAILS */

.details{

width:90%;

margin:auto;

background:white;

padding:35px;

border-radius:20px;

box-shadow:0 8px 20px rgba(0,0,0,.12);

margin-bottom:40px;

}

.name{

font-size:42px;

font-weight:bold;

color:#333;

}

.info{

margin-top:20px;

display:grid;

grid-template-columns:repeat(2,1fr);

gap:20px;

}

.box{

background:#fafafa;

padding:20px;

border-radius:15px;

border-left:5px solid #ff7a00;

}

.box h3{

color:#ff7a00;

margin-bottom:10px;

}

.rating{

font-size:24px;

color:#f39c12;

font-weight:bold;

}

.status{

display:inline-block;

margin-top:20px;

padding:8px 18px;

background:#28a745;

color:white;

border-radius:25px;

font-weight:600;

}

.menu-btn{

margin-top:30px;

padding:15px 40px;

border:none;

border-radius:12px;

background:#ff7a00;

color:white;

font-size:18px;

cursor:pointer;

transition:.3s;

}

.menu-btn:hover{

background:#e66b00;

transform:translateY(-3px);

}

footer{

margin-top:50px;

background:#2c3e50;

color:white;

text-align:center;

padding:30px;

}

@media(max-width:768px){

.info{

grid-template-columns:1fr;

}

.banner{

height:250px;

}

.name{

font-size:30px;

}

.navbar{

flex-direction:column;

gap:15px;

}

}

</style>

</head>

<body>

<!-- NAVBAR -->

<div class="navbar">

<div class="logo">

🍽 FoodVerse

</div>

<div class="nav-links">

<a href="home">Home</a>

<a href="myOrders">My Orders</a>

<a href="cart.jsp">Cart</a>

<%

if(user!=null){

%>

<span>

Welcome,

<b><%=user.getName()%></b>

</span>

<a href="logout" class="logout">

Logout

</a>

<%

}else{

%>

<a href="login.jsp">

Login

</a>

<a href="register.jsp" class="logout">

Register

</a>

<%

}

%>

</div>

</div>

<!-- BANNER -->

<div class="banner">

<img src="<%=restaurant.getImage()%>">

</div>

<!-- DETAILS -->

<div class="details">

<div class="name">

<%=restaurant.getRestaurantName()%>

</div>

<div class="status">

🟢 Open Now

</div>

<div class="info">

<div class="box">

<h3>

🍴 Cuisine

</h3>

<p>

<%=restaurant.getCuisineType()%>

</p>

</div>

<div class="box">

<h3>

📍 Address

</h3>

<p>

<%=restaurant.getAddress()%>

</p>

</div>

<div class="box">

<h3>

⭐ Rating

</h3>

<div class="rating">

<%=restaurant.getRating()%> / 5

</div>

</div>

<div class="box">

<h3>

🚚 Delivery

</h3>

<p>

25 - 35 Minutes

</p>

</div>

</div>

<a href="menu?restaurantId=<%=restaurant.getRestaurantId()%>">

<button class="menu-btn">

🍕 View Menu

</button>

</a>

</div>

<footer>

<h2>

🍽 FoodVerse

</h2>

<p>

Fresh Food • Fast Delivery • Great Taste

</p>

<br>

<p>

© 2026 FoodVerse

</p>

</footer>

</body>

</html>