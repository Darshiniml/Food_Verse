<%@page language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.food_application.model.Order"%>

<%

List<Order> orders=
(List<Order>)request.getAttribute("orders");

SimpleDateFormat sdf=
new SimpleDateFormat("dd MMM yyyy hh:mm a");

int totalOrders=0;
int delivered=0;
int pending=0;
int cancelled=0;

double totalSpent=0;

if(orders!=null){

    totalOrders=orders.size();

    for(Order order:orders){

        totalSpent+=order.getTotalAmount();

        if(order.getStatus()!=null){

            switch(order.getStatus().toUpperCase()){

            case "DELIVERED":

                delivered++;

                break;

            case "CANCELLED":

                cancelled++;

                break;

            default:

                pending++;

            }

        }

    }

}

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width,initial-scale=1">

<title>

My Orders | FoodVerse

</title>

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link
href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
rel="stylesheet">

<style>

*{

margin:0;

padding:0;

box-sizing:border-box;

font-family:'Poppins',sans-serif;

}

body{

background:#F8FAFC;

overflow-x:hidden;

}


/*====================================================

NAVBAR

====================================================*/

.navbar{

background:white;

padding:18px 0;

box-shadow:0 10px 25px rgba(0,0,0,.08);

position:sticky;

top:0;

z-index:999;

}

.navbar-brand{

font-size:34px;

font-weight:800;

color:#F97316!important;

}

.nav-link{

font-weight:600;

margin-left:20px;

transition:.3s;

}

.nav-link:hover{

color:#F97316!important;

}

.btn-nav{

border-radius:35px;

padding:10px 22px;

font-weight:600;

}


/*====================================================

HERO

====================================================*/

.hero{

margin:45px auto;

padding:60px;

border-radius:30px;

background:linear-gradient(135deg,#FF6B35,#FF914D);

color:white;

position:relative;

overflow:hidden;

}

.hero::before{

content:"";

position:absolute;

right:-90px;

top:-90px;

width:260px;

height:260px;

border-radius:50%;

background:rgba(255,255,255,.12);

}

.hero h1{

font-size:52px;

font-weight:800;

margin-bottom:15px;

}

.hero p{

font-size:18px;

opacity:.95;

margin-bottom:35px;

}

.hero-stats{

display:flex;

gap:40px;

flex-wrap:wrap;

}

.hero-stat{

background:rgba(255,255,255,.15);

padding:20px;

border-radius:18px;

backdrop-filter:blur(8px);

min-width:170px;

}

.hero-stat h2{

font-size:34px;

font-weight:700;

margin-bottom:5px;

}

.hero-stat p{

margin:0;

font-size:15px;

}


/*====================================================

SEARCH

====================================================*/

.search-box{

margin:45px 0;

display:flex;

background:white;

padding:8px;

border-radius:50px;

box-shadow:0 12px 30px rgba(0,0,0,.08);

}

.search-box input{

flex:1;

border:none;

outline:none;

padding:15px;

font-size:17px;

border-radius:40px;

}

.search-btn{

background:#F97316;

color:white;

border:none;

padding:15px 35px;

border-radius:40px;

font-weight:600;

transition:.3s;

}

.search-btn:hover{

background:#EA580C;

}


/*====================================================

FILTER BUTTONS

====================================================*/

.filters{

display:flex;

gap:15px;

flex-wrap:wrap;

margin-bottom:45px;

}

.filter-btn{

background:white;

border:none;

padding:12px 22px;

border-radius:35px;

font-weight:600;

box-shadow:0 5px 15px rgba(0,0,0,.08);

transition:.3s;

cursor:pointer;

}

.filter-btn:hover{

background:#F97316;

color:white;

transform:translateY(-4px);

}


/*====================================================

ORDER CARD

====================================================*/

.order-card{

background:white;

border-radius:25px;

box-shadow:0 15px 35px rgba(0,0,0,.08);

padding:30px;

margin-bottom:30px;

transition:.35s;

}

.order-card:hover{

transform:translateY(-8px);

}

.order-id{

font-size:28px;

font-weight:700;

color:#1E293B;

}

.order-amount{

font-size:32px;

font-weight:700;

color:#10B981;

}

.order-date{

color:#64748B;

}

.order-address{

color:#475569;

}


/*====================================================

STATUS BADGES

====================================================*/

.badge-status{

padding:10px 18px;

border-radius:30px;

font-size:14px;

font-weight:600;

}

.pending{

background:#FEF3C7;

color:#B45309;

}

.preparing{

background:#DBEAFE;

color:#1D4ED8;

}

.delivered{

background:#DCFCE7;

color:#15803D;

}

.cancelled{

background:#FEE2E2;

color:#B91C1C;

}


/*====================================================

TIMELINE

====================================================*/

.timeline{

margin-top:25px;

border-left:3px solid #E2E8F0;

padding-left:25px;

}

.timeline-step{

position:relative;

margin-bottom:18px;

}

.timeline-step::before{

content:"";

position:absolute;

left:-33px;

top:4px;

width:14px;

height:14px;

background:#10B981;

border-radius:50%;

}


/*====================================================

BUTTONS

====================================================*/

.btn-premium{

border-radius:35px;

padding:12px 25px;

font-weight:600;

}


/*====================================================

EMPTY

====================================================*/

.empty{

padding:100px;

text-align:center;

}

.empty i{

font-size:100px;

color:#CBD5E1;

}


/*====================================================

FOOTER

====================================================*/

footer{

margin-top:70px;

background:#1E293B;

color:white;

padding:55px;

text-align:center;

}

</style>
</head>

<body>

<!-- ===========================
        NAVBAR
=========================== -->

<nav class="navbar navbar-expand-lg">

<div class="container">

<a class="navbar-brand"
href="home">

🍽 FoodVerse

</a>

<button
class="navbar-toggler"
type="button"
data-bs-toggle="collapse"
data-bs-target="#navbarMenu">

<span class="navbar-toggler-icon"></span>

</button>

<div
class="collapse navbar-collapse"
id="navbarMenu">

<ul class="navbar-nav ms-auto align-items-center">

<li class="nav-item">

<a
class="nav-link"
href="home">

Home

</a>

</li>

<li class="nav-item">

<a
class="nav-link active"
href="myOrders">

My Orders

</a>

</li>

<li class="nav-item">

<a
class="nav-link"
href="cart">

Cart

</a>

</li>

<li class="nav-item">

<a
class="nav-link"
href="profile">

Profile

</a>

</li>

<li class="nav-item ms-3">

<a
href="logout"
class="btn btn-danger btn-nav">

Logout

</a>

</li>

</ul>

</div>

</div>

</nav>



<div class="container">



<!-- ===========================
        HERO
=========================== -->

<div class="hero">

<div class="row align-items-center">

<div class="col-lg-8">

<h1>

📦 My Orders

</h1>

<p>

Track every order you've placed, monitor delivery status,
download invoices and reorder your favourite meals anytime.

</p>

</div>

<div class="col-lg-4 text-lg-end">

<i
class="bi bi-bag-check-fill"
style="font-size:120px;opacity:.25;">

</i>

</div>

</div>



<div class="hero-stats">

<div class="hero-stat">

<h2>

<%=totalOrders%>

</h2>

<p>

Total Orders

</p>

</div>

<div class="hero-stat">

<h2>

<%=delivered%>

</h2>

<p>

Delivered

</p>

</div>

<div class="hero-stat">

<h2>

<%=pending%>

</h2>

<p>

Pending

</p>

</div>

<div class="hero-stat">

<h2>

₹ <%=String.format("%.0f",totalSpent)%>

</h2>

<p>

Total Spent

</p>

</div>

</div>

</div>



<!-- ===========================
        SEARCH
=========================== -->

<div class="search-box">

<input

type="text"

id="searchOrder"

placeholder="Search Order ID, Address or Status...">

<button

type="button"

class="search-btn">

<i class="bi bi-search"></i>

Search

</button>

</div>



<!-- ===========================
        FILTERS
=========================== -->

<div class="filters">

<button
class="filter-btn"
data-filter="all">

All Orders

</button>

<button
class="filter-btn"
data-filter="PENDING">

Pending

</button>

<button
class="filter-btn"
data-filter="PREPARING">

Preparing

</button>

<button
class="filter-btn"
data-filter="DELIVERED">

Delivered

</button>

<button
class="filter-btn"
data-filter="CANCELLED">

Cancelled

</button>

</div>



<!-- ===========================
        SECTION TITLE
=========================== -->

<div class="d-flex justify-content-between align-items-center mb-4">

<div>

<h2 style="font-weight:700;">

Recent Orders

</h2>

<p class="text-muted">

Your latest food orders from FoodVerse

</p>

</div>

<div>

<span
class="badge bg-success fs-6">

<%=totalOrders%>

Orders Found

</span>

</div>

</div>



<!-- ===========================
        ORDERS START
=========================== -->

<%

if(orders==null || orders.isEmpty()){

%>

<div class="empty">

<i class="bi bi-bag-x-fill"></i>

<h2 class="mt-4">

No Orders Yet

</h2>

<p class="text-muted">

Looks like you haven't ordered anything yet.

Start exploring delicious restaurants!

</p>

<br>

<a

href="home"

class="btn btn-warning btn-lg rounded-pill px-5">

🍽 Explore Restaurants

</a>

</div>

<%

}else{

for(Order order : orders){

String status=order.getStatus();

String css="pending";

if(status!=null){

if(status.equalsIgnoreCase("PREPARING"))

css="preparing";

else if(status.equalsIgnoreCase("DELIVERED"))

css="delivered";

else if(status.equalsIgnoreCase("CANCELLED"))

css="cancelled";

}

%>
<div
class="order-card order-item"
data-status="<%=order.getStatus()%>">

<div class="row align-items-center">

<!-- LEFT SIDE -->

<div class="col-lg-8">

<div class="d-flex justify-content-between align-items-center">

<div>

<h3 class="order-id">

Order #<%=order.getOrderId()%>

</h3>

<p class="order-date mt-2">

<i class="bi bi-calendar-event"></i>

<%=sdf.format(order.getOrderDate())%>

</p>

</div>

<div>

<span class="badge-status <%=css%>">

<%=order.getStatus()%>

</span>

</div>

</div>

<hr>

<div class="row mt-4">

<div class="col-md-6 mb-3">

<h6 class="text-muted">

Delivery Address

</h6>

<p class="order-address">

<i class="bi bi-geo-alt-fill text-danger"></i>

<%=order.getDeliveryAddress()%>

</p>

</div>

<div class="col-md-6 mb-3">

<h6 class="text-muted">

Payment Status

</h6>

<span class="badge bg-success">

<i class="bi bi-check-circle-fill"></i>

Paid Successfully

</span>

</div>

</div>

<!-- ORDER TIMELINE -->

<div class="timeline">

<div class="timeline-step">

<strong>

Order Confirmed

</strong>

<br>

<small class="text-muted">

Your order has been placed successfully.

</small>

</div>

<div class="timeline-step">

<strong>

Preparing Food

</strong>

<br>

<small class="text-muted">

Restaurant is preparing your meal.

</small>

</div>

<div class="timeline-step">

<strong>

Out For Delivery

</strong>

<br>

<small class="text-muted">

Delivery partner is on the way.

</small>

</div>

<div class="timeline-step">

<strong>

Delivered

</strong>

<br>

<small class="text-muted">

Enjoy your delicious meal!

</small>

</div>

</div>

</div>

<!-- RIGHT SIDE -->

<div class="col-lg-4">

<div
style="background:#F8FAFC;
border-radius:20px;
padding:25px;">

<div class="text-center">

<i
class="bi bi-bag-check-fill"
style="font-size:60px;
color:#F97316;">

</i>

<h5 class="mt-3">

FoodVerse Order

</h5>

</div>

<hr>

<div class="d-flex
justify-content-between
mb-3">

<span>

Order ID

</span>

<strong>

#<%=order.getOrderId()%>

</strong>

</div>

<div class="d-flex
justify-content-between
mb-3">

<span>

Items

</span>

<strong>

Multiple Items

</strong>

</div>

<div class="d-flex
justify-content-between
mb-3">

<span>

Payment

</span>

<strong class="text-success">

Paid

</strong>

</div>

<div class="d-flex
justify-content-between
mb-4">

<span>

Total Amount

</span>

<strong
class="order-amount">

₹ <%=String.format("%.2f",
order.getTotalAmount())%>

</strong>

</div>

<div class="d-grid gap-2">

<a

href="orderDetails?orderId=<%=order.getOrderId()%>"

class="btn btn-primary btn-premium">

<i class="bi bi-eye-fill"></i>

View Details

</a>

<a

href="downloadInvoice?orderId=<%=order.getOrderId()%>"

class="btn btn-success btn-premium">

<i class="bi bi-download"></i>

Download Invoice

</a>

<a

href="reorder?orderId=<%=order.getOrderId()%>"

class="btn btn-warning btn-premium">

<i class="bi bi-arrow-repeat"></i>

Reorder

</a>

<%

if(!"DELIVERED".equalsIgnoreCase(order.getStatus())
&& !"CANCELLED".equalsIgnoreCase(order.getStatus())){

%>

<a

href="cancelOrder?orderId=<%=order.getOrderId()%>"

class="btn btn-outline-danger btn-premium"

onclick="return confirm('Cancel this order?');">

<i class="bi bi-x-circle"></i>

Cancel Order

</a>

<%

}

%>

</div>

</div>

</div>

</div>

</div>

<%

}

}

%>
<!-- ===========================
        PREMIUM FOOTER
=========================== -->

<footer>

<div class="container">

<div class="row">

<div class="col-lg-4">

<h2>

🍽 FoodVerse

</h2>

<p class="mt-3">

Fresh Food • Fast Delivery • Secure Payments

Experience restaurant-quality food delivered to your doorstep.

</p>

</div>

<div class="col-lg-2">

<h5>

Quick Links

</h5>

<p>

<a href="home"
class="text-white text-decoration-none">

Home

</a>

</p>

<p>

<a href="cart"
class="text-white text-decoration-none">

Cart

</a>

</p>

<p>

<a href="profile"
class="text-white text-decoration-none">

Profile

</a>

</p>

</div>

<div class="col-lg-3">

<h5>

Customer Support

</h5>

<p>

📞 +91 9876543210

</p>

<p>

✉ support@foodverse.com

</p>

<p>

💬 24 × 7 Available

</p>

</div>

<div class="col-lg-3">

<h5>

Secure Payments

</h5>

<p>

✔ Razorpay

</p>

<p>

✔ UPI

</p>

<p>

✔ Cards

</p>

<p>

✔ Net Banking

</p>

</div>

</div>

<hr class="my-4">

<p class="mb-0">

© 2026 FoodVerse |

Made with ❤️ using Java, JSP, Servlets & MySQL

</p>

</div>

</footer>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

/*========================================
            SEARCH ORDERS
========================================*/

document.getElementById("searchOrder")

.addEventListener("keyup",function(){

let value=this.value.toLowerCase();

document.querySelectorAll(".order-item")

.forEach(function(card){

let text=card.innerText.toLowerCase();

card.style.display=text.includes(value)

? ""

: "none";

});

});


/*========================================
            FILTER BUTTONS
========================================*/

document.querySelectorAll(".filter-btn")

.forEach(function(btn){

btn.addEventListener("click",function(){

document.querySelectorAll(".filter-btn")

.forEach(function(b){

b.style.background="white";

b.style.color="black";

});

btn.style.background="#F97316";

btn.style.color="white";

let filter=

btn.getAttribute("data-filter");

document.querySelectorAll(".order-item")

.forEach(function(card){

if(filter==="all"){

card.style.display="";

}

else{

let status=

card.getAttribute("data-status");

card.style.display=

status===filter

? ""

: "none";

}

});

});

});


/*========================================
            CARD ANIMATION
========================================*/

document.querySelectorAll(".order-card")

.forEach(function(card){

card.addEventListener("mouseenter",function(){

card.style.transform="translateY(-8px)";

card.style.transition=".3s";

});

card.addEventListener("mouseleave",function(){

card.style.transform="translateY(0px)";

});

});


/*========================================
        SUCCESS TOAST
========================================*/

const params=new URLSearchParams(window.location.search);

if(params.get("cancelled")){

showToast("Order Cancelled Successfully","danger");

}

if(params.get("reordered")){

showToast("Order Added To Cart","success");

}

function showToast(message,type){

const toast=document.createElement("div");

toast.style.position="fixed";

toast.style.top="25px";

toast.style.right="25px";

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


/*========================================
      ACTIVE NAV LINK
========================================*/

document.querySelectorAll(".nav-link")

.forEach(function(link){

link.addEventListener("click",function(){

document.querySelectorAll(".nav-link")

.forEach(function(l){

l.classList.remove("active");

});

this.classList.add("active");

});

});


/*========================================
      AUTO SCROLL TOP
========================================*/

window.onload=function(){

window.scrollTo({

top:0,

behavior:"smooth"

});

};

</script>

<jsp:include page="/includes/customerChatbot.jsp" />

</body>

</html>
