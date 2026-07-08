<<<<<<< HEAD
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
=======
<%@ page language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Login | FoodVerse</title>

<<<<<<< HEAD
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
=======
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
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

display:flex;

justify-content:center;

align-items:center;

<<<<<<< HEAD
font-family:'Segoe UI';
=======
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
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

}

.login-card{

<<<<<<< HEAD
width:480px;

border-radius:20px;

padding:40px;

background:white;

box-shadow:0 15px 40px rgba(0,0,0,.25);
=======
width:100%;

max-width:450px;

padding:40px;

border-radius:22px;

background:rgba(255,255,255,.12);

backdrop-filter:blur(18px);

box-shadow:0 10px 35px rgba(0,0,0,.25);

color:white;
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

}

.logo{

<<<<<<< HEAD
text-align:center;

margin-bottom:25px;

}

.logo i{

font-size:55px;

color:#ff6b35;

=======
font-size:36px;

font-weight:bold;

text-align:center;

>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
margin-bottom:10px;

}

<<<<<<< HEAD
.logo h2{

font-weight:bold;

margin-bottom:5px;

}

.logo p{

color:#666;
=======
.subtitle{

text-align:center;

color:#E2E8F0;

margin-bottom:30px;
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

}

.form-control{

<<<<<<< HEAD
height:48px;

border-radius:10px;

}

.input-group-text{

background:white;

border-right:none;

}

.form-control{

border-left:none;
=======
height:52px;

border-radius:12px;

background:rgba(255,255,255,.15);

border:1px solid rgba(255,255,255,.2);

color:white;

}

.form-control::placeholder{

color:#CBD5E1;
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

}

.form-control:focus{

<<<<<<< HEAD
box-shadow:none;

border-color:#ced4da;
=======
background:rgba(255,255,255,.20);

color:white;

border-color:#93C5FD;

box-shadow:none;

}

.input-group-text{

background:rgba(255,255,255,.15);

border:none;

color:white;
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

}

.btn-login{

<<<<<<< HEAD
background:#ff6b35;

color:white;

font-size:18px;

font-weight:bold;

padding:12px;

border-radius:10px;

=======
height:50px;

border:none;

border-radius:12px;

background:#2563EB;

font-weight:bold;

>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
transition:.3s;

}

.btn-login:hover{

<<<<<<< HEAD
background:#ff4f00;
=======
background:#1D4ED8;

transform:translateY(-2px);

}

a{

color:#BFDBFE;

text-decoration:none;

}

a:hover{
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

color:white;

}

<<<<<<< HEAD
.divider{

margin:20px 0;

text-align:center;

color:#999;

}

.alert{

border-radius:10px;

}

=======
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
</style>

</head>

<body>

<<<<<<< HEAD
=======
<div class="circle c1"></div>

<div class="circle c2"></div>

>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
<div class="login-card">

<div class="logo">

<<<<<<< HEAD
<i class="fa-solid fa-utensils"></i>

<h2>FoodVerse</h2>

<p>Welcome Back! Login to continue.</p>
=======
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
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

</div>

<%

<<<<<<< HEAD
String error=request.getParameter("error");

if(error!=null){
=======
}

if(request.getParameter("error")!=null){
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

%>

<div class="alert alert-danger">

<<<<<<< HEAD
<i class="fa-solid fa-circle-exclamation"></i>

=======
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
Invalid Email or Password

</div>

<%

}

%>

<form action="login" method="post">

<div class="mb-3">

<<<<<<< HEAD
<label class="form-label">

Email Address

</label>
=======
<label>Email</label>
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

<div class="input-group">

<span class="input-group-text">

<<<<<<< HEAD
<i class="fa-solid fa-envelope"></i>
=======
<i class="bi bi-envelope-fill"></i>
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

</span>

<input

type="email"

name="email"

class="form-control"

<<<<<<< HEAD
placeholder="Enter your email"
=======
placeholder="Enter Email"
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

required>

</div>

</div>

<<<<<<< HEAD
<div class="mb-4">

<label class="form-label">

Password

</label>
=======
<div class="mb-3">

<label>Password</label>
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

<div class="input-group">

<span class="input-group-text">

<<<<<<< HEAD
<i class="fa-solid fa-lock"></i>
=======
<i class="bi bi-lock-fill"></i>
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

</span>

<input

<<<<<<< HEAD
=======
id="password"

>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
type="password"

name="password"

class="form-control"

<<<<<<< HEAD
placeholder="Enter your password"

required>

</div>

</div>

<div class="d-grid">

<button class="btn btn-login">

<i class="fa-solid fa-right-to-bracket"></i>

Login
=======
placeholder="Enter Password"

required>

<button

type="button"

class="input-group-text"

onclick="togglePassword()">

<i id="eyeIcon"

class="bi bi-eye">

</i>
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

</button>

</div>

<<<<<<< HEAD
=======
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

>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
<div class="text-center mt-4">

Don't have an account?

<a href="register.jsp">

<<<<<<< HEAD
Register Here
=======
<b>

Create Account

</b>
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

</a>

</div>

<<<<<<< HEAD
=======
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
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
</form>

</div>

<<<<<<< HEAD
<script
src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
=======
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

>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
</script>

</body>

</html>