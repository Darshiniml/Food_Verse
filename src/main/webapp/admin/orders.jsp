<%@ page contentType="text/html;charset=UTF-8" language="java"%>

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

<title>Order Management</title>

<meta name="viewport"
content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet"
href="css/admin.css">

<style>

.page-title{

font-size:32px;

font-weight:700;

}

.table-card{

background:white;

padding:25px;

border-radius:18px;

box-shadow:0 8px 20px rgba(0,0,0,.08);

}

.status{

padding:8px 15px;

border-radius:20px;

font-size:13px;

font-weight:bold;

color:white;

}

.PLACED{

background:#F59E0B;

}

.preparing{

background:#3B82F6;

}

.ready{

background:#8B5CF6;

}

.out{

background:#EC4899;

}

.delivered{

background:#22C55E;

}

.cancelled{

background:#EF4444;

}

</style>

</head>

<body>



<div class="main">



<div class="page">

<div class="container-fluid">

<div class="d-flex
justify-content-between
align-items-center
mb-4">

<div>

<h2 class="page-title">

Order Management

</h2>

<p class="text-muted">

Track and manage customer orders.

</p>

</div>

</div>

<div class="row mb-4">

<div class="col-md-4">

<input

id="searchOrder"

type="text"

class="form-control"

placeholder="Search Order...">

</div>

<div class="col-md-3">

<select

id="statusFilter"

class="form-select">

<option value="">

All Status

</option>

<option>PLACED</option>

<option>PREPARING</option>

<option>READY</option>

<option>OUT_FOR_DELIVERY</option>

<option>DELIVERED</option>

<option>CANCELLED</option>

</select>

</div>

</div>

<div class="table-card">

<table

class="table table-hover align-middle"

id="orderTable">

<thead>

<tr>

<th>ID</th>

<th>Customer</th>

<th>Restaurant</th>

<th>Date</th>

<th>Amount</th>

<th>Status</th>

<th width="220">

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

<%=order.getRestaurantName()%>

</td>

<td>

<%=order.getOrderDate()%>

</td>

<td>
 <%=order.getTotalAmount()%>

</td>

<td>
<%

String status = order.getStatus();

String css = "";

switch(status){

case "PLACED":

    css = "PLACED";

    break;

case "PREPARING":

    css = "preparing";

    break;

case "READY":

    css = "ready";

    break;

case "OUT_FOR_DELIVERY":

    css = "out";

    break;

case "DELIVERED":

    css = "delivered";

    break;

default:

    css = "cancelled";

}

%>

<span class="status <%=css%>">

<%=status%>

</span>

</td>

<td>

<form

action="<%=request.getContextPath()%>/updateOrderStatus"

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
<%=status.equals("PLACED")?"selected":""%>>

PLACED

</option>

<option
<%=status.equals("PREPARING")?"selected":""%>>

PREPARING

</option>

<option
<%=status.equals("READY")?"selected":""%>>

READY

</option>

<option
<%=status.equals("OUT_FOR_DELIVERY")?"selected":""%>>

OUT_FOR_DELIVERY

</option>

<option
<%=status.equals("DELIVERED")?"selected":""%>>

DELIVERED

</option>

<option
<%=status.equals("CANCELLED")?"selected":""%>>

CANCELLED

</option>

</select>

<button

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
<!-- =====================================
        BOOTSTRAP
====================================== -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

/* =====================================
      SEARCH ORDER
====================================== */

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


/* =====================================
      STATUS FILTER
====================================== */

document.getElementById("statusFilter")
.addEventListener("change",function(){

let status=this.value.toLowerCase();

let rows=document.querySelectorAll("#orderTable tbody tr");

rows.forEach(function(row){

if(status==""){

row.style.display="";

return;

}

let cell=row.cells[5].innerText.toLowerCase();

row.style.display=cell.includes(status)
? ""
: "none";

});

});


/* =====================================
      TOAST MESSAGE
====================================== */

const params=new URLSearchParams(window.location.search);

if(params.get("updated")){

showToast("Order Status Updated Successfully","success");

}

function showToast(message,type){

const div=document.createElement("div");

div.style.position="fixed";

div.style.top="20px";

div.style.right="20px";

div.style.zIndex="9999";

div.innerHTML=`

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

document.body.appendChild(div);

setTimeout(function(){

div.remove();

},3000);

}

</script>

</div>

</div>

</body>

</html>
