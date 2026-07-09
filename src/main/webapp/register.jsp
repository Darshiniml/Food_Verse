<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Register | FoodVerse</title>

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
rel="stylesheet">

<style>

body{

background:linear-gradient(135deg,#ff6b35,#ff914d);

height:100vh;

display:flex;

justify-content:center;

align-items:center;

font-family:'Segoe UI';

}

.register-card{

width:850px;

border-radius:20px;

padding:40px;

background:white;

box-shadow:0 15px 40px rgba(0,0,0,.25);

}

.role-card{

border:2px solid #ddd;

border-radius:15px;

padding:20px;

text-align:center;

cursor:pointer;

transition:.3s;

}

.role-card:hover{

transform:translateY(-5px);

box-shadow:0 10px 20px rgba(0,0,0,.15);

}

.role-card.active{

border:3px solid #ff6b35;

background:#fff3ed;

}

.role-card i{

font-size:35px;

color:#ff6b35;

margin-bottom:10px;

}

.btn-register{

background:#ff6b35;

color:white;

font-size:18px;

font-weight:bold;

}

.btn-register:hover{

background:#ff4f00;

color:white;

}

</style>

</head>

<body>

<div class="register-card">

<h2 class="text-center mb-4">

<i class="fa-solid fa-utensils"></i>

FoodVerse Registration

</h2>

<form action="register" method="post">

<div class="row">

<div class="col-md-6 mb-3">

<label>Name</label>

<input type="text"
name="name"
class="form-control"
required>

</div>

<div class="col-md-6 mb-3">

<label>Email</label>

<input type="email"
name="email"
class="form-control"
required>

</div>

<div class="col-md-6 mb-3">

<label>Phone</label>

<input type="text"
name="phone"
class="form-control"
required>

</div>

<div class="col-md-6 mb-3">

<label>Password</label>

<input type="password"
name="password"
class="form-control"
required>

</div>

<div class="col-12 mb-4">

<label>Address</label>

<textarea
name="address"
class="form-control"
rows="2"
required></textarea>

</div>

</div>

<h4 class="text-center mb-3">

Choose Your Role

</h4>

<input
type="hidden"
name="role"
id="role"
required>

<div class="row g-3">

<div class="col-md-3">

<div class="role-card"
onclick="selectRole(this,'CUSTOMER')">

<i class="fa-solid fa-user"></i>

<h5>Customer</h5>

</div>

</div>

<div class="col-md-3">

<div class="role-card"
onclick="selectRole(this,'RESTAURANT')">

<i class="fa-solid fa-store"></i>

<h5>Restaurant</h5>

</div>

</div>

<div class="col-md-3">

<div class="role-card"
onclick="selectRole(this,'DELIVERY_AGENT')">

<i class="fa-solid fa-motorcycle"></i>

<h5>Delivery</h5>

</div>

</div>

<div class="col-md-3">

<div class="role-card"
onclick="selectRole(this,'ADMIN')">

<i class="fa-solid fa-crown"></i>

<h5>Admin</h5>

</div>

</div>

</div>

<div class="d-grid mt-4">

<button class="btn btn-register btn-lg">

Create Account

</button>

</div>

<div class="text-center mt-4">

Already have an account?

<a href="login.jsp">

Login

</a>

</div>

</form>

</div>

<script>

function selectRole(card,role){

document.querySelectorAll(".role-card").forEach(c=>{

c.classList.remove("active");

});

card.classList.add("active");

document.getElementById("role").value=role;

}

</script>

</body>
</html>