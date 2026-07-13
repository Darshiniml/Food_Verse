<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="com.food_application.model.User"%>

<%
User user = (User) request.getAttribute("user");

if(user == null){
    response.sendRedirect("login.jsp");
    return;
}

String initials = "";

if(user.getName()!=null){
    String[] arr = user.getName().split(" ");
    for(String s : arr){
        if(!s.isEmpty()){
            initials += s.substring(0,1).toUpperCase();
        }
    }
}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>My Profile | FoodVerse</title>

<meta name="viewport"
content="width=device-width, initial-scale=1">

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link
href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}

body{

background:
linear-gradient(135deg,#FF6B35,#FF914D,#FFD166);

min-height:100vh;

padding:40px;

}

.container-box{

max-width:1350px;

margin:auto;

}

.profile-header{

background:white;

border-radius:30px;

padding:40px;

display:flex;

justify-content:space-between;

align-items:center;

box-shadow:0 20px 40px rgba(0,0,0,.12);

margin-bottom:35px;

}

.left-profile{

display:flex;

align-items:center;

gap:30px;

}

.avatar{

width:140px;

height:140px;

border-radius:50%;

background:linear-gradient(135deg,#ff6b35,#ff914d);

display:flex;

justify-content:center;

align-items:center;

font-size:50px;

font-weight:bold;

color:white;

box-shadow:0 10px 30px rgba(0,0,0,.2);

}

.profile-info h2{

font-size:36px;

font-weight:700;

margin-bottom:10px;

color:#1E293B;

}

.profile-info p{

font-size:17px;

color:#64748B;

margin-bottom:8px;

}

.badge-role{

display:inline-block;

padding:8px 18px;

border-radius:30px;

background:#16A34A;

color:white;

font-weight:600;

font-size:14px;

}

.online{

margin-top:15px;

color:#16A34A;

font-weight:600;

}

.online i{

margin-right:8px;

}

.right-profile{

text-align:right;

}

.member{

font-size:18px;

color:#64748B;

margin-bottom:10px;

}

.points{

font-size:42px;

font-weight:bold;

color:#ff6b35;

}

.points span{

font-size:18px;

color:#64748B;

}

.progress{

height:12px;

border-radius:50px;

margin-top:20px;

}

.progress-bar{

background:#ff6b35;

}

.section-title{

font-size:25px;

font-weight:700;

margin-bottom:20px;

color:#1E293B;

}

.card-box{

background:white;

border-radius:25px;

padding:30px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

transition:.3s;

}

.card-box:hover{

transform:translateY(-5px);

}

</style>

</head>

<body>

<div class="container-box">

<!-- PROFILE HEADER -->

<div class="profile-header">

<div class="left-profile">

<div class="avatar">

<%=initials%>

</div>

<div class="profile-info">

<h2>

<%=user.getName()%>

</h2>

<p>

<i class="bi bi-envelope-fill"></i>

<%=user.getEmail()%>

</p>

<p>

<i class="bi bi-person-badge-fill"></i>

FoodVerse Premium Customer

</p>

<div class="badge-role">

<%=user.getRole()%>

</div>

<div class="online">

<i class="bi bi-circle-fill"></i>

Online Now

</div>

</div>

</div>

<div class="right-profile">

<div class="member">

Member Since

</div>

<h3>

2026

</h3>

<div class="points">

2450

<span>Reward Points</span>

</div>

<div class="progress">

<div
class="progress-bar"
style="width:78%">

</div>

</div>

<small>

78% to Gold Membership

</small>

</div>

</div>
<!-- ==========================================
        PERSONAL INFORMATION + STATISTICS
=========================================== -->

<div class="row">

<!-- LEFT SIDE -->

<div class="col-lg-8">

<div class="card-box mb-4">

<h3 class="section-title">

<i class="bi bi-person-vcard-fill text-primary"></i>

Personal Information

</h3>

<hr>

<div class="row">

<div class="col-md-6 mb-4">

<label class="text-muted">

Full Name

</label>

<h5>

<%=user.getName()%>

</h5>

</div>

<div class="col-md-6 mb-4">

<label class="text-muted">

Email Address

</label>

<h5>

<%=user.getEmail()%>

</h5>

</div>

<div class="col-md-6 mb-4">

<label class="text-muted">

Phone Number

</label>

<h5>

<%=user.getPhone()%>

</h5>

</div>

<div class="col-md-6 mb-4">

<label class="text-muted">

Role

</label>

<h5>

<span class="badge bg-success fs-6">

<%=user.getRole()%>

</span>

</h5>

</div>

<div class="col-12">

<label class="text-muted">

Delivery Address

</label>

<h5>

<%=user.getAddress()%>

</h5>

</div>

</div>

</div>

<!-- ORDER SUMMARY -->

<div class="card-box">

<h3 class="section-title">

<i class="bi bi-bag-check-fill text-success"></i>

Order Summary

</h3>

<hr>

<div class="row text-center">

<div class="col-md-3">

<div class="p-3 rounded"

style="background:#EEF2FF;">

<i class="bi bi-bag-fill"

style="font-size:40px;color:#4F46E5;"></i>

<h2 class="mt-2">

12

</h2>

<p class="text-muted">

Orders

</p>

</div>

</div>

<div class="col-md-3">

<div class="p-3 rounded"

style="background:#ECFDF5;">

<i class="bi bi-currency-rupee"

style="font-size:40px;color:#16A34A;"></i>

<h2 class="mt-2">

₹6,850

</h2>

<p class="text-muted">

Spent

</p>

</div>

</div>

<div class="col-md-3">

<div class="p-3 rounded"

style="background:#FFF7ED;">

<i class="bi bi-star-fill"

style="font-size:40px;color:#F59E0B;"></i>

<h2 class="mt-2">

4.9

</h2>

<p class="text-muted">

Rating

</p>

</div>

</div>

<div class="col-md-3">

<div class="p-3 rounded"

style="background:#FEF2F2;">

<i class="bi bi-heart-fill"

style="font-size:40px;color:#EF4444;"></i>

<h2 class="mt-2">

28

</h2>

<p class="text-muted">

Favorites

</p>

</div>

</div>

</div>

</div>

</div>

<!-- RIGHT SIDE -->

<div class="col-lg-4">

<div class="card-box mb-4">

<h3 class="section-title">

<i class="bi bi-award-fill text-warning"></i>

Achievements

</h3>

<hr>

<div class="mb-4">

<h6>

🥇 Food Explorer

</h6>

<div class="progress">

<div class="progress-bar bg-success"

style="width:100%;">

</div>

</div>

<small>

Completed

</small>

</div>

<div class="mb-4">

<h6>

🍕 Pizza Lover

</h6>

<div class="progress">

<div class="progress-bar bg-danger"

style="width:80%;">

</div>

</div>

<small>

80% Completed

</small>

</div>

<div class="mb-4">

<h6>

🥗 Healthy Foodie

</h6>

<div class="progress">

<div class="progress-bar bg-warning"

style="width:45%;">

</div>

</div>

<small>

45% Completed

</small>

</div>

<div>

<h6>

🏆 Gold Member

</h6>

<div class="progress">

<div class="progress-bar"

style="width:78%;background:#ff6b35;">

</div>

</div>

<small>

78% Completed

</small>

</div>

</div>

<!-- ACCOUNT STATUS -->

<div class="card-box">

<h3 class="section-title">

<i class="bi bi-shield-check text-success"></i>

Account Status

</h3>

<hr>

<div class="d-flex justify-content-between mb-3">

<span>

Email Verified

</span>

<span class="badge bg-success">

Verified

</span>

</div>

<div class="d-flex justify-content-between mb-3">

<span>

Phone Verified

</span>

<span class="badge bg-success">

Verified

</span>

</div>

<div class="d-flex justify-content-between mb-3">

<span>

Account Status

</span>

<span class="badge bg-primary">

Active

</span>

</div>

<div class="d-flex justify-content-between">

<span>

Security

</span>

<span class="badge bg-warning text-dark">

Strong

</span>

</div>

</div>

</div>

</div>
<!-- ==========================================
        RECENT ACTIVITY
========================================== -->

<div class="row mt-4">

<div class="col-lg-8">

<div class="card-box">

<h3 class="section-title">

<i class="bi bi-clock-history text-primary"></i>

Recent Activity

</h3>

<hr>

<div class="d-flex align-items-center mb-4">

<div class="bg-success text-white rounded-circle d-flex
justify-content-center align-items-center"

style="width:55px;height:55px;">

<i class="bi bi-check-lg fs-4"></i>

</div>

<div class="ms-3">

<h6 class="mb-1">

Order Delivered Successfully

</h6>

<small class="text-muted">

Your order was delivered successfully.

</small>

</div>

<div class="ms-auto text-muted">

Today

</div>

</div>

<div class="d-flex align-items-center mb-4">

<div class="bg-warning text-white rounded-circle d-flex
justify-content-center align-items-center"

style="width:55px;height:55px;">

<i class="bi bi-star-fill fs-4"></i>

</div>

<div class="ms-3">

<h6 class="mb-1">

You earned 120 Reward Points

</h6>

<small class="text-muted">

Thank you for ordering from FoodVerse.

</small>

</div>

<div class="ms-auto text-muted">

Yesterday

</div>

</div>

<div class="d-flex align-items-center">

<div class="bg-primary text-white rounded-circle d-flex
justify-content-center align-items-center"

style="width:55px;height:55px;">

<i class="bi bi-person-check-fill fs-4"></i>

</div>

<div class="ms-3">

<h6 class="mb-1">

Profile Updated

</h6>

<small class="text-muted">

Account information updated successfully.

</small>

</div>

<div class="ms-auto text-muted">

2 Days Ago

</div>

</div>

</div>

</div>

<!-- RIGHT COLUMN -->

<div class="col-lg-4">

<div class="card-box">

<h3 class="section-title">

<i class="bi bi-heart-fill text-danger"></i>

Favorite Restaurants

</h3>

<hr>

<div class="mb-3">

🍕 Domino's

</div>

<div class="mb-3">

🍔 Burger King

</div>

<div class="mb-3">

🥗 Fresh Bowl

</div>

<div>

🍜 Chinese Wok

</div>

</div>

</div>

</div>

<!-- ==========================================
        QUICK ACTIONS
========================================== -->

<div class="card-box mt-4">

<h3 class="section-title">

<i class="bi bi-lightning-charge-fill text-warning"></i>

Quick Actions

</h3>

<hr>

<div class="row text-center">

<div class="col-md-3 mb-3">

<a href="home"
class="btn btn-primary w-100 py-3">

<i class="bi bi-house-fill fs-3"></i>

<br>

Home

</a>

</div>

<div class="col-md-3 mb-3">

<a href="myOrders"
class="btn btn-success w-100 py-3">

<i class="bi bi-bag-check-fill fs-3"></i>

<br>

My Orders

</a>

</div>

<div class="col-md-3 mb-3">

<a href="#"
class="btn btn-warning w-100 py-3">

<i class="bi bi-pencil-square fs-3"></i>

<br>

Edit Profile

</a>

</div>

<div class="col-md-3 mb-3">

<a href="logout"
class="btn btn-danger w-100 py-3">

<i class="bi bi-box-arrow-right fs-3"></i>

<br>

Logout

</a>

</div>

</div>

</div>

<!-- ==========================================
        FOOTER
========================================== -->

<div class="text-center mt-5 mb-3">

<hr>

<h5 class="fw-bold">

🍽 FoodVerse

</h5>

<p class="text-muted">

Delivering Happiness, One Meal at a Time.

</p>

<p class="text-muted">

© 2026 FoodVerse | Built with ❤️ using Java, JSP, Servlets & MySQL

</p>

</div>

</div>

<script
src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

<script>

// Fade Animation

document.querySelectorAll(".card-box").forEach(function(card){

card.style.opacity="0";

card.style.transform="translateY(20px)";

});

window.onload=function(){

document.querySelectorAll(".card-box").forEach(function(card,index){

setTimeout(function(){

card.style.transition="0.5s";

card.style.opacity="1";

card.style.transform="translateY(0px)";

},index*150);

});

};

</script>

</body>

</html>