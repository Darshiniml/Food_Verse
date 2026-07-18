<%@page language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.food_application.model.Order"%>
<%@page import="com.food_application.model.OrderItem"%>

<%

List<Order> orders=
(List<Order>)request.getAttribute("orders");

Map<Integer,List<OrderItem>> orderItemsByOrder=
(Map<Integer,List<OrderItem>>)request.getAttribute("orderItemsByOrder");

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

/* Premium order-history refresh */
body{background:linear-gradient(180deg,#f8fafc 0%,#eef2ff 100%);color:#172033;}
.navbar{background:rgba(255,255,255,.88);backdrop-filter:blur(18px);border-bottom:1px solid rgba(148,163,184,.16);box-shadow:none;padding:13px 0;}
.navbar-brand{font-size:28px;letter-spacing:-1.2px;}
.hero{margin:34px auto 30px;padding:46px;isolation:isolate;background:linear-gradient(125deg,#111827 0%,#1e293b 54%,#e5672c 155%);box-shadow:0 28px 60px rgba(15,23,42,.22);}
.hero::after{content:"";position:absolute;inset:auto 8% -110px auto;width:320px;height:320px;border-radius:50%;background:radial-gradient(circle,rgba(249,115,22,.5),transparent 67%);z-index:-1;}
.hero h1{font-size:clamp(2.2rem,5vw,4rem);letter-spacing:-2px;}
.hero p{max-width:620px;color:rgba(255,255,255,.8);}
.hero-stats{gap:13px;}
.hero-stat{min-width:142px;padding:16px 19px;border:1px solid rgba(255,255,255,.13);background:rgba(255,255,255,.09);}
.hero-stat h2{font-size:27px;}
.search-box{max-width:760px;margin:0 auto 25px;padding:6px 7px 6px 20px;border:1px solid #e2e8f0;box-shadow:0 12px 35px rgba(15,23,42,.07);}
.search-box input{font-size:15px;padding:12px;}
.search-btn{padding:12px 23px;background:#172033;}
.search-btn:hover{background:#f97316;}
.filters{gap:10px;margin-bottom:30px;}
.filter-btn{padding:10px 17px;border:1px solid #e2e8f0;box-shadow:none;color:#475569;font-size:.9rem;}
.filter-btn:hover,.filter-btn.active{background:#172033;color:#fff;transform:none;border-color:#172033;}
.order-card{position:relative;overflow:hidden;padding:28px;margin-bottom:20px;border:1px solid #e2e8f0;border-radius:22px;box-shadow:0 12px 28px rgba(15,23,42,.055);}
.order-card::before{content:"";position:absolute;inset:0 auto 0 0;width:4px;background:linear-gradient(#fb923c,#f43f5e);opacity:0;transition:.25s;}
.order-card:hover{transform:translateY(-4px);box-shadow:0 20px 42px rgba(15,23,42,.1);}
.order-card:hover::before{opacity:1;}
.order-id{font-size:1.35rem;letter-spacing:-.5px;margin:0;}
.order-date{font-size:.9rem;margin:6px 0 0!important;}
.badge-status{display:inline-flex;align-items:center;min-height:32px;padding:7px 13px;font-size:.72rem;letter-spacing:.7px;font-weight:800;}
.order-card hr{border-color:#edf1f6;margin:20px 0;}
.order-card h6{text-transform:uppercase;letter-spacing:.7px;font-size:.68rem;font-weight:800;color:#94a3b8!important;}
.order-address{font-size:.92rem;margin-bottom:0;}
.timeline{margin-top:20px;padding:17px 0 0 22px;border-left:2px solid #e2e8f0;}
.timeline-step{margin-bottom:13px;font-size:.89rem;}
.timeline-step::before{left:-29px;top:3px;width:12px;height:12px;box-shadow:0 0 0 5px #ecfdf5;}
.timeline-step strong{color:#334155;}
.order-progress-heading{display:flex;align-items:center;justify-content:space-between;margin-top:22px;padding-top:20px;border-top:1px solid #edf1f6;font-size:.85rem;font-weight:800;color:#334155;}
.order-progress-heading span{color:#f97316;font-size:.72rem;letter-spacing:.7px;text-transform:uppercase;}
.timeline{display:grid;grid-template-columns:repeat(5,minmax(0,1fr));gap:8px;border:0;padding:18px 0 0;margin-top:0;}
.timeline-step{min-width:0;margin:0;padding:24px 10px 0;position:relative;font-size:.78rem;}
.timeline-step::before{left:10px;top:3px;width:12px;height:12px;background:#cbd5e1;box-shadow:0 0 0 5px #f1f5f9;}
.timeline-step::after{content:"";position:absolute;left:22px;right:-7px;top:8px;height:2px;background:#e2e8f0;}
.timeline-step:last-child::after{display:none;}
.timeline-step.completed::before{background:#10b981;box-shadow:0 0 0 5px #ecfdf5;}
.timeline-step.completed::after{background:#10b981;}
.timeline-step.active::before{background:#f97316;box-shadow:0 0 0 6px rgba(249,115,22,.16);animation:statusPulse 1.8s infinite;}
.timeline-step.active strong{color:#c2410c;}
.timeline-step.future{opacity:.56;}
.timeline-step small{display:block;line-height:1.35;margin-top:4px;}
.cancelled-progress{margin-top:22px;padding:13px 15px;border-radius:12px;background:#fff1f2;color:#be123c;font-size:.88rem;}
@keyframes statusPulse{0%,100%{box-shadow:0 0 0 5px rgba(249,115,22,.13)}50%{box-shadow:0 0 0 10px rgba(249,115,22,0)}}
.order-summary-panel{background:linear-gradient(155deg,#f8fafc,#fff)!important;border:1px solid #e2e8f0;border-radius:18px!important;padding:23px!important;}
.order-summary-panel .order-amount{font-size:1.6rem;letter-spacing:-1px;}
.order-summary-panel .item-summary{max-width:62%;text-align:right;font-size:.82rem;line-height:1.35;color:#334155;}
.btn-premium{border-radius:12px;padding:10px 16px;font-size:.88rem;transition:transform .2s,box-shadow .2s;}
.btn-premium:hover{transform:translateY(-2px);box-shadow:0 8px 16px rgba(15,23,42,.12);}
.empty{margin:25px 0 50px;padding:75px 25px;background:#fff;border:1px dashed #cbd5e1;border-radius:24px;}
footer{margin-top:55px;background:#111827;padding:45px 0;color:#cbd5e1;}
footer h2,footer h5{color:#fff;}
@media(max-width:991px){.hero{padding:34px 26px;}.hero h1{font-size:2.4rem;}.order-summary-panel{margin-top:22px;}.hero-stat{min-width:120px;}}
@media(max-width:767px){.timeline{grid-template-columns:1fr;gap:0;}.timeline-step{padding:0 0 17px 28px;}.timeline-step::before{left:4px;top:3px;}.timeline-step::after{left:9px;top:18px;right:auto;width:2px;height:calc(100% - 9px);}.timeline-step small{margin-top:3px;}}
@media(max-width:575px){.hero{margin-top:20px;border-radius:22px;}.hero-stats{display:grid;grid-template-columns:1fr 1fr;}.hero-stat{min-width:0;}.search-box{border-radius:16px;}.search-btn{padding:11px 15px;}.order-card{padding:21px 18px;}.filters{overflow-x:auto;flex-wrap:nowrap;padding-bottom:5px;}.filter-btn{white-space:nowrap;}}

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

<div class="text-uppercase fw-bold small mb-2" style="letter-spacing:2px;color:#fed7aa;">Order history</div>

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
class="filter-btn active"
data-filter="all">

All Orders

</button>

<button
class="filter-btn"
data-filter="PLACED">

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

String normalizedStatus=status==null ? "PLACED" : status.trim().toUpperCase();
int currentStage=0;
String progressMessage="Awaiting restaurant confirmation for this order.";

if("ACCEPTED".equals(normalizedStatus)){
    currentStage=1;
    progressMessage="The restaurant has accepted this order.";
}else if("PREPARING".equals(normalizedStatus) || "READY".equals(normalizedStatus)){
    currentStage=2;
    progressMessage="Your meal is being freshly prepared.";
}else if("ASSIGNED".equals(normalizedStatus)){
    currentStage=3;
    progressMessage="A delivery partner has been assigned.";
}else if("PICKED_UP".equals(normalizedStatus)){
    currentStage=3;
    progressMessage="Your delivery partner has picked up the order.";
}else if("OUT_FOR_DELIVERY".equals(normalizedStatus)){
    currentStage=3;
    progressMessage="Your order is on its way to you.";
}else if("DELIVERED".equals(normalizedStatus)){
    currentStage=4;
    progressMessage="This order was delivered successfully.";
}

String[] progressTitles={"Order placed","Restaurant confirmed","Preparing your meal","Out for delivery","Delivered"};

List<OrderItem> orderItems=orderItemsByOrder==null ? null : orderItemsByOrder.get(order.getOrderId());
StringBuilder itemSummaryBuilder=new StringBuilder();
if(orderItems!=null && !orderItems.isEmpty()){
    for(int itemIndex=0;itemIndex<orderItems.size();itemIndex++){
        OrderItem orderItem=orderItems.get(itemIndex);
        String itemName=orderItem.getFoodItem()==null ? "Item #"+orderItem.getFoodId() : orderItem.getFoodItem().getFoodName();
        if(itemIndex>0){ itemSummaryBuilder.append(", "); }
        itemSummaryBuilder.append(itemName).append(" ×").append(orderItem.getQuantity());
    }
}
String itemSummary=itemSummaryBuilder.length()==0 ? "Order items unavailable" : itemSummaryBuilder.toString();
boolean canCancel="PLACED".equals(normalizedStatus) || "PENDING".equals(normalizedStatus) || "ACCEPTED".equals(normalizedStatus);

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

<% if("CANCELLED".equals(normalizedStatus)){ %>

<div class="cancelled-progress">
<i class="bi bi-x-circle-fill me-2"></i>Order #<%=order.getOrderId()%> was cancelled. No further delivery updates are available.
</div>

<% }else{ %>

<div class="order-progress-heading">
<span>Live progress</span>
<div>Order #<%=order.getOrderId()%> · <%=progressMessage%></div>
</div>

<div class="timeline" aria-label="Order #<%=order.getOrderId()%> delivery progress">

<% for(int step=0;step<progressTitles.length;step++){
boolean isDelivered="DELIVERED".equals(normalizedStatus);
String stepClass=(isDelivered || step<currentStage) ? "completed" : (step==currentStage ? "active" : "future");
String stepDescription=isDelivered ? (step==4 ? "Delivered successfully" : "Completed") : (step<currentStage ? "Completed" : (step==currentStage ? progressMessage : "Waiting for this update"));
%>

<div class="timeline-step <%=stepClass%>">
<strong><%=progressTitles[step]%></strong>
<small class="text-muted"><%=stepDescription%></small>
</div>

<% } %>

</div>

<% } %>

</div>

<!-- RIGHT SIDE -->

<div class="col-lg-4">

<div class="order-summary-panel">

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

<strong class="item-summary">

<%=itemSummary%>

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

href="trackOrder.jsp?orderId=<%=order.getOrderId()%>"

class="btn btn-outline-success btn-premium">

<i class="bi bi-geo-alt-fill"></i>

View Tracking

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

if(canCancel){

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

b.classList.remove("active");

});

btn.classList.add("active");

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

toast.innerHTML='<div class="toast show text-bg-' + type + ' border-0"><div class="d-flex"><div class="toast-body">' + message + '</div><button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button></div></div>';

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

