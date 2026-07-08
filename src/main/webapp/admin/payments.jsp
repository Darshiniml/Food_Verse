<%@page language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="com.food_application.model.Payment"%>

<%
List<Payment> payments =
(List<Payment>)request.getAttribute("payments");

int total = payments!=null ? payments.size() : 0;

int success = 0;
int pending = 0;
int failed = 0;

double revenue = 0;

if(payments!=null){

    for(Payment payment:payments){

        revenue += payment.getAmount();

        if("SUCCESS".equalsIgnoreCase(payment.getPaymentStatus())){

            success++;

        }else if("PENDING".equalsIgnoreCase(payment.getPaymentStatus())){

            pending++;

        }else{

            failed++;

        }

    }

}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Payment Management</title>

<meta name="viewport"
content="width=device-width, initial-scale=1">

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link
rel="stylesheet"
href="<%=request.getContextPath()%>/admin/css/admin.css">

<style>

.payment-card{

background:white;

border-radius:18px;

padding:25px;

box-shadow:0 8px 18px rgba(0,0,0,.08);

transition:.3s;

}

.payment-card:hover{

transform:translateY(-5px);

}

.status{

padding:6px 14px;

border-radius:20px;

color:white;

font-size:13px;

font-weight:bold;

}

.success{

background:#22C55E;

}

.pending{

background:#F59E0B;

}

.failed{

background:#EF4444;

}

</style>

</head>

<body>

<%@include file="includes/sidebar.jsp"%>

<div class="main">

<%@include file="includes/navbar.jsp"%>

<div class="content">

<h2 class="mb-4">

💳 Payment Management

</h2>

<div class="row">

<div class="col-md-3">

<div class="payment-card text-center">

<i class="bi bi-credit-card-fill text-primary"
style="font-size:35px;"></i>

<h6 class="mt-3">

Total Payments

</h6>

<h2>

<%=total%>

</h2>

</div>

</div>

<div class="col-md-3">

<div class="payment-card text-center">

<i class="bi bi-check-circle-fill text-success"
style="font-size:35px;"></i>

<h6 class="mt-3">

Successful

</h6>

<h2>

<%=success%>

</h2>

</div>

</div>

<div class="col-md-3">

<div class="payment-card text-center">

<i class="bi bi-hourglass-split text-warning"
style="font-size:35px;"></i>

<h6 class="mt-3">

Pending

</h6>

<h2>

<%=pending%>

</h2>

</div>

</div>

<div class="col-md-3">

<div class="payment-card text-center">

<i class="bi bi-cash-stack text-danger"
style="font-size:35px;"></i>

<h6 class="mt-3">

Revenue

</h6>

<h2>

₹ <%=String.format("%.2f",revenue)%>

</h2>

</div>

</div>

</div>

<br>

<div class="card-box">

<div class="row mb-4">

<div class="col-md-4">

<input

id="searchPayment"

class="form-control"

placeholder="Search Payments...">

</div>

</div>

<table
class="table table-hover align-middle"
id="paymentTable">

<thead class="table-dark">

<tr>

<th>ID</th>

<th>Customer</th>

<th>Amount</th>

<th>Method</th>

<th>Status</th>

<th>Date</th>

</tr>

</thead>

<tbody>

<%

if(payments!=null){

for(Payment payment:payments){

%>

<tr>

<td>

#<%=payment.getPaymentId()%>

</td>

<td>

<%=payment.getUserId()%>

</td>

<td>

₹ <%=payment.getAmount()%>

</td>

<td>

<%=payment.getPaymentMethod()%>

</td>

<td>
<%

String css = "";

switch(payment.getPaymentStatus()){

case "SUCCESS":

    css="success";

    break;

case "PENDING":

    css="pending";

    break;

case "FAILED":

    css="failed";

    break;

default:

    css="pending";

}

%>

<span class="status <%=css%>">

<%=payment.getPaymentStatus()%>

</span>

</td>

<td>

<%=payment.getPaymentDate()%>

</td>

</tr>

<%

}

}else{

%>

<tr>

<td colspan="6" class="text-center py-5">

<i

class="bi bi-credit-card"

style="font-size:70px;color:#CBD5E1;">

</i>

<h4 class="mt-3">

No Payments Found

</h4>

<p class="text-muted">

There are no payment records available.

</p>

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

<div class="payment-card">

<h4>

💰 Payment Summary

</h4>

<hr>

<div class="d-flex justify-content-between mb-3">

<span>

Total Revenue

</span>

<b>

₹ <%=String.format("%.2f",revenue)%>

</b>

</div>

<div class="progress mb-4">

<div

class="progress-bar bg-success"

style="width:100%">

</div>

</div>

<div class="d-flex justify-content-between mb-3">

<span>

Successful Payments

</span>

<b>

<%=success%>

</b>

</div>

<div class="progress mb-4">

<div

class="progress-bar bg-primary"

style="width:<%=total>0?(success*100/total):0%>%">

</div>

</div>

<div class="d-flex justify-content-between mb-3">

<span>

Pending Payments

</span>

<b>

<%=pending%>

</b>

</div>

<div class="progress">

<div

class="progress-bar bg-warning"

style="width:<%=total>0?(pending*100/total):0%>%">

</div>

</div>

</div>

</div>

<div class="col-md-6">

<div class="payment-card">

<h4>

⚡ Quick Actions

</h4>

<hr>

<a

href="analytics"

class="btn btn-primary w-100 mb-3">

<i class="bi bi-bar-chart-fill"></i>

Analytics Dashboard

</a>

<a

href="manageOrders"

class="btn btn-success w-100 mb-3">

<i class="bi bi-box-seam-fill"></i>

Manage Orders

</a>

<a

href="adminDashboard"

class="btn btn-warning w-100 mb-3">

<i class="bi bi-speedometer2"></i>

Admin Dashboard

</a>

<a

href="manageUsers"

class="btn btn-dark w-100">

<i class="bi bi-people-fill"></i>

Manage Users

</a>

</div>

</div>

</div>

<br>

<div class="payment-card">

<h4>

📊 Payment Statistics

</h4>

<hr>

<div class="row text-center">

<div class="col-md-4">

<h2 class="text-success">

<%=success%>

</h2>

<p>

Successful Payments

</p>

</div>

<div class="col-md-4">

<h2 class="text-warning">

<%=pending%>

</h2>

<p>

Pending Payments

</p>

</div>

<div class="col-md-4">

<h2 class="text-danger">

<%=failed%>

</h2>

<p>

Failed Payments

</p>

</div>

</div>

</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

/*==========================================
        SEARCH PAYMENT
==========================================*/

document.getElementById("searchPayment")
.addEventListener("keyup",function(){

    let value=this.value.toLowerCase();

    let rows=document.querySelectorAll("#paymentTable tbody tr");

    rows.forEach(function(row){

        let text=row.innerText.toLowerCase();

        row.style.display=text.includes(value)
        ? ""
        : "none";

    });

});


/*==========================================
        PAYMENT STATUS CHART
==========================================*/

new Chart(

document.createElement("canvas"),

{

type:"doughnut",

data:{

labels:[

"Success",

"Pending",

"Failed"

],

datasets:[{

data:[

<%=success%>,

<%=pending%>,

<%=failed%>

],

backgroundColor:[

"#22C55E",

"#F59E0B",

"#EF4444"

]

}]

},

options:{

responsive:true,

plugins:{

legend:{

position:"bottom"

}

}

}

});

</script>

<div class="payment-card mt-4">

<h4>

📊 Payment Status Overview

</h4>

<hr>

<canvas id="paymentChart"

style="max-height:320px;">

</canvas>

</div>

<script>

/*==========================================
        PAYMENT PIE CHART
==========================================*/

new Chart(

document.getElementById("paymentChart"),

{

type:"pie",

data:{

labels:[

"Success",

"Pending",

"Failed"

],

datasets:[{

data:[

<%=success%>,

<%=pending%>,

<%=failed%>

],

backgroundColor:[

"#22C55E",

"#F59E0B",

"#EF4444"

]

}]

},

options:{

responsive:true,

plugins:{

legend:{

position:"bottom"

}

}

}

});


/*==========================================
        SUCCESS TOAST
==========================================*/

const params=new URLSearchParams(window.location.search);

if(params.get("updated")){

showToast(

"Payment Updated Successfully",

"success"

);

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

// Uncomment if required

// setTimeout(function(){

//     location.reload();

// },60000);

</script>

<div class="footer">

<hr>

<p>

💳 FoodVerse Payment Management

<br>

© 2026 FoodVerse. All Rights Reserved.

</p>

</div>

</div>

</div>

</body>

</html>