<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<div class="sidebar">

    <div class="logo">

        🍽 FoodVerse

    </div>

    <a href="<%=request.getContextPath()%>/adminDashboard">

        <i class="bi bi-speedometer2"></i>

        Dashboard

    </a>

    <a href="<%=request.getContextPath()%>/manageUsers">

        <i class="bi bi-people-fill"></i>

        Users

    </a>

    <a href="<%=request.getContextPath()%>/manageRestaurants">

        <i class="bi bi-shop"></i>

        Restaurants

    </a>

    <a href="<%=request.getContextPath()%>/manageFood">

        <i class="bi bi-egg-fried"></i>

        Food Menu

    </a>

    <a href="<%=request.getContextPath()%>/manageOrders">

        <i class="bi bi-bag-check-fill"></i>

        Orders

    </a>

    <a href="<%=request.getContextPath()%>/payments">

        <i class="bi bi-credit-card"></i>

        Payments

    </a>

    <a href="<%=request.getContextPath()%>/analytics">

        <i class="bi bi-bar-chart-fill"></i>

        Analytics

    </a>

    <hr>

    <a href="<%=request.getContextPath()%>/logout">

        <i class="bi bi-box-arrow-right"></i>

        Logout

    </a>

</div>