<<<<<<< HEAD
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<div class="sidebar">

    <div class="logo">
        🍽 <span>FoodVerse</span>
    </div>

    <a href="<%=request.getContextPath()%>/adminDashboard">
        <i class="bi bi-speedometer2"></i>
        <span>Dashboard</span>
    </a>

    <a href="<%=request.getContextPath()%>/manageUsers">
        <i class="bi bi-people-fill"></i>
        <span>Users</span>
    </a>

    <a href="<%=request.getContextPath()%>/manageRestaurants">
        <i class="bi bi-shop"></i>
        <span>Restaurants</span>
    </a>

    <a href="<%=request.getContextPath()%>/manageFood">
        <i class="bi bi-egg-fried"></i>
        <span>Food Menu</span>
    </a>

    <a href="<%=request.getContextPath()%>/manageOrders">
        <i class="bi bi-bag-check-fill"></i>
        <span>Orders</span>
    </a>

    

    

    <hr style="border-color:#334155; margin:20px 0;">

    <a href="<%=request.getContextPath()%>/logout">
        <i class="bi bi-box-arrow-right"></i>
        <span>Logout</span>
    </a>
=======
%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<div class="sidebar">

<div class="logo">

🍽 FoodVerse

</div>

<a href="../adminDashboard">

<i class="bi bi-speedometer2"></i>

Dashboard

</a>

<a href="../manageRestaurants">

<i class="bi bi-shop"></i>

Restaurants

</a>

<a href="../manageFood">

<i class="bi bi-egg-fried"></i>

Food Menu

</a>

<a href="../manageOrders">

<i class="bi bi-bag-check-fill"></i>

Orders

</a>

<a href="../manageUsers">

<i class="bi bi-people-fill"></i>

Users

</a>

<a href="../payments">

<i class="bi bi-credit-card"></i>

Payments

</a>

<a href="../analytics">

<i class="bi bi-bar-chart-fill"></i>

Analytics

</a>

<a href="../logout">

<i class="bi bi-box-arrow-right"></i>

Logout

</a>
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

</div>