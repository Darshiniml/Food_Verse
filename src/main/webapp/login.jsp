<%@ page language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Login | FoodVerse</title>

<meta name="viewport"
content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<style>

*{

margin:0;
padding:0;
box-sizing:border-box;

}

body{

font-family:'Segoe UI',sans-serif;

display:flex;

justify-content:center;

align-items:center;

min-height:100vh;

background:linear-gradient(135deg,
#0F172A,
#1E3A8A,
#38BDF8);

overflow:hidden;

}

.circle{

position:absolute;

border-radius:50%;

filter:blur(90px);

opacity:.25;

}

.c1{

width:320px;

height:320px;

background:#60A5FA;

top:-100px;

left:-100px;

}

.c2{

width:280px;

height:280px;

background:#A855F7;

bottom:-80px;

right:-80px;

}

.login-card{

width:100%;

max-width:450px;

padding:40px;

border-radius:22px;

background:rgba(255,255,255,.12);

backdrop-filter:blur(18px);

box-shadow:0 10px 35px rgba(0,0,0,.25);

color:white;

}

.logo{

font-size:36px;

font-weight:bold;

text-align:center;

margin-bottom:10px;

}

.subtitle{

text-align:center;

color:#E2E8F0;

margin-bottom:30px;

}

.form-control{

height:52px;

border-radius:12px;

background:rgba(255,255,255,.15);

border:1px solid rgba(255,255,255,.2);

color:white;

}

.form-control::placeholder{

color:#CBD5E1;

}

.form-control:focus{

background:rgba(255,255,255,.20);

color:white;

border-color:#93C5FD;

box-shadow:none;

}

.input-group-text{

background:rgba(255,255,255,.15);

border:none;

color:white;

}

.btn-login{

height:50px;

border:none;

border-radius:12px;

background:#2563EB;

font-weight:bold;

transition:.3s;

}

.btn-login:hover{

background:#1D4ED8;

transform:translateY(-2px);

}

a{

color:#BFDBFE;

text-decoration:none;

}

a:hover{

color:white;

}

</style>

</head>

<body>

<div class="circle c1"></div>

<div class="circle c2"></div>

<div class="login-card">

<div class="logo">

🍽 FoodVerse

</div>

<p class="subtitle">

Welcome Back

</p>

<%

if(request.getParameter("success")!=null){

%>

<div class="alert alert-success">

Registration Successful!

Please Login.

</div>

<%

}

if(request.getParameter("error")!=null){

%>

<div class="alert alert-danger">

Invalid Email or Password

</div>

<%

}

%>

<form action="login" method="post">

<div class="mb-3">

<label>Email</label>

<div class="input-group">

<span class="input-group-text">

<i class="bi bi-envelope-fill"></i>

</span>

<input

type="email"

name="email"

class="form-control"

placeholder="Enter Email"

required>

</div>

</div>

<div class="mb-3">

<label>Password</label>

<div class="input-group">

<span class="input-group-text">

<i class="bi bi-lock-fill"></i>

</span>

<input

id="password"

type="password"

name="password"

class="form-control"

placeholder="Enter Password"

required>

<button

type="button"

class="input-group-text"

onclick="togglePassword()">

<i id="eyeIcon"

class="bi bi-eye">

</i>

</button>

</div>

</div>
<div class="d-flex
justify-content-between
align-items-center
mb-4">

<div class="form-check">

<input

class="form-check-input"

type="checkbox"

id="rememberMe"

name="rememberMe">

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

<button

type="submit"

class="btn btn-login w-100">

<i class="bi bi-box-arrow-in-right"></i>

Login

</button>

<div class="text-center mt-4">

Don't have an account?

<a href="register.jsp">

<b>

Create Account

</b>

</a>

</div>

<hr class="my-4" style="border-color:rgba(255,255,255,.2);">

<div class="text-center">

<p class="mb-3">

Or continue with

</p>

<div class="d-flex
justify-content-center
gap-3">

<button

type="button"

class="btn btn-light rounded-circle"

style="width:50px;height:50px;">

<i class="bi bi-google text-danger"></i>

</button>

<button

type="button"

class="btn btn-light rounded-circle"

style="width:50px;height:50px;">

<i class="bi bi-facebook text-primary"></i>

</button>

<button

type="button"

class="btn btn-light rounded-circle"

style="width:50px;height:50px;">

<i class="bi bi-github"></i>

</button>

</div>

</div>

<div class="text-center mt-4">

<small style="color:#CBD5E1;">

Secure Login Protected by BCrypt Encryption

</small>

</div>
</form>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

/*=====================================
        SHOW PASSWORD
=====================================*/

function togglePassword(){

    const password =
    document.getElementById("password");

    const eye =
    document.getElementById("eyeIcon");

    if(password.type==="password"){

        password.type="text";

        eye.classList.remove("bi-eye");

        eye.classList.add("bi-eye-slash");

    }
    else{

        password.type="password";

        eye.classList.remove("bi-eye-slash");

        eye.classList.add("bi-eye");

    }

}


/*=====================================
      INPUT ANIMATION
=====================================*/

const inputs=document.querySelectorAll(".form-control");

inputs.forEach(function(input){

    input.addEventListener("focus",function(){

        this.style.transform="scale(1.02)";
        this.style.transition=".25s";

    });

    input.addEventListener("blur",function(){

        this.style.transform="scale(1)";

    });

});


/*=====================================
      TOAST MESSAGE
=====================================*/

const params=new URLSearchParams(window.location.search);

if(params.get("success")){

    showToast(
    "Registration Successful! Please Login.",
    "success");

}

if(params.get("error")){

    showToast(
    "Invalid Email or Password.",
    "danger");

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