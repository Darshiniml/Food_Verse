<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="com.food_application.model.Cart"%>
<%@page import="com.food_application.model.CartItem"%>
<%@page import="com.food_application.model.User"%>

<%
Cart cart = (Cart) session.getAttribute("cart");
User user = (User) session.getAttribute("loggedUser");

if(cart == null){
    cart = new Cart();
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>FoodVerse | My Cart</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
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

/*======================
NAVBAR
======================*/

.navbar{
background:#fff;
box-shadow:0 10px 25px rgba(0,0,0,.08);
padding:16px 0;
}

.navbar-brand{
font-size:32px;
font-weight:800;
color:#F97316 !important;
}

/*======================
HERO
======================*/

.cart-banner{
background:linear-gradient(135deg,#FF6B35,#FF914D);
padding:50px;
border-radius:25px;
margin:35px 0;
color:#fff;
position:relative;
overflow:hidden;
}

.cart-banner::before{
content:"";
position:absolute;
width:220px;
height:220px;
background:rgba(255,255,255,.15);
right:-70px;
top:-70px;
border-radius:50%;
}

.cart-banner h1{
font-size:48px;
font-weight:800;
}

.cart-banner p{
margin-top:15px;
font-size:18px;
opacity:.95;
}

.banner-stats{
display:flex;
gap:40px;
margin-top:30px;
flex-wrap:wrap;
}

.banner-stat h3{
font-weight:700;
margin-bottom:0;
}

/*======================
SECTION TITLE
======================*/

.section-title{
font-size:36px;
font-weight:700;
margin-bottom:10px;
}

.section-sub{
color:#64748B;
margin-bottom:35px;
}

/*======================
CART CARD
======================*/

.cart-card{
background:#fff;
border:none;
border-radius:24px;
overflow:hidden;
box-shadow:0 15px 35px rgba(0,0,0,.08);
margin-bottom:25px;
transition:.3s;
}

.cart-card:hover{
transform:translateY(-6px);
}

.food-image{
position:relative;
}

.food-image img{
width:100%;
height:230px;
object-fit:cover;
}

.ribbon{
position:absolute;
top:18px;
left:18px;
background:#EF4444;
color:#fff;
padding:8px 14px;
border-radius:30px;
font-size:13px;
font-weight:600;
}

.favorite{
position:absolute;
right:18px;
top:18px;
width:45px;
height:45px;
background:#fff;
display:flex;
justify-content:center;
align-items:center;
border-radius:50%;
cursor:pointer;
box-shadow:0 5px 15px rgba(0,0,0,.15);
color:#EF4444;
}

.food-body{
padding:25px;
height:100%;
display:flex;
flex-direction:column;
justify-content:space-between;
}

.food-title{
font-size:28px;
font-weight:700;
}

.food-desc{
margin:18px 0;
color:#64748B;
}

.price{
font-size:28px;
font-weight:700;
color:#10B981;
white-space:nowrap;
}

.qty-btn{
width:42px;
height:42px;
border-radius:50%;
}

.available{
color:#16A34A;
font-weight:600;
}

/*======================
SUMMARY
======================*/

.summary{
background:#fff;
padding:30px;
border-radius:24px;
box-shadow:0 15px 35px rgba(0,0,0,.08);
position:sticky;
top:100px;
}

.summary h3{
font-weight:700;
margin-bottom:20px;
}

.total{
font-size:34px;
font-weight:700;
color:#10B981;
}

.checkout{
background:#F97316;
border:none;
padding:15px;
width:100%;
border-radius:40px;
font-size:18px;
font-weight:700;
color:#fff;
}

.checkout:hover{
background:#EA580C;
color:#fff;
}

.summary hr{
opacity:.15;
}

/*======================
EMPTY CART
======================*/

.empty{
text-align:center;
padding:100px 20px;
background:#fff;
border-radius:25px;
box-shadow:0 15px 35px rgba(0,0,0,.08);
}

.empty i{
font-size:100px;
color:#CBD5E1;
}

.empty h2{
margin-top:20px;
font-weight:700;
}

/*======================
FOOTER
======================*/

footer{
margin-top:80px;
background:#1E293B;
padding:60px;
color:#fff;
}

@media(max-width:992px){

.summary{
position:static;
margin-top:30px;
}

.cart-banner{
padding:35px;
}

.cart-banner h1{
font-size:36px;
}

}

</style>

</head>

<body>

<nav class="navbar navbar-expand-lg">
<div class="container">

<a class="navbar-brand" href="home">
🍽 FoodVerse
</a>

<div class="ms-auto">

<a href="home" class="btn btn-outline-warning rounded-pill">
Continue Shopping
</a>

</div>

</div>
</nav>

<div class="container">

<div class="cart-banner">

<h1>🛒 Your Shopping Cart</h1>

<p>
Almost there! Review your delicious meals and proceed to secure checkout.
</p>

<div class="banner-stats">

<div class="banner-stat">
<h3><%=cart.getItems().size()%></h3>
Items
</div>

<div class="banner-stat">
<h3>30 Min</h3>
Delivery
</div>

<div class="banner-stat">
<h3>100%</h3>
Fresh Food
</div>

</div>

</div>

<h2 class="section-title">
Cart Items
</h2>

<p class="section-sub">
Freshly prepared meals from your favourite restaurant.
</p>

<%
if(cart.getItems().isEmpty()){
%>

<div class="empty">

<i class="bi bi-cart-x"></i>

<h2>Your Cart is Empty</h2>

<p class="text-muted">
Looks like you haven't added any delicious food yet.
</p>

<a href="home"
class="btn btn-warning btn-lg rounded-pill mt-3">

🍽 Browse Restaurants

</a>

</div>

<%
}else{
%>

<div class="row">

<div class="col-lg-8">

<%
for(CartItem item : cart.getItems()){

boolean bestseller = item.getFoodItem().getPrice() >= 250;

String category = item.getFoodItem().getCategory()==null
? "Food"
: item.getFoodItem().getCategory();

boolean veg = !(category.equalsIgnoreCase("Chicken")
|| category.equalsIgnoreCase("Mutton")
|| category.equalsIgnoreCase("Seafood")
|| category.equalsIgnoreCase("Non Veg"));
%>
<div class="card cart-card">

    <div class="row g-0">

        <!-- Food Image -->
        <div class="col-lg-4">

            <div class="food-image">

                <img src="<%=item.getFoodItem().getImage()%>"
                     class="img-fluid"
                     alt="Food Image">

                <% if(bestseller){ %>

                <div class="ribbon">
                    🔥 Bestseller
                </div>

                <% } %>

                <div class="favorite">
                    <i class="bi bi-heart"></i>
                </div>

            </div>

        </div>

        <!-- Food Details -->

        <div class="col-lg-8">

            <div class="food-body">

                <div class="d-flex justify-content-between align-items-start">

                    <div>

                        <h3 class="food-title">
                            <%=item.getFoodItem().getFoodName()%>
                        </h3>

                        <div class="mt-2">

                            <span class="badge bg-success">
                                ⭐ 4.8
                            </span>

                            <span class="badge bg-warning text-dark">
                                25-30 Min
                            </span>

                            <% if(veg){ %>

                            <span class="badge bg-success">
                                🟢 Veg
                            </span>

                            <% } else { %>

                            <span class="badge bg-danger">
                                🔴 Non Veg
                            </span>

                            <% } %>

                        </div>

                    </div>

                    <div class="price">
                        ₹ <%=item.getFoodItem().getPrice()%>
                    </div>

                </div>

                <p class="food-desc">
                    <%=item.getFoodItem().getDescription()%>
                </p>

                <!-- Quantity -->

                <div class="row align-items-center">

                    <div class="col-md-6">

                        <div class="d-flex align-items-center">

                            <a href="cart?action=decrease&foodId=<%=item.getFoodItem().getFoodId()%>"
                               class="btn btn-outline-danger qty-btn">

                                <i class="bi bi-dash-lg"></i>

                            </a>

                            <span class="mx-3 fs-4 fw-bold">

                                <%=item.getQuantity()%>

                            </span>

                            <a href="cart?action=increase&foodId=<%=item.getFoodItem().getFoodId()%>"
                               class="btn btn-outline-success qty-btn">

                                <i class="bi bi-plus-lg"></i>

                            </a>

                        </div>

                    </div>

                    <div class="col-md-6 text-md-end mt-3 mt-md-0">

                        <a href="cart?action=remove&foodId=<%=item.getFoodItem().getFoodId()%>"
                           class="btn btn-outline-danger rounded-pill">

                            <i class="bi bi-trash-fill"></i>

                            Remove

                        </a>

                    </div>

                </div>

                <hr>

                <div class="d-flex justify-content-between align-items-center">

                    <span class="available">

                        <i class="bi bi-check-circle-fill"></i>

                        Freshly Available

                    </span>

                    <div>

                        <strong>Subtotal :</strong>

                        <span class="price">

                            ₹ <%=String.format("%.2f",item.getTotalPrice())%>

                        </span>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

<%
}
%>

</div>

<!-- ===========================
ORDER SUMMARY
============================ -->

<div class="col-lg-4">

<div class="summary">

<h3>
🧾 Order Summary
</h3>

<hr>

<div class="mb-4">

<label class="form-label fw-bold">
Coupon Code
</label>

<div class="input-group">

<input
type="text"
id="coupon"
class="form-control"
placeholder="Enter Coupon">

<button
class="btn btn-warning"
onclick="applyCoupon()">

Apply

</button>

</div>

<small
id="couponMessage"
class="text-success">

</small>

</div>

<div class="d-flex justify-content-between mb-3">

<span>Items Total</span>

<strong>

₹ <%=String.format("%.2f",cart.getGrandTotal())%>

</strong>

</div>

<div class="d-flex justify-content-between mb-3">

<span>Delivery Charges</span>

<span class="text-success">

FREE

</span>

</div>

<div class="d-flex justify-content-between mb-3">

<span>Platform Fee</span>

<span>

₹ 10.00

</span>

</div>

<div class="d-flex justify-content-between mb-3">

<span>GST (5%)</span>

<span>

₹ <%=String.format("%.2f",cart.getGrandTotal()*0.05)%>

</span>

</div>

<div class="d-flex justify-content-between mb-3">

<span>Savings</span>

<span class="text-success">

- ₹ 50.00

</span>

</div>

<hr>

<div class="d-flex justify-content-between align-items-center">

<h4>
Grand Total
</h4>

<div class="total">

₹ <%=String.format("%.2f",
Math.max(0,
cart.getGrandTotal()
+10
+(cart.getGrandTotal()*0.05)
-50))%>

</div>

</div>

<div class="alert alert-success mt-4">

<i class="bi bi-shield-check"></i>

100% Secure Payment via Razorpay

</div>

<a href="checkout.jsp"
class="btn checkout text-decoration-none">

<i class="bi bi-credit-card-fill"></i>

Proceed To Checkout

</a>

<div class="text-center mt-4">

<img
src="https://upload.wikimedia.org/wikipedia/commons/8/89/Razorpay_logo.svg"
height="28"
alt="Razorpay">

<br><br>

<small class="text-muted">

Safe • Secure • Encrypted

</small>

</div>

</div>

</div>

</div>

<%
}
%>
<!-- ===========================
     FOOTER
=========================== -->

<footer>

<div class="container">

<div class="row text-center text-lg-start">

<div class="col-lg-4 mb-4">

<h2>🍽 FoodVerse</h2>

<p>
India's Favourite Food Delivery Platform
</p>

</div>

<div class="col-lg-4 mb-4">

<h5>Quick Links</h5>

<p><a href="home" class="text-white text-decoration-none">Home</a></p>

<p><a href="restaurants" class="text-white text-decoration-none">Restaurants</a></p>

<p><a href="cart" class="text-white text-decoration-none">Cart</a></p>

<p><a href="orders" class="text-white text-decoration-none">Orders</a></p>

</div>

<div class="col-lg-4 mb-4">

<h5>Support</h5>

<p>📞 +91 9876543210</p>

<p>📧 support@foodverse.com</p>

<p>📍 Bangalore, India</p>

</div>

</div>

<hr class="border-light">

<p class="text-center mb-0">

© 2026 FoodVerse

<br>

Made with ❤️ using Java, JSP, Servlets & MySQL

</p>

</div>

</footer>

<!-- ===========================
     BOOTSTRAP JS
=========================== -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- ===========================
     JAVASCRIPT
=========================== -->

<script>

// ---------------- Coupon ----------------

function applyCoupon(){

    const code = document.getElementById("coupon").value.trim();

    const message = document.getElementById("couponMessage");

    message.classList.remove("text-success","text-danger");

    if(code.toUpperCase() === "FOOD50"){

        message.classList.add("text-success");

        message.innerHTML =
        "🎉 Coupon Applied Successfully!";

    }
    else{

        message.classList.add("text-danger");

        message.innerHTML =
        "❌ Invalid Coupon Code";

    }

}


// ---------------- Favourite Button ----------------

document.querySelectorAll(".favorite").forEach(function(btn){

    btn.addEventListener("click",function(){

        const icon = btn.querySelector("i");

        icon.classList.toggle("bi-heart");

        icon.classList.toggle("bi-heart-fill");

    });

});


// ---------------- Smooth Card Animation ----------------

document.querySelectorAll(".cart-card").forEach(function(card){

    card.addEventListener("mouseenter",function(){

        card.style.transform="translateY(-8px)";

    });

    card.addEventListener("mouseleave",function(){

        card.style.transform="translateY(0px)";

    });

});


// ---------------- Checkout Validation ----------------

const checkoutBtn=document.querySelector(".checkout");

if(checkoutBtn){

checkoutBtn.addEventListener("click",function(e){

<%
if(cart.getItems().isEmpty()){
%>

e.preventDefault();

alert("Your cart is empty!");

<%
}
%>

});

}

</script>

</body>

</html>