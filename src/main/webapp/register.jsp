<<<<<<< HEAD
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
=======
<%@ page language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Create Account | FoodVerse</title>

<meta name="viewport"
content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>

*{

margin:0;
padding:0;
box-sizing:border-box;

}

body{

font-family:'Segoe UI',sans-serif;

min-height:100vh;
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

display:flex;

justify-content:center;

align-items:center;

<<<<<<< HEAD
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

=======
background:linear-gradient(135deg,
#0F172A,
#1E3A8A,
#38BDF8);

overflow:hidden;

}

.bg-circle{

position:absolute;

border-radius:50%;

filter:blur(80px);

opacity:.25;

}

.circle1{

width:350px;
height:350px;

background:#60A5FA;

top:-80px;
left:-100px;

}

.circle2{

width:280px;
height:280px;

background:#818CF8;

bottom:-80px;
right:-80px;

}

.card{

width:100%;
max-width:520px;

border:none;

border-radius:22px;

background:rgba(255,255,255,.12);

backdrop-filter:blur(18px);

padding:35px;

box-shadow:0 10px 40px rgba(0,0,0,.25);

color:white;

}

.logo{

font-size:34px;

font-weight:700;

text-align:center;

>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
margin-bottom:10px;

}

<<<<<<< HEAD
.btn-register{

background:#ff6b35;

color:white;

font-size:18px;

font-weight:bold;

=======
.subtitle{

text-align:center;

margin-bottom:30px;

color:#E2E8F0;

}

.form-control,
.form-select{

height:50px;

border-radius:12px;

background:rgba(255,255,255,.15);

border:1px solid rgba(255,255,255,.2);

color:white;

}

.form-control::placeholder{

color:#CBD5E1;

}

.form-control:focus,
.form-select:focus{

background:rgba(255,255,255,.2);

color:white;

box-shadow:none;

border-color:#93C5FD;

}

textarea{

background:rgba(255,255,255,.15)!important;

color:white!important;

}

textarea::placeholder{

color:#CBD5E1;

}

.input-group-text{

background:rgba(255,255,255,.15);

border:none;

color:white;

}

.btn-register{

height:50px;

border-radius:12px;

background:#2563EB;

border:none;

font-weight:bold;

transition:.3s;

>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
}

.btn-register:hover{

<<<<<<< HEAD
background:#ff4f00;
=======
transform:translateY(-2px);

background:#1D4ED8;

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
=======
.alert{

border-radius:12px;

}

>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
</style>

</head>

<body>

<<<<<<< HEAD
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
=======
<div class="bg-circle circle1"></div>

<div class="bg-circle circle2"></div>

<div class="card">

<div class="logo">

🍽 FoodVerse

</div>

<div class="subtitle">

Create your account

</div>

<%

if(request.getParameter("exists")!=null){

%>

<div class="alert alert-danger">

<i class="bi bi-exclamation-circle-fill"></i>

Email already exists.

</div>

<%

}

%>

<form action="register" method="post">

<div class="mb-3">

<label class="form-label">

Full Name

</label>

<div class="input-group">

<span class="input-group-text">

<i class="bi bi-person-fill"></i>

</span>

<input

type="text"

name="name"

class="form-control"

placeholder="Enter your full name"

required>

</div>

</div>

<div class="mb-3">

<label class="form-label">

Email

</label>

<div class="input-group">

<span class="input-group-text">

<i class="bi bi-envelope-fill"></i>

</span>

<input

type="email"

name="email"

class="form-control"

placeholder="Enter email"

required>
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

</div>

</div>

<<<<<<< HEAD
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
=======
<div class="mb-3">

<label class="form-label">

Password

</label>

<div class="input-group">

<span class="input-group-text">

<i class="bi bi-lock-fill"></i>

</span>

<input

id="password"

type="password"

name="password"

class="form-control"

placeholder="Create password"

required>

<button

type="button"

class="input-group-text"

onclick="togglePassword()">

<i id="eyeIcon"

class="bi bi-eye"></i>
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

</button>

</div>

<<<<<<< HEAD
=======
<div id="strength"

class="mt-2 small"></div>

</div>
<div class="mb-3">

<label class="form-label">

Phone Number

</label>

<div class="input-group">

<span class="input-group-text">

<i class="bi bi-telephone-fill"></i>

</span>

<input

type="tel"

name="phone"

class="form-control"

placeholder="Enter phone number"

pattern="[0-9]{10}"

maxlength="10"

required>

</div>

</div>

<div class="mb-3">

<label class="form-label">

Address

</label>

<div class="input-group">

<span class="input-group-text">

<i class="bi bi-geo-alt-fill"></i>

</span>

<textarea

name="address"

class="form-control"

rows="3"

placeholder="Enter your address"

required>

</textarea>

</div>

</div>

<div class="mb-3">

<label class="form-label">

Select Role

</label>

<div class="input-group">

<span class="input-group-text">

<i class="bi bi-person-badge-fill"></i>

</span>

<select

name="role"

class="form-select"

required>

<option value="">

Choose your role

</option>

<option value="CUSTOMER">

👤 Customer

</option>

<option value="RESTAURANT">

🍽 Restaurant Owner

</option>

<option value="DELIVERY_AGENT">

🛵 Delivery Partner

</option>

</select>

</div>

</div>

<div class="form-check mb-4">

<input

class="form-check-input"

type="checkbox"

id="terms"

required>

<label

class="form-check-label"

for="terms">

I agree to the

<a href="#">

Terms & Conditions

</a>

</label>

</div>

<button

type="submit"

class="btn btn-register w-100">

<i class="bi bi-person-plus-fill"></i>

Create Account

</button>

>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
<div class="text-center mt-4">

Already have an account?

<a href="login.jsp">

<<<<<<< HEAD
Login
=======
<b>

Login Here

</b>
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

</a>

</div>

</form>
<<<<<<< HEAD

</div>

<script>

function selectRole(card,role){

document.querySelectorAll(".role-card").forEach(c=>{

c.classList.remove("active");

});

card.classList.add("active");

document.getElementById("role").value=role;
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
      PASSWORD STRENGTH
=====================================*/

const pass=document.getElementById("password");

const strength=document.getElementById("strength");

pass.addEventListener("keyup",function(){

    const value=this.value;

    let score=0;

    if(value.length>=8) score++;

    if(/[A-Z]/.test(value)) score++;

    if(/[0-9]/.test(value)) score++;

    if(/[!@#$%^&*(),.?":{}|<>]/.test(value)) score++;

    switch(score){

        case 0:

        case 1:

            strength.innerHTML=
            "<span class='text-danger'>Weak Password</span>";

            break;

        case 2:

            strength.innerHTML=
            "<span class='text-warning'>Medium Password</span>";

            break;

        case 3:

            strength.innerHTML=
            "<span style='color:#4ADE80;'>Strong Password</span>";

            break;

        case 4:

            strength.innerHTML=
            "<span style='color:#22C55E;font-weight:bold;'>Very Strong Password ✔</span>";

            break;

    }

});


/*=====================================
      INPUT ANIMATION
=====================================*/

const inputs=document.querySelectorAll(".form-control,.form-select");

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
      SUCCESS MESSAGE
=====================================*/

const params=new URLSearchParams(window.location.search);

if(params.get("success")){

    showToast("Registration Successful! Please Login.","success");

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
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

}

</script>

</body>
<<<<<<< HEAD
=======

>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
</html>