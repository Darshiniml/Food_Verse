<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@page import="com.food_application.model.Cart"%>
<%@page import="com.food_application.model.CartItem"%>

<%
Cart cart=(Cart)session.getAttribute("cart");

if(cart==null || cart.getItems().isEmpty()){

response.sendRedirect("cart.jsp");
return;

}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Checkout | FoodVerse</title>

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

/* Cards */

.checkout-card{

background:white;

border:none;

border-radius:20px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

padding:30px;

margin-bottom:30px;

}

.summary{

background:white;

padding:30px;

border-radius:20px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

position:sticky;

top:100px;

}

.summary h4{

margin-bottom:20px;

}

.total{

font-size:30px;

font-weight:bold;

color:#16a34a;

}

.place-btn{

width:100%;

margin-top:20px;

padding:15px;

background:#4F46E5;

border:none;

font-size:18px;

border-radius:12px;

}

.place-btn:hover{

background:#4338CA;

}

.payment-card{

border:2px solid #dee2e6;

padding:15px;

border-radius:12px;

cursor:pointer;

transition:.3s;

}

.payment-card:hover{

border-color:#4F46E5;

background:#eef2ff;

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

<a href="cart.jsp"

class="btn btn-outline-primary">

Back to Cart

</a>

</div>

</div>

</nav>

<div class="container mt-5">

<div class="row">

<!-- LEFT -->

<div class="col-lg-8">

<form action="payment" method="post">

<div class="checkout-card">

<h3>

<i class="bi bi-person-fill"></i>

Customer Details

</h3>

<hr>

<div class="mb-3">

<label>Name</label>

<input
type="text"
name="name"
class="form-control"
required>

</div>

<div class="mb-3">

<label>Phone</label>

<input
type="text"
name="phone"
class="form-control"
required>

</div>

<div class="mb-3">

<label>Delivery Address</label>

<textarea
name="address"
rows="4"
class="form-control"
required></textarea>

</div>

</div>

<div class="checkout-card">

<h3>

<i class="bi bi-credit-card-fill"></i>

Payment Method

</h3>

<hr>

<div class="payment-card mb-3">

<input type="radio"

name="paymentMethod"

value="UPI"

checked>

UPI

</div>

<div class="payment-card mb-3">

<input type="radio"

name="paymentMethod"

value="Credit Card">

Credit Card

</div>

<div class="payment-card mb-3">

<input type="radio"

name="paymentMethod"

value="Debit Card">

Debit Card

</div>

<div class="payment-card">

<input type="radio"

name="paymentMethod"

value="Cash On Delivery">

Cash On Delivery

</div>

</div>

</div>

<!-- RIGHT -->

<div class="col-lg-4">

<div class="summary">

<h4>

<i class="bi bi-bag-check-fill"></i>

Order Summary

</h4>

<hr>

<%

for(CartItem item:cart.getItems()){

%>

<div class="d-flex justify-content-between mb-2">

<span>

<%=item.getFoodItem().getFoodName()%>

x

<%=item.getQuantity()%>

</span>

<span>

₹

<%=item.getTotalPrice()%>

</span>

</div>

<%

}

%>

<hr>

<p>

Items Total

<span class="float-end">

₹ <%=cart.getGrandTotal()%>

</span>

</p>

<p>

Delivery

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

₹ <%=String.format("%.2f",
cart.getGrandTotal()*0.05)%>

</span>

</p>

<hr>

<div class="total">

₹ <%=String.format("%.2f",
cart.getGrandTotal()+10+(cart.getGrandTotal()*0.05))%>

</div>

<button

type="submit"

class="btn place-btn text-white">

<i class="bi bi-check-circle-fill"></i>

Place Order

</button>

</div>

</div>

</form>

</div>

</div>

</body>

</html>