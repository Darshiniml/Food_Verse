<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Login | FoodVerse</title>

<meta name="viewport"
content="width=device-width, initial-scale=1">

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
rel="stylesheet">

<style>

*{

margin:0;

padding:0;

box-sizing:border-box;

font-family:'Segoe UI',sans-serif;

}

body{

background:linear-gradient(135deg,#ff6b35,#ff914d);

height:100vh;

display:flex;

justify-content:center;

align-items:center;

}

.login-card{

width:500px;

background:white;

padding:45px;

border-radius:20px;

box-shadow:0 15px 40px rgba(0,0,0,.25);

animation:fadeIn .5s ease;

}

.logo{

text-align:center;

font-size:42px;

color:#ff6b35;

margin-bottom:10px;

}

.title{

text-align:center;

font-size:30px;

font-weight:bold;

margin-bottom:5px;

}

.subtitle{

text-align:center;

color:#777;

margin-bottom:30px;

}

.form-label{

font-weight:600;

}

.input-group-text{

background:#fff3ed;

border:none;

color:#ff6b35;

}

.form-control{

height:50px;

border-radius:10px;

}

.form-control:focus{

border-color:#ff6b35;

box-shadow:0 0 0 .2rem rgba(255,107,53,.15);

}

.btn-login{

background:#ff6b35;

color:white;

font-size:18px;

font-weight:bold;

padding:12px;

border:none;

border-radius:10px;

transition:.3s;

}

.btn-login:hover{

background:#ff4f00;

color:white;

transform:translateY(-2px);

}

.extra-links{

text-align:center;

margin-top:20px;

}

.extra-links a{

text-decoration:none;

font-weight:600;

color:#ff6b35;

}

.extra-links a:hover{

text-decoration:underline;

}

.alert{

border-radius:10px;

}

@keyframes fadeIn{

from{

opacity:0;

transform:translateY(25px);

}

to{

opacity:1;

transform:translateY(0);

}

}

</style>

</head>

<body>

<div class="login-card">

<div class="logo">

<i class="fa-solid fa-utensils"></i>

</div>

<div class="title">

FoodVerse Login

</div>

<div class="subtitle">

Welcome Back! Sign in to continue

</div>
<%

if(request.getParameter("error")!=null){

%>

<div class="alert alert-danger text-center">

<i class="fa-solid fa-circle-exclamation"></i>

Invalid Email or Password

</div>

<%

}

if(request.getParameter("logout")!=null){

%>

<div class="alert alert-success text-center">

<i class="fa-solid fa-circle-check"></i>

Logged out successfully.

</div>

<%

}

if(request.getParameter("registered")!=null){

%>

<div class="alert alert-success text-center">

<i class="fa-solid fa-user-check"></i>

Registration Successful! Please Login.

</div>

<%

}

%>

<form action="login" method="post">

<div class="mb-3">

<label class="form-label">

Email Address

</label>

<div class="input-group">

<span class="input-group-text">

<i class="fa-solid fa-envelope"></i>

</span>

<input

type="email"

name="email"

class="form-control"

placeholder="Enter your email"

required>

</div>

</div>

<div class="mb-4">

<label class="form-label">

Password

</label>

<div class="input-group">

<span class="input-group-text">

<i class="fa-solid fa-lock"></i>

</span>

<input

type="password"

id="password"

name="password"

class="form-control"

placeholder="Enter your password"

required>

<button

type="button"

class="input-group-text"

onclick="togglePassword()">

<i

id="eyeIcon"

class="fa-solid fa-eye">

</i>

</button>

</div>

</div>

<div class="d-flex justify-content-between align-items-center mb-4">

<div class="form-check">

<input

class="form-check-input"

type="checkbox"

id="rememberMe">

<label

class="form-check-label"

for="rememberMe">

Remember Me

</label>

</div>

<a href="#">

Forgot Password?

</a>

</div>

<div class="d-grid">

<button

type="submit"

class="btn btn-login">

<i class="fa-solid fa-right-to-bracket"></i>

Login

</button>

</div>

<div class="extra-links">

<hr>

Don't have an account?

<a href="register.jsp">

Create Account

</a>

</div>

</form>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

/*==================================
      SHOW / HIDE PASSWORD
==================================*/

function togglePassword(){

const password=document.getElementById("password");

const eye=document.getElementById("eyeIcon");

if(password.type==="password"){

password.type="text";

eye.classList.remove("fa-eye");

eye.classList.add("fa-eye-slash");

}
else{

password.type="password";

eye.classList.remove("fa-eye-slash");

eye.classList.add("fa-eye");

}

}

/*==================================
      PRESS ENTER TO LOGIN
==================================*/

document.addEventListener("keydown",function(e){

if(e.key==="Enter"){

document.querySelector("form").submit();

}

});

/*==================================
      INPUT ANIMATION
==================================*/

document.querySelectorAll(".form-control")

.forEach(function(input){

input.addEventListener("focus",function(){

this.style.transform="scale(1.02)";

this.style.transition=".25s";

});

input.addEventListener("blur",function(){

this.style.transform="scale(1)";

});

});

/*==================================
      AUTO HIDE ALERTS
==================================*/

setTimeout(function(){

const alerts=document.querySelectorAll(".alert");

alerts.forEach(function(alert){

alert.style.transition=".5s";

alert.style.opacity="0";

setTimeout(function(){

alert.remove();

},500);

});

},3000);

/*==================================
      BUTTON RIPPLE EFFECT
==================================*/

const btn=document.querySelector(".btn-login");

btn.addEventListener("click",function(e){

const circle=document.createElement("span");

const diameter=Math.max(

btn.clientWidth,

btn.clientHeight

);

const radius=diameter/2;

circle.style.width=

circle.style.height=

diameter+"px";

circle.style.left=

e.clientX-btn.offsetLeft-radius+"px";

circle.style.top=

e.clientY-btn.offsetTop-radius+"px";

circle.classList.add("ripple");

const ripple=

btn.getElementsByClassName("ripple")[0];

if(ripple){

ripple.remove();

}

btn.appendChild(circle);

});

</script>

<style>

.btn-login{

position:relative;

overflow:hidden;

}

.ripple{

position:absolute;

border-radius:50%;

transform:scale(0);

background:rgba(255,255,255,.6);

animation:ripple .6s linear;

}

@keyframes ripple{

to{

transform:scale(4);

opacity:0;

}

}

</style>

</div>

</body>

</html>