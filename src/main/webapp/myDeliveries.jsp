<%@page language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="com.food_application.model.Order"%>

<%
List<Order> orders =
(List<Order>)request.getAttribute("orders");
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>My Deliveries</title>

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

background:#0F172A;

padding:25px;

}

.sidebar h3{

color:white;

margin-bottom:40px;

}

.sidebar a{

display:block;

color:white;

text-decoration:none;

padding:12px;

border-radius:10px;

margin-bottom:10px;

}

.sidebar a:hover{

background:#1E293B;

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

font-size:13px;

font-weight:bold;

}

.out{

background:#3B82F6;

}

.delivered{

background:#22C55E;

}

</style>

</head>

<body>

<div class="sidebar">

<h3>

🛵 FoodVerse

</h3>

<a href="deliveryDashboard">

<i class="bi bi-speedometer2"></i>

Dashboard

</a>

<a href="availableOrders">

<i class="bi bi-box-seam"></i>

Available Orders

</a>

<a href="myDeliveries">

<i class="bi bi-truck"></i>

My Deliveries

</a>

<a href="logout">

<i class="bi bi-box-arrow-right"></i>

Logout

</a>

</div>

<div class="main">

<h2>

My Deliveries

</h2>

<p class="text-muted">

Manage your assigned deliveries

</p>

<div class="row mb-4">

<div class="col-md-4">

<input

id="searchDelivery"

class="form-control"

placeholder="Search Deliveries...">

</div>

</div>

<div class="card-box">

<table

class="table table-hover align-middle"

id="deliveryTable">

<thead>

<tr>

<th>Order</th>

<th>Restaurant</th>

<th>Customer</th>

<th>Amount</th>

<th>Address</th>

<th>Status</th>

<th width="240">

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

<%=order.getRestaurantName()%>

</td>

<td>

<%=order.getCustomerName()%>

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

case "OUT_FOR_DELIVERY":

    css = "out";

    break;

case "DELIVERED":

    css = "delivered";

    break;

default:

    css = "out";

}

%>

<span class="status <%=css%>">

<%=status%>

</span>

</td>

<td>

<form

action="<%=request.getContextPath()%>/updateDeliveryStatus"

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
value="OUT_FOR_DELIVERY"
<%=status.equals("OUT_FOR_DELIVERY")?"selected":""%>>

OUT FOR DELIVERY

</option>

<option
value="DELIVERED"
<%=status.equals("DELIVERED")?"selected":""%>>

DELIVERED

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

}else{

%>

<tr>

<td colspan="7" class="text-center py-5">

<i class="bi bi-truck"
style="font-size:70px;color:#CBD5E1;"></i>

<h4 class="mt-3">

No Deliveries Assigned

</h4>

<p class="text-muted">

You don't have any assigned deliveries yet.

</p>

<a

href="availableOrders"

class="btn btn-primary">

View Available Orders

</a>

</td>

</tr>

<%

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

Delivery Guidelines

</h5>

<hr>

<ul>

<li>Verify the customer address before starting.</li>

<li>Keep the food package secure.</li>

<li>Contact the customer if needed.</li>

<li>Update the status only after successful delivery.</li>

<li>Always deliver on time.</li>

</ul>

</div>

</div>

<div class="col-md-6">

<div class="card-box">

<h5>

Quick Actions

</h5>

<hr>

<a

href="deliveryDashboard"

class="btn btn-primary w-100 mb-3">

<i class="bi bi-speedometer2"></i>

Dashboard

</a>

<a

href="availableOrders"

class="btn btn-success w-100">

<i class="bi bi-box-seam"></i>

Available Orders

</a>

</div>

</div>

</div>
<br>

<div class="text-center text-muted">

<hr>

<p>

FoodVerse Delivery Partner Portal

<br>

© 2026 All Rights Reserved

</p>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

/*==========================================
        SEARCH DELIVERIES
==========================================*/

document.getElementById("searchDelivery")
.addEventListener("keyup", function () {

    let value = this.value.toLowerCase();

    let rows = document.querySelectorAll("#deliveryTable tbody tr");

    rows.forEach(function (row) {

        let text = row.innerText.toLowerCase();

        row.style.display = text.includes(value)
            ? ""
            : "none";

    });

});


/*==========================================
        TOAST MESSAGE
==========================================*/

const params = new URLSearchParams(window.location.search);

if(params.get("updated")){

    showToast("Delivery Status Updated Successfully","success");

}

function showToast(message,type){

    const toast=document.createElement("div");

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


/*==========================================
        AUTO REFRESH
==========================================*/

setTimeout(function(){

    location.reload();

},60000);

</script>

</body>

</html>