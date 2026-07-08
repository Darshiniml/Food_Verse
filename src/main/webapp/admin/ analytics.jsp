<%@page language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>

<%
Double totalRevenue =
(Double)request.getAttribute("totalRevenue");

Double todayRevenue =
(Double)request.getAttribute("todayRevenue");

Double monthlyRevenue =
(Double)request.getAttribute("monthlyRevenue");

Integer totalPayments =
(Integer)request.getAttribute("totalPayments");

Integer successPayments =
(Integer)request.getAttribute("successPayments");

Integer pendingPayments =
(Integer)request.getAttribute("pendingPayments");

if(totalRevenue==null) totalRevenue=0.0;
if(todayRevenue==null) todayRevenue=0.0;
if(monthlyRevenue==null) monthlyRevenue=0.0;
if(totalPayments==null) totalPayments=0;
if(successPayments==null) successPayments=0;
if(pendingPayments==null) pendingPayments=0;
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Analytics Dashboard</title>

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

.analytics-card{

background:white;

border-radius:18px;

padding:25px;

box-shadow:0 8px 18px rgba(0,0,0,.08);

transition:.3s;

}

.analytics-card:hover{

transform:translateY(-5px);

}

.analytics-card i{

font-size:40px;

margin-bottom:15px;

}

.analytics-card h2{

font-weight:bold;

}

.chart-card{

background:white;

border-radius:18px;

padding:25px;

box-shadow:0 8px 18px rgba(0,0,0,.08);

margin-top:25px;

}

</style>

</head>

<body>

<%@include file="includes/sidebar.jsp"%>

<div class="main">

<%@include file="includes/navbar.jsp"%>

<div class="content">

<h2 class="mb-4">

📊 Analytics Dashboard

</h2>

<div class="row">

<div class="col-md-4">

<div class="analytics-card text-center">

<i class="bi bi-cash-stack text-success"></i>

<h6>Total Revenue</h6>

<h2>

₹ <%=String.format("%.2f",totalRevenue)%>

</h2>

</div>

</div>

<div class="col-md-4">

<div class="analytics-card text-center">

<i class="bi bi-calendar-check text-primary"></i>

<h6>Today's Revenue</h6>

<h2>

₹ <%=String.format("%.2f",todayRevenue)%>

</h2>

</div>

</div>

<div class="col-md-4">

<div class="analytics-card text-center">

<i class="bi bi-bar-chart-fill text-warning"></i>

<h6>Monthly Revenue</h6>

<h2>

₹ <%=String.format("%.2f",monthlyRevenue)%>

</h2>

</div>

</div>

</div>

<br>

<div class="row">

<div class="col-md-4">

<div class="analytics-card text-center">

<i class="bi bi-credit-card text-info"></i>

<h6>Total Payments</h6>

<h2>

<%=totalPayments%>

</h2>

</div>

</div>

<div class="col-md-4">

<div class="analytics-card text-center">

<i class="bi bi-check-circle-fill text-success"></i>

<h6>Successful Payments</h6>

<h2>

<%=successPayments%>

</h2>

</div>

</div>

<div class="col-md-4">

<div class="analytics-card text-center">

<i class="bi bi-hourglass-split text-danger"></i>

<h6>Pending Payments</h6>

<h2>

<%=pendingPayments%>

</h2>

</div>

</div>

</div>
<br>

<%
double successRate = 0;

if(totalPayments > 0){

    successRate =
    ((double)successPayments / totalPayments) * 100;

}
%>

<div class="row">

<div class="col-lg-6">

<div class="chart-card">

<h4>

💰 Revenue Overview

</h4>

<hr>

<div class="mb-4">

<div class="d-flex
justify-content-between">

<span>

Today's Revenue

</span>

<b>

₹ <%=String.format("%.2f",todayRevenue)%>

</b>

</div>

<div class="progress mt-2">

<div

class="progress-bar bg-success"

style="width:<%=Math.min(todayRevenue/1000*100,100)%>%">

</div>

</div>

</div>


<div class="mb-4">

<div class="d-flex
justify-content-between">

<span>

Monthly Revenue

</span>

<b>

₹ <%=String.format("%.2f",monthlyRevenue)%>

</b>

</div>

<div class="progress mt-2">

<div

class="progress-bar bg-primary"

style="width:<%=Math.min(monthlyRevenue/10000*100,100)%>%">

</div>

</div>

</div>


<div>

<div class="d-flex
justify-content-between">

<span>

Total Revenue

</span>

<b>

₹ <%=String.format("%.2f",totalRevenue)%>

</b>

</div>

<div class="progress mt-2">

<div

class="progress-bar bg-warning"

style="width:100%">

</div>

</div>

</div>

</div>

</div>

<div class="col-lg-6">

<div class="chart-card">

<h4>

💳 Payment Statistics

</h4>

<hr>

<div class="mb-4">

<div class="d-flex
justify-content-between">

<span>

Successful Payments

</span>

<b>

<%=successPayments%>

</b>

</div>

<div class="progress mt-2">

<div

class="progress-bar bg-success"

style="width:<%=successRate%>%">

</div>

</div>

</div>


<div class="mb-4">

<div class="d-flex
justify-content-between">

<span>

Pending Payments

</span>

<b>

<%=pendingPayments%>

</b>

</div>

<div class="progress mt-2">

<div

class="progress-bar bg-danger"

style="width:<%=100-successRate%>%">

</div>

</div>

</div>

<div class="alert alert-info mt-4">

<b>

Success Rate :

</b>

<%=String.format("%.1f",successRate)%> %

</div>

</div>

</div>

</div>

<br>

<div class="row">

<div class="col-lg-6">

<div class="chart-card">

<h4>

📈 Monthly Summary

</h4>

<hr>

<table class="table">

<tr>

<td>

Today's Revenue

</td>

<td>

₹ <%=String.format("%.2f",todayRevenue)%>

</td>

</tr>

<tr>

<td>

Monthly Revenue

</td>

<td>

₹ <%=String.format("%.2f",monthlyRevenue)%>

</td>

</tr>

<tr>

<td>

Total Revenue

</td>

<td>

₹ <%=String.format("%.2f",totalRevenue)%>

</td>

</tr>

<tr>

<td>

Total Payments

</td>

<td>

<%=totalPayments%>

</td>

</tr>

</table>

</div>

</div>

<div class="col-lg-6">

<div class="chart-card">

<h4>

⚡ Quick Actions

</h4>

<hr>

<a

href="payments"

class="btn btn-success w-100 mb-3">

<i class="bi bi-credit-card-fill"></i>

View Payments

</a>

<a

href="manageOrders"

class="btn btn-primary w-100 mb-3">

<i class="bi bi-box-seam-fill"></i>

Manage Orders

</a>

<a

href="manageRestaurants"

class="btn btn-warning w-100 mb-3">

<i class="bi bi-shop"></i>

Restaurants

</a>

<a

href="adminDashboard"

class="btn btn-dark w-100">

<i class="bi bi-speedometer2"></i>

Dashboard

</a>

</div>

</div>

</div>

<br>

<div class="chart-card">

<h4>

📊 Revenue Trend

</h4>

<hr>

<canvas

id="revenueChart"

height="100">

</canvas>

</div>

<br>

<div class="chart-card">

<h4>

💳 Payment Distribution

</h4>

<hr>

<canvas

id="paymentChart"

height="100">

</canvas>

</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

/*==========================================
        REVENUE CHART
==========================================*/

new Chart(

document.getElementById("revenueChart"),

{

type:"line",

data:{

labels:[

"Today",

"This Month",

"Overall"

],

datasets:[{

label:"Revenue",

data:[

<%=todayRevenue%>,

<%=monthlyRevenue%>,

<%=totalRevenue%>

],

borderColor:"#F97316",

backgroundColor:"rgba(249,115,22,.15)",

fill:true,

tension:.4

}]

},

options:{

responsive:true,

plugins:{

legend:{

display:false

}

}

}

});


/*==========================================
        PAYMENT CHART
==========================================*/

new Chart(

document.getElementById("paymentChart"),

{

type:"doughnut",

data:{

labels:[

"Successful",

"Pending"

],

datasets:[{

data:[

<%=successPayments%>,

<%=pendingPayments%>

],

backgroundColor:[

"#16A34A",

"#DC2626"

]

}]

},

options:{

responsive:true

}

});


/*==========================================
        TOAST NOTIFICATION
==========================================*/

const params = new URLSearchParams(window.location.search);

if(params.get("updated")){

showToast(

"Analytics Updated Successfully",

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

// Uncomment if you want live dashboard refresh

// setTimeout(function(){

// location.reload();

// },60000);

</script>

<div class="footer">

<hr>

<p>

FoodVerse Analytics Dashboard

<br>

© 2026 FoodVerse. All Rights Reserved.

</p>

</div>

</div>

</div>

</body>

</html>