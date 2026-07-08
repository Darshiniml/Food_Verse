<%@page language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="com.food_application.model.Order"%>
<%@page import="com.food_application.model.Restaurant"%>

<%
Restaurant restaurant =
(Restaurant)request.getAttribute("restaurant");

List<Order> orders =
(List<Order>)request.getAttribute("orders");
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Restaurant Orders</title>

<meta name="viewport"
content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>

body{

background:#F8FAFC;

font-family:Segoe UI;

}

.sidebar{

position:fixed;

left:0;

top:0;

width:250px;

height:100vh;

background:#1E293B;

padding:25px;

}

.sidebar h3{

color:white;

margin-bottom:40px;

}

.sidebar a{

display:block;

color:white;

padding:12px;

text-decoration:none;

border-radius:10px;

margin-bottom:10px;

}

.sidebar a:hover{

background:#334155;

}

.main{

margin-left:260px;

padding:30px;

}

.card-box{

background:white;

border-radius:15px;

padding:25px;

box-shadow:0 8px 18px rgba(0,0,0,.08);

}

.status{

padding:6px 15px;

border-radius:20px;

color:white;

font-weight:bold;

font-size:13px;

}

.pending{

background:#F59E0B;

}

.preparing{

background:#3B82F6;

}

.ready{

background:#22C55E;

}

</style>

</head>

<body>

<div class="sidebar">

<h3>

🍽 FoodVerse

</h3>

<a href="restaurantDashboard">

<i class="bi bi-speedometer2"></i>

Dashboard

</a>

<a href="restaurantOrders">

<i class="bi bi-box-seam"></i>

Orders

</a>

<a href="restaurantMenu">

<i class="bi bi-menu-button"></i>

Menu

</a>

<a href="logout">

<i class="bi bi-box-arrow-right"></i>

Logout

</a>

</div>

<div class="main">

<div class="d-flex
justify-content-between
align-items-center
mb-4">

<div>

<h2>

<%=restaurant.getRestaurantName()%>

Orders

</h2>

<p class="text-muted">

Manage incoming customer orders

</p>

</div>

</div>

<div class="row mb-4">

<div class="col-md-4">

<input

id="searchOrder"

class="form-control"

placeholder="Search Orders...">

</div>

</div>

<div class="card-box">

<table

class="table table-hover align-middle"

id="orderTable">

<thead>

<tr>

<th>Order</th>

<th>Customer</th>

<th>Amount</th>

<th>Address</th>

<th>Status</th>

<th width="230">

Action

</th>

</tr>

</thead>

<tbody>

<%

if(orders!=null){

for(Order order:orders){

%>

<tr>

<td>

#<%=order.getOrderId()%>

</td>

<td>

<b>

<%=order.getCustomerName()%>

</b>

</td>

<td>

₹ <%=order.getTotalAmount()%>

</td>

<td>

<%=order.getDeliveryAddress()%>

</td>

<td>
<%

String status = order.getStatus();

String css = "";

switch(status){

case "PENDING":
    css="pending";
    break;

case "PREPARING":
    css="preparing";
    break;

case "READY_FOR_PICKUP":
    css="ready";
    break;

default:
    css="pending";

}

%>

<span class="status <%=css%>">

<%=status%>

</span>

</td>

<td>

<form

action="<%=request.getContextPath()%>/updateRestaurantOrder"

method="post"

class="d-flex gap-2">

<input

type="hidden"

name="orderId"

value="<%=order.getOrderId()%>">

<select

name="status"

class="form-select form-select-sm">

<option
value="PENDING"
<%=status.equals("PENDING")?"selected":""%>>

PENDING

</option>

<option
value="PREPARING"
<%=status.equals("PREPARING")?"selected":""%>>

PREPARING

</option>

<option
value="READY_FOR_PICKUP"
<%=status.equals("READY_FOR_PICKUP")?"selected":""%>>

READY FOR PICKUP

</option>

</select>

<button

type="submit"

class="btn btn-success btn-sm">

<i class="bi bi-check-lg"></i>

</button>

</form>

<br>

<a

href="<%=request.getContextPath()%>/orderDetails?orderId=<%=order.getOrderId()%>"

class="btn btn-outline-primary btn-sm">

<i class="bi bi-eye-fill"></i>

View Details

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
<br>

<div class="row">

<div class="col-md-6">

<div class="card-box">

<h5>

Today's Summary

</h5>

<hr>

<p>

<i class="bi bi-clock-history text-warning"></i>

Pending Orders

</p>

<p>

<i class="bi bi-fire text-primary"></i>

Preparing Orders

</p>

<p>

<i class="bi bi-check-circle text-success"></i>

Ready For Pickup

</p>

</div>

</div>

<div class="col-md-6">

<div class="card-box">

<h5>

Quick Actions

</h5>

<hr>

<a

href="restaurantDashboard"

class="btn btn-primary w-100 mb-3">

<i class="bi bi-speedometer2"></i>

Dashboard

</a>

<a

href="restaurantMenu"

class="btn btn-success w-100">

<i class="bi bi-menu-button-wide"></i>

Manage Menu

</a>

</div>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

/*===========================
        SEARCH
===========================*/

document.getElementById("searchOrder")
.addEventListener("keyup",function(){

let value=this.value.toLowerCase();

let rows=document.querySelectorAll("#orderTable tbody tr");

rows.forEach(function(row){

let text=row.innerText.toLowerCase();

row.style.display=text.includes(value)
? ""
: "none";

});

});


/*===========================
        SUCCESS MESSAGE
===========================*/

const params=new URLSearchParams(window.location.search);

if(params.get("updated")){

showToast("Order Status Updated Successfully","success");

}

function showToast(message,type){

let toast=document.createElement("div");

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

</script>

</body>

</html>