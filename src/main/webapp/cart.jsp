<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>


<%@page import="com.food_application.model.Cart"%>
<%@page import="com.food_application.model.CartItem"%>
<%@page import="com.food_application.model.User"%>

<%
Cart cart=(Cart)session.getAttribute("cart");
User user=(User)session.getAttribute("loggedUser");

if(cart==null){
    cart=new Cart();
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>My Cart</title>

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
background:#f4f7fc;
}

/* Navbar */

.navbar{

background:white;

box-shadow:0 2px 12px rgba(0,0,0,.08);

}

.navbar-brand{

font-size:28px;

font-weight:700;

color:#4F46E5!important;

}

/* Heading */

.heading{

text-align:center;

padding:40px;

}

.heading h1{

font-weight:700;

color:#1e293b;

}

/* Cart Card */

.cart-card{

background:white;

border:none;

border-radius:20px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

margin-bottom:25px;

overflow:hidden;

}

.cart-card img{

height:170px;

width:100%;

object-fit:cover;

}

.price{

font-size:22px;

font-weight:bold;

color:#4F46E5;

}

.qty-btn{

width:40px;

height:40px;

border-radius:50%;

}

.summary{

background:white;

padding:30px;

border-radius:20px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

position:sticky;

top:100px;

}

.summary h3{

margin-bottom:20px;

}

.total{

font-size:28px;

font-weight:bold;

color:#16a34a;

}

.checkout{

width:100%;

margin-top:20px;

background:#4F46E5;

border:none;

padding:14px;

font-size:18px;

}

.checkout:hover{

background:#4338CA;

}

.empty{

text-align:center;

padding:100px;

}

footer{

margin-top:60px;

background:#1E293B;

color:white;

padding:25px;

text-align:center;

}

</style>

</head>

<body>

<!-- NAVBAR -->

<nav class="navbar navbar-expand-lg">

<div class="container">

<a class="navbar-brand"

href="home">

🍽 FoodVerse

</a>

<div>

<a class="btn btn-outline-primary me-2"

href="home">

<i class="bi bi-house"></i>

Home

</a>

<a class="btn btn-primary"

href="logout">

Logout

</a>

</div>

</div>

</nav>

<div class="container mt-5">

<h1 class="heading">

🛒 My Shopping Cart

</h1>

<%

if(cart.getItems().isEmpty()){

%>

<div class="empty">

<i class="bi bi-cart-x"

style="font-size:80px;color:gray;"></i>

<h2>

Your Cart is Empty

</h2>

<br>

<a href="home">

<button class="btn btn-primary">

Browse Restaurants

</button>

</a>

</div>

<%

}else{

%>

<div class="row">

<div class="col-lg-8">

<%

for(CartItem item:cart.getItems()){

%>

<div class="card cart-card">

<div class="row g-0">

<div class="col-md-4">

<img src="<%=item.getFoodItem().getImage()%>">

</div>

<div class="col-md-8">

<div class="card-body">

<h3>

<%=item.getFoodItem().getFoodName()%>

</h3>

<p class="text-muted">

<%=item.getFoodItem().getDescription()%>

</p>

<div class="price">

₹ <%=item.getFoodItem().getPrice()%>

</div>

<br>

<div class="d-flex align-items-center">

<a href="cart?action=decrease&foodId=<%=item.getFoodItem().getFoodId()%>">

<button class="btn btn-outline-danger qty-btn">

-

</button>

</a>

<span class="mx-3 fs-5">

<%=item.getQuantity()%>

</span>

<a href="cart?action=increase&foodId=<%=item.getFoodItem().getFoodId()%>">

<button class="btn btn-outline-success qty-btn">

+

</button>

</a>

<a class="ms-4"

href="cart?action=remove&foodId=<%=item.getFoodItem().getFoodId()%>">

<button class="btn btn-danger">

<i class="bi bi-trash"></i>

Remove

</button>

</a>

</div>

<br>

<h5>

Subtotal :

₹ <%=item.getTotalPrice()%>

</h5>

</div>

</div>

</div>

</div>

<%

}

%>

</div>

<!-- SUMMARY -->

<div class="col-lg-4">

<div class="summary">

<h3>

Order Summary

</h3>

<hr>

<p>

Items Total

<span class="float-end">

₹ <%=cart.getGrandTotal()%>

</span>

</p>

<p>

Delivery Fee

<span class="float-end text-success">

FREE

</span>

</p>

<p>

Platform Fee

<span class="float-end">

₹ 10

</span>

</p>

<p>

GST

<span class="float-end">

₹ <%=String.format("%.2f",cart.getGrandTotal()*0.05)%>

</span>

</p>

<hr>

<div class="total">

₹ <%=String.format("%.2f",
cart.getGrandTotal()+10+(cart.getGrandTotal()*0.05))%>

</div>

<a href="checkout.jsp">

<button class="btn checkout text-white">

Proceed To Checkout

</button>

</a>

</div>

</div>

</div>

<%

}

%>

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