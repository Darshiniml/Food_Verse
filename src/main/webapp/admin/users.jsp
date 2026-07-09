

<%@page language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="com.food_application.model.User"%>

<%
List<User> users =
(List<User>)request.getAttribute("users");
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>User Management</title>

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

.main{

padding:30px;

}

.page-title{

font-size:30px;

font-weight:700;

}

.card-box{

background:white;

padding:25px;

border-radius:15px;

box-shadow:0 8px 20px rgba(0,0,0,.08);

}

.role{

padding:6px 14px;

border-radius:20px;

color:white;

font-size:12px;

font-weight:bold;

}

.admin{

background:#DC2626;

}

.customer{

background:#2563EB;

}

.restaurant{

background:#16A34A;

}

.delivery{

background:#EA580C;

}

</style>

</head>

<body>




<div class="d-flex
justify-content-between
align-items-center
mb-4">

<div>

<h2 class="page-title">

User Management

</h2>

<p class="text-muted">

Manage all registered users.

</p>

</div>

</div>

<div class="row mb-4">

<div class="col-md-4">

<input

id="searchUser"

class="form-control"

placeholder="Search User...">

</div>

<div class="col-md-3">

<select

id="roleFilter"

class="form-select">

<option value="">

All Roles

</option>

<option>

ADMIN

</option>

<option>

CUSTOMER

</option>

<option>

RESTAURANT

</option>

<option>

DELIVERY_AGENT

</option>

</select>

</div>

</div>

<div class="card-box">

<table

class="table table-hover align-middle"

id="userTable">

<thead>

<tr>

<th>ID</th>

<th>Name</th>

<th>Email</th>

<th>Phone</th>

<th>Role</th>

<th width="170">

Action

</th>

</tr>

</thead>

<tbody>

<%

if(users!=null){

for(User user:users){

%>

<tr>

<td>

#<%=user.getUserId()%>

</td>

<td>

<b>

<%=user.getName()%>

</b>

</td>

<td>

<%=user.getEmail()%>

</td>

<td>

<%=user.getPhone()%>

</td>

<td>
<%

String role = user.getRole();

// Null Safety
if(role == null || role.trim().isEmpty()){

    role = "CUSTOMER";

}

String css = "customer";

if("ADMIN".equalsIgnoreCase(role)){

    css = "admin";

}else if("RESTAURANT".equalsIgnoreCase(role)){

    css = "restaurant";

}else if("DELIVERY_AGENT".equalsIgnoreCase(role)){

    css = "delivery";

}

%>

<span class="role <%=css%>">

<%=role.replace("_"," ")%>

</span>
<%

User loggedUser =
(User)session.getAttribute("loggedUser");

if(loggedUser!=null &&
loggedUser.getUserId()!=user.getUserId()){

%>

<a

href="<%=request.getContextPath()%>/deleteUser?id=<%=user.getUserId()%>"

class="btn btn-danger btn-sm"

onclick="return confirm('Are you sure you want to delete this user?');">

<i class="bi bi-trash-fill"></i>

Delete

</a>

<%

}else{

%>

<button

class="btn btn-secondary btn-sm"

disabled>

Current Admin

</button>

<%

}

%>

</td>

</tr>

<%

}

}else{

%>

<tr>

<td colspan="6" class="text-center py-5">

<i

class="bi bi-people"

style="font-size:70px;color:#CBD5E1;">

</i>

<h4 class="mt-3">

No Users Found

</h4>

<p class="text-muted">

There are no registered users.

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

<div class="card-box">

<h5>

Role Information

</h5>

<hr>

<p>

<span class="role admin">

ADMIN

</span>

System Administrator

</p>

<p>

<span class="role customer">

CUSTOMER

</span>

Places food orders

</p>

<p>

<span class="role restaurant">

RESTAURANT

</span>

Restaurant Owner

</p>

<p>

<span class="role delivery">

DELIVERY_AGENT

</span>

Delivery Partner

</p>

</div>

</div>

<div class="col-md-6">

<div class="card-box">

<h5>

Quick Actions

</h5>

<hr>

<a

href="adminDashboard"

class="btn btn-primary w-100 mb-3">

<i class="bi bi-speedometer2"></i>

Dashboard

</a>

<a

href="manageRestaurants"

class="btn btn-success w-100 mb-3">

<i class="bi bi-shop"></i>

Manage Restaurants

</a>

<a

href="manageOrders"

class="btn btn-warning w-100">

<i class="bi bi-box-seam"></i>

Manage Orders

</a>

</div>

</div>

</div>
<br>

<div class="text-center text-muted">

<hr>

<p>

FoodVerse Admin Portal

<br>

© 2026 All Rights Reserved

</p>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

/*==========================================
        SEARCH USER
==========================================*/

document.getElementById("searchUser")
.addEventListener("keyup",function(){

    let value=this.value.toLowerCase();

    let rows=document.querySelectorAll("#userTable tbody tr");

    rows.forEach(function(row){

        let text=row.innerText.toLowerCase();

        row.style.display=text.includes(value)
        ? ""
        : "none";

    });

});


/*==========================================
        ROLE FILTER
==========================================*/

document.getElementById("roleFilter")
.addEventListener("change",function(){

    let role=this.value.toLowerCase();

    let rows=document.querySelectorAll("#userTable tbody tr");

    rows.forEach(function(row){

        if(role===""){

            row.style.display="";

            return;

        }

        let userRole=row.cells[4].innerText.toLowerCase();

        row.style.display=userRole.includes(role)
        ? ""
        : "none";

    });

});


/*==========================================
        SUCCESS TOAST
==========================================*/

const params=new URLSearchParams(window.location.search);

if(params.get("deleted")){

    showToast("User Deleted Successfully","danger");

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

</script>

</body>

</html>