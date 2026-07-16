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

<title>Available Orders</title>

<meta name="viewport"
content="width=device-width, initial-scale=1">

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
rel="stylesheet"
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

padding:6px 14px;

border-radius:20px;

background:#22C55E;

color:white;

font-size:13px;

font-weight:bold;

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

Available Orders

</h2>

<p class="text-muted">

Orders ready for pickup

</p>

<div class="row mb-4">

<div class="col-md-4">

<input

id="searchOrder"

class="form-control"

placeholder="Search Order...">

</div>

</div>

<div class="card-box">

<table

class="table table-hover align-middle"

id="orderTable">

<thead>

<tr>

<th>Order</th>

<th>Restaurant</th>

<th>Customer</th>

<th>Amount</th>

<th>Address</th>

<th>Status</th>

<th width="150">

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

<span class="status">

READY

</span>

</td>

<td>
<form
action="<%=request.getContextPath()%>/acceptDelivery"
method="post">

<input
type="hidden"
name="orderId"
value="<%=order.getOrderId()%>">

<button
type="submit"
class="btn btn-success btn-sm w-100">

<i class="bi bi-check-circle-fill"></i>

Accept Order

</button>

</form>

</td>

</tr>

<%

}

}else{

%>

<tr>

<td colspan="7" class="text-center py-5">

<i class="bi bi-box-seam"
style="font-size:70px;color:#CBD5E1;"></i>

<h4 class="mt-3">

No Orders Available

</h4>

<p class="text-muted">

There are currently no orders waiting for pickup.

</p>

<a
href="deliveryDashboard"
class="btn btn-primary">

Back to Dashboard

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

Pickup Instructions

</h5>

<hr>

<ul>

<li>

Reach the restaurant on time.

</li>

<li>

Verify the Order ID before collecting.

</li>

<li>

Check all food packets.

</li>

<li>

Collect the invoice if available.

</li>

<li>

Start delivery immediately.

</li>

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
href="myDeliveries"
class="btn btn-success w-100">

<i class="bi bi-truck"></i>

My Deliveries

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
        SEARCH ORDERS
==========================================*/

document.getElementById("searchOrder")
.addEventListener("keyup", function () {

    let value = this.value.toLowerCase();

    let rows = document.querySelectorAll("#orderTable tbody tr");

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

if (params.get("accepted")) {

    showToast("Order Accepted Successfully!", "success");

}

function showToast(message, type) {

    const toast = document.createElement("div");

    toast.style.position = "fixed";
    toast.style.top = "20px";
    toast.style.right = "20px";
    toast.style.zIndex = "9999";

    toast.innerHTML = `

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

// Refresh every 60 seconds

setTimeout(function(){

    location.reload();

},60000);

</script>

</body>

</html>
