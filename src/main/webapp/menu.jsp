<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List,java.util.Map,java.util.LinkedHashMap,java.net.URL" %>
<%@ page import="com.food_application.model.FoodItem" %>
<%@ page import="com.food_application.model.User" %>
<%!
/* JSP-only helper: supports common getter names without requiring a new Java class. */
private String restaurantValue(Object restaurant, String fallback, String... getters) {
    if (restaurant == null) return fallback;
    for (String getter : getters) {
        try {
            Object value = restaurant.getClass().getMethod(getter).invoke(restaurant);
            if (value != null && !value.toString().trim().isEmpty()) return value.toString();
        } catch (Exception ignored) { }
    }
    return fallback;
}
%>
<%
List<FoodItem> foods = (List<FoodItem>) request.getAttribute("foods");
User user = (User) session.getAttribute("loggedUser");
/* Home page must open: menu?restaurantId=1 (or your menu servlet URL). */
int restaurantId = 0;
try { restaurantId = Integer.parseInt(request.getParameter("restaurantId")); }
catch (Exception ignored) { }
/* The Menu Servlet must set this from the Restaurant row fetched from MySQL. */
Object restaurant = request.getAttribute("restaurant");
String restaurantName = restaurantValue(restaurant, "FoodVerse Restaurant", "getRestaurantName", "getName");
String cuisine = restaurantValue(restaurant, "Fresh food", "getCuisine", "getCuisineType", "getCategory");
String rating = restaurantValue(restaurant, "", "getRating");
String deliveryTime = restaurantValue(restaurant, "", "getDeliveryTime", "getDeliveryTimeMinutes");
String address = restaurantValue(restaurant, "", "getAddress", "getRestaurantAddress", "getLocation");
String offer = restaurantValue(restaurant, "", "getOffer", "getOfferBadge", "getDiscount");
/* Video is rendered ONLY if this exact deployed file exists. */
String videoPath = "/Videos/restaurantId=" + restaurantId + ".mp4";
boolean hasVideo = false;
try { hasVideo = restaurantId > 0 && application.getResource(videoPath) != null; }
catch (Exception ignored) { }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>FoodVerse | <%= restaurantName %> Menu</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif}body{background:#f8fafc;overflow-x:hidden}.navbar{background:#fff;padding:18px 0;box-shadow:0 10px 25px rgba(0,0,0,.08);position:sticky;top:0;z-index:999}.navbar-brand{font-size:34px;font-weight:800;color:#f97316!important}.nav-link{font-weight:600;margin-left:18px}.nav-link:hover{color:#f97316!important}.btn-login,.btn-register{border-radius:35px;padding:10px 22px;font-weight:600}.btn-register,.cart-btn,.search-btn{background:#f97316;color:#fff}.btn-register:hover,.cart-btn:hover,.search-btn:hover{background:#ea580c;color:#fff}
/* Restaurant video hero */
.hero{width:100%;aspect-ratio:16/9;min-height:560px;margin:40px auto;border-radius:30px;color:#fff;position:relative;overflow:hidden;isolation:isolate;background:#060b14}.hero-video,.hero-fallback,.hero-overlay,.hero-loader{position:absolute;inset:0}.hero-video{width:100%;height:100%;object-fit:contain;object-position:center;background:#060b14}.hero-fallback{width:100%;height:100%;object-fit:cover;object-position:center}.hero-overlay{z-index:1;background:rgba(15,23,42,.48)}.hero-content{position:relative;z-index:2;padding:70px;animation:heroEnter .7s ease-out both}.hero h1{font-size:clamp(2.1rem,5vw,3.7rem);font-weight:800}.hero-description{max-width:680px;font-size:18px;margin:18px 0 24px}.hero-loader{z-index:3;pointer-events:none;background:linear-gradient(110deg,rgba(255,255,255,.12) 8%,rgba(255,255,255,.32) 18%,rgba(255,255,255,.12) 33%);background-size:220% 100%;animation:shimmer 1.1s linear infinite;transition:opacity .55s ease}.hero.is-ready .hero-loader{opacity:0}.hero-video{opacity:0;transition:opacity .7s ease}.hero.is-ready .hero-video{opacity:1}.hero-info{display:flex;gap:10px;flex-wrap:wrap;margin-top:24px}.hero-glass,.hero-offer{background:rgba(255,255,255,.17);border:1px solid rgba(255,255,255,.28);border-radius:14px;padding:10px 14px;backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px)}.hero-glass i{margin-right:6px}.hero-offer{background:rgba(239,68,68,.85);font-weight:700}@keyframes shimmer{to{background-position:-220% 0}}@keyframes heroEnter{from{opacity:0;transform:translateY(18px)}to{opacity:1;transform:translateY(0)}}
.search-box{margin:26px auto 0;display:flex;background:#fff;padding:8px;border-radius:50px;box-shadow:0 12px 30px rgba(0,0,0,.12);max-width:960px}.search-box input{flex:1;border:0;outline:0;padding:15px;font-size:17px;border-radius:40px}.search-btn{border:0;padding:15px 35px;border-radius:40px;font-weight:600}.category-list{display:flex;gap:15px;flex-wrap:wrap;justify-content:center;margin:45px 0}.category{background:#fff;padding:14px 24px;border-radius:35px;font-weight:600;cursor:pointer;box-shadow:0 6px 18px rgba(0,0,0,.08);transition:.3s}.category:hover,.category.active{background:#f97316;color:#fff;transform:translateY(-4px)}.section-title{text-align:center;font-size:42px;font-weight:700;color:#1e293b;margin-top:60px}.section-sub{text-align:center;color:#64748b;margin-bottom:40px}.food-grid{margin-top:25px}.food-card{background:#fff;border-radius:25px;overflow:hidden;box-shadow:0 15px 35px rgba(0,0,0,.08);transition:.35s;height:100%;position:relative}.food-card:hover{transform:translateY(-10px)}.food-card img{width:100%;height:240px;object-fit:cover}.offer{position:absolute;top:18px;left:18px;background:#ef4444;color:#fff;padding:8px 15px;border-radius:30px;font-size:13px;font-weight:600}.favorite{position:absolute;top:18px;right:18px;width:45px;height:45px;border-radius:50%;background:#fff;display:grid;place-items:center;box-shadow:0 5px 15px rgba(0,0,0,.15);font-size:20px;color:#ef4444;cursor:pointer}.food-body{padding:25px}.food-name{font-size:24px;font-weight:700;color:#1e293b;margin-bottom:10px}.food-description{color:#64748b;font-size:15px;line-height:1.6;min-height:60px;margin-bottom:18px}.price{font-size:30px;font-weight:700;color:#10b981}.rating{background:#16a34a;color:#fff;padding:6px 12px;border-radius:20px;font-size:13px;font-weight:600}.available{color:#16a34a;font-weight:600;font-size:15px}.notavailable{color:#dc2626;font-weight:600;font-size:15px}.cart-btn,.out-btn{width:100%;padding:14px;margin-top:18px;border:0;border-radius:35px;font-size:16px;font-weight:600}.out-btn{background:#cbd5e1;color:#475569;cursor:not-allowed}.floating-cart{position:fixed;bottom:25px;right:25px;background:#f97316;color:#fff;width:65px;height:65px;border-radius:50%;display:grid;place-items:center;font-size:28px;box-shadow:0 15px 35px rgba(0,0,0,.25);text-decoration:none;z-index:999;transition:.3s}.floating-cart:hover{background:#ea580c;color:#fff;transform:scale(1.08)}footer{margin-top:80px;background:#1e293b;color:#fff;padding:60px;text-align:center}
@media(max-width:768px){.hero{aspect-ratio:auto;min-height:520px;margin:22px auto;border-radius:20px}.hero-content{padding:38px 24px}.hero-description{font-size:16px}.hero-glass,.hero-offer{font-size:.82rem;padding:8px 10px}.search-box{flex-direction:column;border-radius:20px}.search-btn{margin-top:10px}.category-list{justify-content:flex-start;overflow-x:auto;flex-wrap:nowrap;padding-bottom:10px}.category{white-space:nowrap}.section-title{font-size:32px}}
</style>
</head>
<body>
<nav class="navbar navbar-expand-lg"><div class="container"><a class="navbar-brand" href="home">🍽 FoodVerse</a><button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMenu"><span class="navbar-toggler-icon"></span></button><div class="collapse navbar-collapse" id="navbarMenu"><ul class="navbar-nav ms-auto align-items-center"><li class="nav-item"><a class="nav-link" href="home">Home</a></li><li class="nav-item"><a class="nav-link" href="myOrders">My Orders</a></li><li class="nav-item"><a class="nav-link" href="cart.jsp">Cart</a></li><% if(user==null){ %><li class="nav-item ms-3"><a class="btn btn-login btn-outline-dark" href="login.jsp">Login</a></li><li class="nav-item ms-2"><a class="btn btn-register" href="register.jsp">Register</a></li><% }else{ %><li class="nav-item ms-3"><span class="fw-bold text-success">👋 Welcome, <%=user.getName()%></span></li><li class="nav-item ms-3"><a class="btn btn-danger rounded-pill" href="logout">Logout</a></li><% } %></ul></div></div></nav>
<main class="container">
<section class="hero" id="restaurantHero">
    <% if(hasVideo){ %><video class="hero-video" id="heroVideo" autoplay muted loop playsinline preload="metadata" aria-label="Restaurant ambience video"><source src="<%=request.getContextPath()+videoPath%>" type="video/mp4"></video><% }else{ %><img class="hero-fallback" src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=1600" alt="Freshly prepared food"><% } %>
    <div class="hero-overlay"></div><% if(hasVideo){ %><div class="hero-loader" aria-label="Loading restaurant video"></div><% } %>
    <div class="hero-content"><h1><%=restaurantName%></h1><p class="hero-description"><%=cuisine%> · Freshly prepared meals, delivered to your door.</p><div class="hero-info"><%if(!rating.isEmpty()){%><span class="hero-glass"><i class="bi bi-star-fill text-warning"></i><%=rating%></span><%}%><%if(!deliveryTime.isEmpty()){%><span class="hero-glass"><i class="bi bi-clock"></i><%=deliveryTime%></span><%}%><%if(!address.isEmpty()){%><span class="hero-glass"><i class="bi bi-geo-alt"></i><%=address%></span><%}%><%if(!offer.isEmpty()){%><span class="hero-offer"><i class="bi bi-tag-fill"></i> <%=offer%></span><%}%></div></div>
</section>
<div class="search-box"><input type="text" id="searchFood" placeholder="Search food items..." onkeyup="searchFood()"><button class="search-btn" type="button"><i class="bi bi-search"></i> Search</button></div>

<h2 class="section-title">Popular Dishes</h2><p class="section-sub">Fresh • Delicious • Affordable</p>
<div class="row g-4 food-grid">
<% if(foods != null){ for(FoodItem food:foods){ %>
<div class="col-lg-4 col-md-6 food-item"><article class="food-card"><div style="position:relative"><img src="<%=food.getImage()%>" alt="<%=food.getFoodName()%>"><div class="offer">🔥 20% OFF</div><div class="favorite"><i class="bi bi-heart"></i></div></div><div class="food-body"><div class="d-flex justify-content-between align-items-start"><h3 class="food-name"><%=food.getFoodName()%></h3><span class="rating">⭐ 4.8</span></div><p class="food-description"><%=food.getDescription()%></p><div class="d-flex justify-content-between align-items-center"><div class="price">₹ <%=String.format("%.2f",food.getPrice())%></div><%if(food.isAvailable()){%><span class="available"><i class="bi bi-check-circle-fill"></i> Available</span><%}else{%><span class="notavailable"><i class="bi bi-x-circle-fill"></i> Out of Stock</span><%}%></div><div class="row text-center mt-3"><div class="col-4"><strong><%=deliveryTime.isEmpty() ? "Fast" : deliveryTime%></strong><br><small class="text-muted">Delivery</small></div><div class="col-4"><strong>Free</strong><br><small class="text-muted">Delivery</small></div><div class="col-4"><strong>500+</strong><br><small class="text-muted">Orders</small></div></div><%if(food.isAvailable()){%><a href="cart?action=add&foodId=<%=food.getFoodId()%>" class="text-decoration-none"><button class="cart-btn"><i class="bi bi-cart-plus-fill"></i> Add To Cart</button></a><%}else{%><button class="out-btn" disabled>Currently Unavailable</button><%}%></div></article></div>
<% }} else { %><p class="text-center text-muted">No food items are available for this restaurant.</p><% } %>
</div>
<section class="mt-5"><h2 class="section-title">Why Order From FoodVerse?</h2><p class="section-sub">Fresh food, secure payment and lightning-fast delivery.</p><div class="row g-4"><div class="col-lg-3 col-md-6"><div class="food-card"><div class="food-body text-center"><div style="font-size:55px">🚀</div><h5 class="mt-3">Fast Delivery</h5><p>Average delivery in under 30 minutes.</p></div></div></div><div class="col-lg-3 col-md-6"><div class="food-card"><div class="food-body text-center"><div style="font-size:55px">🍽</div><h5 class="mt-3">Fresh Food</h5><p>Prepared only after you place your order.</p></div></div></div><div class="col-lg-3 col-md-6"><div class="food-card"><div class="food-body text-center"><div style="font-size:55px">💳</div><h5 class="mt-3">Secure Payment</h5><p>Safe online transactions.</p></div></div></div><div class="col-lg-3 col-md-6"><div class="food-card"><div class="food-body text-center"><div style="font-size:55px">🎁</div><h5 class="mt-3">Daily Offers</h5><p>Exclusive discounts and combos.</p></div></div></div></div></section>
</main>
<a href="cart.jsp" class="floating-cart" title="View Cart"><i class="bi bi-cart-fill"></i></a>
<footer><div class="container"><div class="row"><div class="col-lg-4"><h2>🍽 FoodVerse</h2><p class="mt-3">Fresh Food • Fast Delivery • Better Taste</p><p>Serving happiness one meal at a time.</p></div><div class="col-lg-2"><h5>Quick Links</h5><p><a href="home" class="text-white text-decoration-none">Home</a></p><p><a href="cart.jsp" class="text-white text-decoration-none">Cart</a></p><p><a href="myOrders" class="text-white text-decoration-none">Orders</a></p></div><div class="col-lg-3"><h5>Support</h5><p>📞 +91 9876543210</p><p>✉ support@foodverse.com</p></div><div class="col-lg-3"><h5>Follow Us</h5><div class="d-flex justify-content-center gap-3 mt-3"><i class="bi bi-facebook fs-3"></i><i class="bi bi-instagram fs-3"></i><i class="bi bi-twitter-x fs-3"></i></div></div></div><hr class="my-4"><p>© 2026 FoodVerse | Made with ❤️ using Java, JSP, Servlets & MySQL</p></div></footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
function searchFood(){const input=document.getElementById('searchFood').value.toLowerCase();document.querySelectorAll('.food-item').forEach(card=>card.style.display=card.innerText.toLowerCase().includes(input)?'':'none')}
document.querySelectorAll('.favorite').forEach(btn=>btn.addEventListener('click',()=>{const icon=btn.querySelector('i');icon.classList.toggle('bi-heart');icon.classList.toggle('bi-heart-fill')}));document.querySelectorAll('.category').forEach(category=>category.addEventListener('click',()=>{document.querySelectorAll('.category').forEach(c=>c.classList.remove('active'));category.classList.add('active')}));
window.addEventListener('load',()=>document.querySelectorAll('.food-card').forEach((card,index)=>{card.style.opacity='0';card.style.transform='translateY(40px)';setTimeout(()=>{card.style.transition='.6s';card.style.opacity='1';card.style.transform='translateY(0)'},index*120)}));
(()=>{const hero=document.getElementById('restaurantHero'),video=document.getElementById('heroVideo');if(!video)return;const fallback=()=>{if(!document.getElementById('heroVideo'))return;video.remove();const image=document.createElement('img');image.className='hero-fallback';image.alt='Freshly prepared food';image.src='https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=1600';hero.prepend(image);hero.classList.add('is-ready')};video.addEventListener('canplay',()=>hero.classList.add('is-ready'),{once:true});video.addEventListener('error',fallback,{once:true});window.setTimeout(()=>hero.classList.add('is-ready'),1800);const attempt=video.play();if(attempt)attempt.catch(fallback)})();
</script>
</body>
</html>