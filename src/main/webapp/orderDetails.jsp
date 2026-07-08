<%@page language="java" contentType="text/html;charset=UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.food_application.model.Order"%>
<%@page import="com.food_application.model.OrderItem"%>

<%
Order order=(Order)request.getAttribute("order");

List<OrderItem> items=
(List<OrderItem>)request.getAttribute("items");

SimpleDateFormat sdf=
new SimpleDateFormat("dd MMM yyyy hh:mm a");
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Order Details</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

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

.card-box{

background:white;

border-radius:20px;

padding:30px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

margin-top:40px;

}

.item-card{

border-radius:15px;

padding:15px;

background:#f8fafc;

margin-bottom:15px;

}

.status{

padding:8px 20px;

border-radius:25px;

background:#dbeafe;

color:#1d4ed8;

font-weight:600;

display:inline-block;

}

.total{

font-size:28px;

font-weight:bold;

color:#16a34a;

}

</style>

</head>

<body>

<div class="container">

<div class="card-box">

<h2>

<i class="bi bi-receipt-cutoff"></i>

Order Details

</h2>

<hr>

<div class="row">

<div class="col-md-6">

<h5>

Order ID

</h5>

<p>

#<%=order.getOrderId()%>

</p>

</div>

<div class="col-md-6">

<h5>

Order Date

</h5>

<p>

<%=sdf.format(order.getOrderDate())%>

</p>

</div>

<div class="col-md-6">

<h5>

Delivery Address

</h5>

<p>

<%=order.getDeliveryAddress()%>

</p>

</div>

<div class="col-md-6">

<h5>

Status

</h5>

<span class="status">

<%=order.getStatus()%>

</span>

</div>

</div>

<hr>

<h4>

Ordered Items

</h4>

<br>

<%

for(OrderItem item:items){

%>

<div class="item-card">

<div class="row align-items-center">

<div class="col-md-6">

<h5>

<%=item.getFoodItem().getFoodName()%>

</h5>

<small>

Category :

<%=item.getFoodItem().getCategory()%>

</small>

</div>

<div class="col-md-2">

Qty

<br>

<b>

<%=item.getQuantity()%>

</b>

</div>

<div class="col-md-2">

Price

<br>

₹

<%=item.getFoodItem().getPrice()%>

</div>

<div class="col-md-2">

Subtotal

<br>

₹

<%=item.getSubtotal()%>

</div>

</div>

</div>

<%

}

%>

<hr>

<div class="text-end">

<h3>

Grand Total

</h3>

<div class="total">

₹

<%=order.getTotalAmount()%>

</div>

</div>

<br>

<a href="myOrders"

class="btn btn-primary">

<i class="bi bi-arrow-left"></i>

Back To Orders

</a>

</div>

</div>

</body>

</html>