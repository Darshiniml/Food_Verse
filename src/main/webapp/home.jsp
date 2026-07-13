<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.food_application.model.Restaurant"%>
<%@page import="com.food_application.model.User"%>

<%
List<Restaurant> restaurants = (List<Restaurant>)request.getAttribute("restaurants");
User user = (User)session.getAttribute("loggedUser");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>FoodVerse | Home</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<style>
*{ margin:0; padding:0; box-sizing:border-box; font-family:'Poppins',sans-serif; }
body{ background:#F8FAFC; overflow-x:hidden; }

/*================================ NAVBAR ================================*/
.navbar{ background:white; padding:18px 0; position:sticky; top:0; z-index:999; box-shadow:0 10px 25px rgba(0,0,0,.08); }
.navbar-brand{ font-size:34px; font-weight:800; color:#F97316!important; }
.nav-link{ font-weight:600; margin-left:18px; transition:.3s; }
.nav-link:hover{ color:#F97316!important; }
.btn-login{ border-radius:30px; padding:10px 20px; font-weight:600; }
.btn-register{ background:#F97316; color:white; border-radius:30px; padding:10px 22px; font-weight:600; }
.btn-register:hover{ background:#EA580C; color:white; }

/*================================ HERO ================================*/
.hero-section {
  position: relative;
  width: 100vw;
  height: 85vh; 
  min-height: 500px;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  background: #000; /* Prevent white flashes during video transitions */
}

.hero-video {
  position: absolute;
  top: 0;
  left: 0;
  width: 100vw;
  height: 120%;
  object-fit: cover;
}

/* Classes for seamless crossfading transitions */
.active-video {
  opacity: 1;
  z-index: 1;
  transition: opacity 0.8s ease-in-out;
}

.inactive-video {
  opacity: 0;
  z-index: 0;
  transition: opacity 0.8s ease-in-out;
}

.hero-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.45); 
  z-index: 2;
}

.hero-content {
  position: relative;
  z-index: 3;
  color: white;
  width: 100%;
  padding: 0 20px;
}

.hero-content h1 {
  font-size: 64px;
  font-weight: 800;
  line-height: 1.2;
  text-shadow: 0 4px 15px rgba(0,0,0,0.4);
}

.hero-content p {
  font-size: 22px;
  margin-top: 20px;
  opacity: 0.95;
  text-shadow: 0 2px 10px rgba(0,0,0,0.4);
}

/*================================ SEARCH ================================*/
.search-box {
  margin-top: 40px;
  display: flex;
  background: white;
  padding: 8px;
  border-radius: 50px;
  box-shadow: 0 15px 35px rgba(0,0,0,0.25);
  max-width: 650px;
  margin-left: auto;
  margin-right: auto;
}

.search-box input {
  flex: 1;
  border: none;
  outline: none;
  padding: 15px 25px;
  font-size: 17px;
  border-radius: 40px;
  color: #1E293B;
}

.search-btn {
  background: #F97316;
  color: white;
  border: none;
  padding: 15px 40px;
  border-radius: 40px;
  font-size: 17px;
  font-weight: 600;
  transition: 0.3s;
  display: flex;
  align-items: center;
  gap: 8px;
}

.search-btn:hover {
  background: #EA580C;
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(234, 88, 12, 0.3);
}

/*================================ STATISTICS ================================*/
.stats{ display:grid; grid-template-columns:repeat(4,1fr); gap:25px; margin:50px 0; }
.stat-card{ background:white; padding:28px; border-radius:20px; box-shadow:0 12px 30px rgba(0,0,0,.08); transition:.35s; text-align:center; }
.stat-card:hover{ transform:translateY(-8px); }
.stat-icon{ font-size:42px; margin-bottom:12px; }
.stat-number{ font-size:34px; font-weight:700; color:#F97316; }
.stat-title{ color:#64748B; }

/*================================ SECTION TITLE ================================*/
.section-title{ font-size:42px; font-weight:700; text-align:center; margin:60px 0 15px; color:#1E293B; }
.section-sub{ text-align:center; color:#64748B; margin-bottom:40px; }

/*================================ CATEGORY ================================*/
.category-list{ display:flex; gap:18px; flex-wrap:wrap; justify-content:center; margin-bottom:50px; }
.category{ background:white; padding:15px 25px; border-radius:40px; font-weight:600; cursor:pointer; box-shadow:0 5px 15px rgba(0,0,0,.08); transition:.3s; }
.category:hover{ background:#F97316; color:white; transform:translateY(-5px); }

/*================================ RESTAURANT CARD ================================*/
.restaurant-card{ background:white; border-radius:25px; overflow:hidden; box-shadow:0 15px 35px rgba(0,0,0,.08); transition:.35s; height:100%; position:relative; }
.restaurant-card:hover{ transform:translateY(-10px); }
.restaurant-card img{ width:100%; height:240px; object-fit:cover; }
.ribbon{ position:absolute; top:18px; left:18px; background:#EF4444; color:white; padding:8px 16px; border-radius:30px; font-size:13px; font-weight:600; }
.favorite{ position:absolute; top:18px; right:18px; width:45px; height:45px; border-radius:50%; background:white; display:flex; justify-content:center; align-items:center; box-shadow:0 5px 15px rgba(0,0,0,.15); font-size:20px; color:#EF4444; cursor:pointer; }
.restaurant-body{ padding:25px; }
.restaurant-name{ font-size:25px; font-weight:700; margin-bottom:10px; }
.rating{ background:#16A34A; color:white; padding:6px 12px; border-radius:20px; font-size:13px; font-weight:600; }
.cuisine{ background:#FFF7ED; color:#EA580C; padding:6px 14px; border-radius:20px; font-size:13px; font-weight:600; }
.delivery{ color:#64748B; font-size:15px; margin-top:12px; }
.explore-btn{ width:100%; margin-top:20px; padding:14px; background:#F97316; color:white; border:none; border-radius:40px; font-weight:600; transition:.3s; }
.explore-btn:hover{ background:#EA580C; }

/*================================ FOOTER ================================*/
footer{ margin-top:70px; background:#1E293B; color:white; padding:60px; text-align:center; }

/*================================ RESPONSIVE ================================*/
@media(max-width:992px){
  .stats{ grid-template-columns:repeat(2,1fr); }
  .hero-content h1 { font-size: 48px; }
  .hero-content p { font-size: 20px; }
}
@media(max-width:768px){
  .stats{ grid-template-columns:1fr; }
  .hero-section { height: 75vh; }
  .hero-content h1 { font-size: 38px; }
  .hero-content p { font-size: 18px; }
  
  .search-box{ 
    flex-direction:column; 
    border-radius:20px; 
    background: transparent; 
    box-shadow: none; 
    padding: 0; 
  }
  .search-box input { 
    margin-bottom: 15px; 
    border-radius: 30px; 
    padding: 18px 20px; 
    box-shadow: 0 10px 25px rgba(0,0,0,.15); 
  }
  .search-btn{ 
    width: 100%; 
    justify-content: center; 
    border-radius: 30px; 
    padding: 15px; 
  }
}
</style>
</head>

<body>

<!-- ===========================================
                NAVBAR
============================================ -->
<nav class="navbar navbar-expand-lg">
<div class="container">
<a class="navbar-brand" href="home">🍽 FoodVerse</a>
<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMenu">
<span class="navbar-toggler-icon"></span>
</button>
<div class="collapse navbar-collapse" id="navbarMenu">
<ul class="navbar-nav ms-auto align-items-center">
<li class="nav-item"><a class="nav-link active" href="home">Home</a></li>
<% if(user==null){ %>
<li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
<li class="nav-item ms-2"><a class="btn btn-register" href="register.jsp">Register</a></li>
<% }else{ %>
<li class="nav-item"><a class="nav-link" href="myOrders">My Orders</a></li>
<li class="nav-item"><a class="nav-link" href="cart">Cart</a></li>
<li class="nav-item"><a class="nav-link" href="profile">Profile</a></li>
<li class="nav-item ms-3">
  <span class="fw-bold text-success">
    👋 Welcome, <%=user.getName()%>
  </span>
</li>
<li class="nav-item ms-3"><a class="btn btn-danger rounded-pill" href="logout">Logout</a></li>
<% } %>
</ul>
</div>
</div>
</nav>

<!-- ===========================================
                HERO SECTION
============================================ -->
<div class="hero-section">
  <!-- Double video setup for seamless preloading and crossfading transitions -->
  <video id="heroVideo1" class="hero-video active-video" autoplay muted playsinline preload="auto" poster="https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=1920&q=80"></video>
  <video id="heroVideo2" class="hero-video inactive-video" muted playsinline preload="auto"></video>
  
  <div class="hero-overlay"></div>
  
  <div class="container hero-content text-center">
    <h1>Craving Something Delicious? 🍕🍔🍜</h1>
    <p>Discover the best restaurants around you. Fresh food, lightning-fast delivery and amazing offers—all in one place.</p>
    
    <div class="search-box">
      <input type="text" id="searchBox" placeholder="Search Restaurants..." onkeyup="searchRestaurant()">
      <button class="search-btn"><i class="bi bi-search"></i> Search</button>
    </div>
  </div>
</div>

<div class="container">
<!-- ===========================================
                STATISTICS
============================================ -->
<div class="stats">
<div class="stat-card">
<div class="stat-icon">🍽</div>
<div class="stat-number">
  <%=restaurants != null ? restaurants.size() : "0"%>
</div>
<div class="stat-title">Restaurants</div>
</div>
<div class="stat-card">
<div class="stat-icon">🍔</div>
<div class="stat-number">500+</div>
<div class="stat-title">Food Items</div>
</div>
<div class="stat-card">
<div class="stat-icon">🚚</div>
<div class="stat-number">30 Min</div>
<div class="stat-title">Delivery</div>
</div>
<div class="stat-card">
<div class="stat-icon">⭐</div>
<div class="stat-number">4.9</div>
<div class="stat-title">Customer Rating</div>
</div>
</div>

<!-- ===========================================
            POPULAR CATEGORIES
============================================ -->
<h2 class="section-title">Popular Categories</h2>
<p class="section-sub">Order your favourite cuisines in just a few clicks.</p>
<div class="category-list">
<div class="category">🍕 Pizza</div>
<div class="category">🍔 Burger</div>
<div class="category">🍜 Chinese</div>
<div class="category">🍛 Indian</div>
<div class="category">🥗 Healthy</div>
<div class="category">🍰 Desserts</div>
<div class="category">🥤 Drinks</div>
</div>

<!-- ===========================================
            RESTAURANT SECTION
============================================ -->
<h2 class="section-title">Popular Restaurants</h2>
<p class="section-sub">Choose from our top-rated restaurants.</p>
<div class="row g-4">
<% 
if (restaurants != null) {
  for (Restaurant restaurant : restaurants) {
    boolean featured = restaurant.getRating() >= 4.5;
%>
<div class="col-lg-4 col-md-6 restaurant">
<div class="restaurant-card">
<div style="position:relative;">
<!-- Added lazy loading for images -->
<img src="<%=restaurant.getImage()%>" alt="<%=restaurant.getRestaurantName()%>" loading="lazy">
<% if(featured){ %>
<div class="ribbon">🔥 Featured</div>
<% } %>
<div class="favorite"><i class="bi bi-heart"></i></div>
</div>
<div class="restaurant-body">
<div class="d-flex justify-content-between align-items-center">
<h4 class="restaurant-name"><%=restaurant.getRestaurantName()%></h4>
<span class="rating">⭐ <%=restaurant.getRating()%></span>
</div>
<div class="mt-3">
<span class="cuisine">🍽 <%=restaurant.getCuisineType()%></span>
</div>
<p class="delivery mt-3"><i class="bi bi-geo-alt-fill text-danger"></i> <%=restaurant.getAddress()%></p>
<div class="d-flex justify-content-between mt-3">
<div><span class="badge bg-success">🟢 Open</span></div>
<div><span class="badge bg-warning text-dark">🚚 25-30 Min</span></div>
</div>
<div class="mt-3">
<span class="badge bg-danger">🔥 Flat 20% OFF</span>
<span class="badge bg-primary">Free Delivery</span>
</div>
<hr>
<div class="row text-center">
<div class="col-4"><h6 class="mb-0">4.8★</h6><small class="text-muted">Rating</small></div>
<div class="col-4"><h6 class="mb-0">500+</h6><small class="text-muted">Orders</small></div>
<div class="col-4"><h6 class="mb-0">30m</h6><small class="text-muted">Delivery</small></div>
</div>
<div class="d-grid mt-4">
<a href="menu?restaurantId=<%=restaurant.getRestaurantId()%>" class="btn explore-btn"><i class="bi bi-arrow-right-circle-fill"></i> Explore Restaurant</a>
</div>
</div>
</div>
</div>
<% 
  }
} 
%>
</div>

<!-- =======================================
        WHY CHOOSE US
======================================= -->
<section class="mt-5">
<h2 class="section-title">Why Choose FoodVerse?</h2>
<p class="section-sub">More than just food delivery.</p>
<div class="row g-4">
<div class="col-lg-3 col-md-6">
<div class="stat-card">
<div class="stat-icon">🚀</div>
<div class="stat-number">30 Min</div>
<div class="stat-title">Fast Delivery</div>
</div>
</div>
<div class="col-lg-3 col-md-6">
<div class="stat-card">
<div class="stat-icon">🍽</div>
<div class="stat-number">100%</div>
<div class="stat-title">Fresh Food</div>
</div>
</div>
<div class="col-lg-3 col-md-6">
<div class="stat-card">
<div class="stat-icon">💳</div>
<div class="stat-number">Secure</div>
<div class="stat-title">Online Payment</div>
</div>
</div>
<div class="col-lg-3 col-md-6">
<div class="stat-card">
<div class="stat-icon">🎁</div>
<div class="stat-number">Daily</div>
<div class="stat-title">Amazing Offers</div>
</div>
</div>
</div>
</section>

</div> <!-- End of container -->

<!-- =======================================
        FOOTER
======================================= -->
<footer>
<div class="container">
<div class="row">
<div class="col-lg-4">
<h2>🍽 FoodVerse</h2>
<p class="mt-3">Fresh Food • Fast Delivery • Better Experience</p>
<p>India's Premium Food Ordering Platform</p>
</div>
<div class="col-lg-2">
<h5>Company</h5>
<p>Home</p><p>Restaurants</p><p>About</p><p>Contact</p>
</div>
<div class="col-lg-3">
<h5>Customer Support</h5>
<p>📞 +91 9876543210</p>
<p>✉ support@foodverse.com</p>
<p>🕒 24 × 7 Support</p>
</div>
<div class="col-lg-3">
<h5>Follow Us</h5>
<div class="d-flex justify-content-center gap-3 mt-3">
<i class="bi bi-facebook fs-3"></i>
<i class="bi bi-instagram fs-3"></i>
<i class="bi bi-twitter-x fs-3"></i>
<i class="bi bi-linkedin fs-3"></i>
</div>
</div>
</div>
<hr class="my-4">
<p class="mb-0">© 2026 FoodVerse | Made with ❤️ using Java, JSP & MySQL</p>
</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
/*========================================
        SEARCH RESTAURANT
========================================*/
function searchRestaurant(){
  let input = document.getElementById("searchBox").value.toLowerCase();
  let cards = document.getElementsByClassName("restaurant");
  for(let i=0; i<cards.length; i++){
    let text = cards[i].innerText.toLowerCase();
    cards[i].style.display = text.includes(input) ? "" : "none";
  }
}

/*========================================
        FAVORITE BUTTON
========================================*/
document.querySelectorAll(".favorite").forEach(function(btn){
  btn.addEventListener("click",function(){
    let icon = btn.querySelector("i");
    icon.classList.toggle("bi-heart");
    icon.classList.toggle("bi-heart-fill");
  });
});

/*========================================
        CATEGORY CLICK EFFECT
========================================*/
document.querySelectorAll(".category").forEach(function(category){
  category.addEventListener("click",function(){
    document.querySelectorAll(".category").forEach(function(c){
      c.style.background="white";
      c.style.color="black";
    });
    this.style.background="#F97316";
    this.style.color="white";
  });
});

/*========================================
        CARD ANIMATION
========================================*/
window.addEventListener("load",function(){
  const cards = document.querySelectorAll(".restaurant-card");
  cards.forEach(function(card,index){
    card.style.opacity="0";
    card.style.transform="translateY(40px)";
    setTimeout(function(){
      card.style.transition=".6s";
      card.style.opacity="1";
      card.style.transform="translateY(0px)";
    },index*120);
  });
});

/*========================================
        HERO ANIMATION (Fade-in Content)
========================================*/
window.addEventListener("load",function(){
  document.querySelector(".hero-content").style.animation = "fadeHero .8s ease forwards";
});

/*========================================
        TOAST
========================================*/
function showToast(message,type){
  const toast = document.createElement("div");
  toast.style.position="fixed";
  toast.style.top="20px";
  toast.style.right="20px";
  toast.style.zIndex="9999";
  toast.innerHTML=`
  <div class="toast show text-bg-${type} border-0">
  <div class="d-flex">
  <div class="toast-body">${message}</div>
  <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
  </div>
  </div>`;
  document.body.appendChild(toast);
  setTimeout(function(){ toast.remove(); },3000);
}

/*========================================
        WELCOME TOAST
========================================*/
window.onload=function(){
<% if(user!=null){ %>
  showToast("Welcome <%=user.getName()%> 👋","success");
<% } %>
};

/*========================================
        SEAMLESS HERO VIDEO PLAYLIST
========================================*/
window.addEventListener("load", function() {
  const videoPlaylist = [
    "Videos/video1.mp4",
    "Videos/video2.mp4",
    "Videos/video3.mp4",
    "Videos/video4.mp4",
    "Videos/video5.mp4",
    "Videos/video6.mp4",
    "Videos/video7.mp4",
    "Videos/video8.mp4"
  ];
  
  let currentIndex = 0;
  const video1 = document.getElementById("heroVideo1");
  const video2 = document.getElementById("heroVideo2");

  if (video1 && video2) {
    let activeVideo = video1;
    let inactiveVideo = video2;

    // Load first two videos
    activeVideo.src = videoPlaylist[0];
    inactiveVideo.src = videoPlaylist[1];
    activeVideo.play();

    function onVideoEnded() {
      // 1. Swap CSS classes to trigger the crossfade transition
      activeVideo.classList.remove("active-video");
      activeVideo.classList.add("inactive-video");
      
      inactiveVideo.classList.remove("inactive-video");
      inactiveVideo.classList.add("active-video");
      
      // 2. Play the new active video
      inactiveVideo.play();

      // 3. Swap the active/inactive variables internally
      let temp = activeVideo;
      activeVideo = inactiveVideo;
      inactiveVideo = temp;

      // 4. Pre-load the NEXT video into the newly inactive background element
      currentIndex = (currentIndex + 1) % videoPlaylist.length;
      let nextIndex = (currentIndex + 1) % videoPlaylist.length;
      inactiveVideo.src = videoPlaylist[nextIndex];
    }

    video1.addEventListener("ended", onVideoEnded);
    video2.addEventListener("ended", onVideoEnded);
  }
});

/*========================================
        KEYFRAMES
========================================*/
const style = document.createElement("style");
style.innerHTML=`
@keyframes fadeHero{
  from{ opacity:0; transform:translateY(30px); }
  to{ opacity:1; transform:translateY(0); }
}
`;
document.head.appendChild(style);
</script>
</body>
</html>