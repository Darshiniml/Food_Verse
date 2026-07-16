<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Login | FoodVerse</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
<style>
:root{
  --bg1:#0f172a;
  --bg2:#111827;
  --accent:#ff7a18;
  --accent2:#ff4d6d;
  --card:#ffffff;
  --text:#0f172a;
  --muted:#64748b;
}
*{box-sizing:border-box}
body{
  margin:0;
  min-height:100vh;
  font-family:'Segoe UI',sans-serif;
  background:
    radial-gradient(circle at top left, rgba(255,122,24,.24), transparent 26%),
    radial-gradient(circle at bottom right, rgba(255,77,109,.18), transparent 28%),
    linear-gradient(135deg, var(--bg1), var(--bg2));
  color:var(--text);
  overflow-x:hidden;
}
.login-shell{
  min-height:100vh;
  display:flex;
  align-items:center;
  justify-content:center;
  padding:28px;
}
.login-grid{
  width:min(1180px,100%);
  min-height:720px;
  display:grid;
  grid-template-columns:1.1fr .9fr;
  border-radius:34px;
  overflow:hidden;
  box-shadow:0 30px 80px rgba(0,0,0,.35);
  background:rgba(255,255,255,.04);
  backdrop-filter:blur(14px);
}
.promo{
  position:relative;
  padding:46px;
  color:#fff;
  background:
    linear-gradient(145deg, rgba(255,122,24,.96), rgba(255,77,109,.92)),
    linear-gradient(145deg, #ff7a18, #ff4d6d);
  display:flex;
  flex-direction:column;
  justify-content:space-between;
}
.theme-toggle{
  position:absolute;
  top:22px;
  right:22px;
  width:46px;
  height:46px;
  border:none;
  border-radius:16px;
  background:rgba(255,255,255,.16);
  color:#fff;
  display:grid;
  place-items:center;
  box-shadow:inset 0 1px 0 rgba(255,255,255,.18);
}
.brand{
  display:flex;
  align-items:center;
  gap:14px;
  font-size:1.8rem;
  font-weight:700;
  letter-spacing:.3px;
}
.brand-badge{
  width:56px;height:56px;border-radius:18px;
  background:rgba(255,255,255,.18);
  display:grid;place-items:center;
  font-size:1.5rem;
  box-shadow:inset 0 1px 0 rgba(255,255,255,.28);
}
.promo h1{
  font-size:clamp(2.2rem,5vw,4.4rem);
  line-height:1;
  margin:0 0 16px;
  max-width:10ch;
}
.promo p{
  margin:0;
  max-width:42ch;
  color:rgba(255,255,255,.92);
  font-size:1.05rem;
}
.pill-row{
  display:flex;flex-wrap:wrap;gap:12px;margin-top:26px;
}
.pill{
  padding:10px 14px;
  border-radius:999px;
  background:rgba(255,255,255,.16);
  border:1px solid rgba(255,255,255,.18);
  font-size:.92rem;
}
.mascot-stage{
  position:relative;
  width:min(420px,100%);
  aspect-ratio:1;
  margin-left:auto;
  margin-top:24px;
  display:grid;
  place-items:center;
  perspective:1000px;
}
.mascot-orbit{
  position:absolute;inset:0;
  border-radius:50%;
  background:radial-gradient(circle at center, rgba(255,255,255,.18), transparent 58%);
  animation:float 6s ease-in-out infinite;
}
.mascot{
  position:relative;
  width:240px;height:240px;
  border-radius:44% 44% 42% 42%;
  background:linear-gradient(180deg,#fff6ed,#ffffff);
  box-shadow:0 20px 60px rgba(15,23,42,.18);
  display:flex;
  align-items:center;
  justify-content:center;
  transform:translateY(8px);
  animation:bob 4s ease-in-out infinite;
  transition:transform .25s ease, box-shadow .25s ease;
}
.mascot::before,.mascot::after{
  content:"";
  position:absolute;
  top:58px;
  width:26px;height:34px;
  border-radius:50%;
  background:#1f2937;
}
.mascot::before{left:64px}
.mascot::after{right:64px}
.mouth{
  position:absolute;
  top:116px;
  width:52px;height:28px;
  border-bottom:6px solid #1f2937;
  border-radius:0 0 40px 40px;
}
.cheek{
  position:absolute;top:96px;width:16px;height:10px;border-radius:999px;background:rgba(255,122,24,.35);
}
.cheek.left{left:34px}
.cheek.right{right:34px}
.plate{
  position:absolute;
  bottom:28px;
  width:138px;height:42px;
  border-radius:999px;
  background:linear-gradient(180deg,#fef3c7,#fde68a);
  box-shadow:0 10px 24px rgba(0,0,0,.14);
}
.steam{
  position:absolute;
  top:-58px;
  width:10px;height:42px;
  border-radius:999px;
  background:rgba(255,255,255,.8);
  filter:blur(.2px);
  animation:steam 2.2s ease-in-out infinite;
}
.steam.s1{left:44px}
.steam.s2{left:64px;animation-delay:.25s}
.steam.s3{left:84px;animation-delay:.5s}
.ingredient{
  position:absolute;
  font-size:1.6rem;
  animation:orbit 9s linear infinite;
  text-shadow:0 8px 18px rgba(0,0,0,.15);
}
.ingredient.i1{top:12px;left:28px}
.ingredient.i2{top:24px;right:12px;animation-delay:1.2s}
.ingredient.i3{bottom:24px;left:8px;animation-delay:2.2s}
.ingredient.i4{bottom:12px;right:28px;animation-delay:3.2s}
.login-panel{
  background:rgba(255,255,255,.94);
  padding:42px 40px;
  display:flex;
  align-items:center;
}
.form-card{
  width:100%;
  max-width:440px;
  margin:0 auto;
}
.form-card h2{
  font-size:2rem;
  margin-bottom:8px;
  color:#0f172a;
}
.form-card .lead{
  color:var(--muted);
  margin-bottom:28px;
}
.alert{
  border:none;
  border-radius:18px;
  box-shadow:0 12px 24px rgba(15,23,42,.06);
}
.form-label{font-weight:600;color:#334155}
.input-group{
  border:1px solid #dbe2ea;
  border-radius:18px;
  overflow:hidden;
  background:#fff;
  transition:.2s ease;
}
.input-group:focus-within{
  border-color:rgba(255,122,24,.65);
  box-shadow:0 0 0 4px rgba(255,122,24,.12);
}
.input-group-text{
  background:transparent;
  border:none;
  color:#f97316;
}
.form-control{
  border:none;
  box-shadow:none!important;
  padding:14px 14px;
}
.btn-login{
  background:linear-gradient(135deg,var(--accent),var(--accent2));
  border:none;
  border-radius:18px;
  padding:14px 18px;
  font-weight:700;
  box-shadow:0 18px 30px rgba(255,77,109,.22);
  position:relative;
  overflow:hidden;
}
.btn-login:hover{transform:translateY(-1px)}
.extra-links{
  margin-top:24px;
  text-align:center;
  color:#475569;
}
.extra-links a{
  color:#f97316;
  font-weight:700;
  text-decoration:none;
}
.extra-links a:hover{text-decoration:underline}
.hint{
  margin-top:18px;
  display:flex;
  flex-wrap:wrap;
  gap:10px;
}
.hint span{
  padding:8px 12px;
  border-radius:999px;
  background:#fff7ed;
  color:#c2410c;
  font-size:.92rem;
}
@keyframes bob{
  0%,100%{transform:translateY(6px)}
  50%{transform:translateY(-8px)}
}
@keyframes float{
  0%,100%{transform:scale(1)}
  50%{transform:scale(1.03)}
}
@keyframes steam{
  0%{transform:translateY(0);opacity:.2}
  50%{transform:translateY(-10px);opacity:.95}
  100%{transform:translateY(-18px);opacity:0}
}
@keyframes orbit{
  from{transform:rotate(0deg) translateX(16px) rotate(0deg)}
  to{transform:rotate(360deg) translateX(16px) rotate(-360deg)}
}
@media (max-width: 992px){
  .login-grid{grid-template-columns:1fr}
  .promo{min-height:420px}
}
@media (max-width: 576px){
  .login-shell{padding:14px}
  .promo,.login-panel{padding:24px}
  .form-card h2{font-size:1.6rem}
  .theme-toggle{top:14px;right:14px}
}
</style>
</head>
<body>
<div class="login-shell">
  <div class="login-grid">
    <section class="promo">
      <button type="button" class="theme-toggle" id="themeToggle" aria-label="Toggle theme">
        <i class="fa-solid fa-moon"></i>
      </button>
      <div>
        <div class="brand">
          <div class="brand-badge"><i class="fa-solid fa-utensils"></i></div>
          FoodVerse
        </div>
        <h1>Welcome back to better food ordering.</h1>
        <p>Sign in to explore restaurants, track orders, and keep your favorite meals just one tap away.</p>
        <div class="pill-row">
          <span class="pill">Fast delivery</span>
          <span class="pill">Fresh food</span>
          <span class="pill">Secure payments</span>
        </div>
      </div>
      <div class="mascot-stage" aria-hidden="true">
        <div class="mascot-orbit"></div>
        <div class="ingredient i1">🍔</div>
        <div class="ingredient i2">🍕</div>
        <div class="ingredient i3">🥗</div>
        <div class="ingredient i4">🍜</div>
        <div class="mascot">
          <div class="cheek left"></div>
          <div class="cheek right"></div>
          <div class="mouth"></div>
          <div class="plate">
            <div class="steam s1"></div>
            <div class="steam s2"></div>
            <div class="steam s3"></div>
          </div>
        </div>
      </div>
    </section>
    <section class="login-panel">
      <div class="form-card">
        <h2>Sign in</h2>
        <p class="lead">Use your FoodVerse account to continue.</p>
        <%
          if(request.getParameter("error")!=null){
        %>
          <div class="alert alert-danger d-flex align-items-center gap-2">
            <i class="fa-solid fa-circle-exclamation"></i>
            <div>Invalid Email or Password</div>
          </div>
        <%
          }
          if(request.getParameter("logout")!=null){
        %>
          <div class="alert alert-success d-flex align-items-center gap-2">
            <i class="fa-solid fa-circle-check"></i>
            <div>Logged out successfully.</div>
          </div>
        <%
          }
          if(request.getParameter("registered")!=null){
        %>
          <div class="alert alert-success d-flex align-items-center gap-2">
            <i class="fa-solid fa-user-check"></i>
            <div>Registration successful. Please login.</div>
          </div>
        <%
          }
        %>
        <form action="login" method="post">
          <div class="mb-3">
            <label class="form-label">Email Address</label>
            <div class="input-group">
              <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
              <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
            </div>
          </div>
          <div class="mb-3">
            <label class="form-label">Password</label>
            <div class="input-group">
              <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
              <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
              <button type="button" class="input-group-text" onclick="togglePassword()" aria-label="Toggle password">
                <i id="eyeIcon" class="fa-solid fa-eye"></i>
              </button>
            </div>
          </div>
          <div class="d-flex justify-content-between align-items-center mb-4">
            <div class="form-check">
              <input class="form-check-input" type="checkbox" id="rememberMe">
              <label class="form-check-label" for="rememberMe">Remember me</label>
            </div>
            <a href="#" class="text-decoration-none">Forgot password?</a>
          </div>
          <div class="d-grid">
            <button type="submit" class="btn btn-login text-white">
              <i class="fa-solid fa-right-to-bracket me-2"></i>Login
            </button>
          </div>
          <div class="hint">
            <span>Restaurant admin friendly</span>
            <span>Mobile responsive</span>
            <span>Premium look</span>
          </div>
          <div class="extra-links">
            Don’t have an account? <a href="register.jsp">Create account</a>
          </div>
        </form>
      </div>
    </section>
  </div>
</div>
<script>
function togglePassword(){
  const password=document.getElementById("password");
  const eye=document.getElementById("eyeIcon");
  const hidden=password.type==="password";
  password.type=hidden?"text":"password";
  eye.classList.toggle("fa-eye", !hidden);
  eye.classList.toggle("fa-eye-slash", hidden);
}

setTimeout(function(){
  document.querySelectorAll(".alert").forEach(function(alert){
    alert.style.transition=".5s";
    alert.style.opacity="0";
    setTimeout(function(){ alert.remove(); },500);
  });
}, 3000);

const btn=document.querySelector(".btn-login");
btn?.addEventListener("click",function(e){
  const circle=document.createElement("span");
  const diameter=Math.max(btn.clientWidth, btn.clientHeight);
  const radius=diameter/2;
  circle.style.width=circle.style.height=diameter+"px";
  circle.style.left=e.clientX-btn.offsetLeft-radius+"px";
  circle.style.top=e.clientY-btn.offsetTop-radius+"px";
  circle.classList.add("ripple");
  const ripple=btn.getElementsByClassName("ripple")[0];
  if(ripple){ ripple.remove(); }
  btn.appendChild(circle);
});

const mascot=document.querySelector(".mascot");
const promo=document.querySelector(".promo");
const leftPanel=document.querySelector(".promo");
const themeToggle=document.getElementById("themeToggle");
const emailInput=document.querySelector('input[name="email"]');
const passwordInput=document.getElementById("password");
const eyeIcon=document.getElementById("eyeIcon");

function setMascotMood(mood){
  if(!mascot) return;
  if(mood==="focus"){
    mascot.style.transform="translateY(-2px) scale(1.04) rotate(-2deg)";
    mascot.style.boxShadow="0 28px 70px rgba(15,23,42,.24)";
  } else if(mood==="typing"){
    mascot.style.transform="translateY(-4px) scale(1.06) rotate(2deg)";
    mascot.style.boxShadow="0 28px 78px rgba(15,23,42,.26)";
  } else {
    mascot.style.transform="";
    mascot.style.boxShadow="";
  }
}

[emailInput,passwordInput].forEach(function(input){
  if(!input) return;
  input.addEventListener("focus",function(){ setMascotMood("focus"); });
  input.addEventListener("blur",function(){ setMascotMood("idle"); });
  input.addEventListener("input",function(){
    setMascotMood(this.value ? "typing" : "focus");
  });
});

if(leftPanel){
  leftPanel.addEventListener("mousemove",function(event){
    const bounds=leftPanel.getBoundingClientRect();
    const offsetX=((event.clientX-bounds.left)/bounds.width-.5)*8;
    const offsetY=((event.clientY-bounds.top)/bounds.height-.5)*8;
    if(mascot){
      mascot.style.transform=`translate3d(${offsetX}px, ${-offsetY}px, 0) scale(1.03)`;
    }
  });
  leftPanel.addEventListener("mouseleave",function(){
    if(mascot){
      mascot.style.transform="";
      mascot.style.boxShadow="";
    }
  });
}

themeToggle?.addEventListener("click",function(){
  const isDark=document.body.dataset.theme==="dark";
  document.body.dataset.theme=isDark?"light":"dark";
  if(isDark){
    document.body.style.filter="";
    themeToggle.innerHTML='<i class="fa-solid fa-moon"></i>';
    promo.style.background='linear-gradient(145deg, rgba(255,122,24,.96), rgba(255,77,109,.92))';
  } else {
    document.body.style.filter="saturate(.95) brightness(.96)";
    themeToggle.innerHTML='<i class="fa-solid fa-sun"></i>';
    promo.style.background='linear-gradient(145deg, #1f2937, #0f172a)';
  }
});
</script>
<style>
.btn-login .ripple{
  position:absolute;
  border-radius:50%;
  transform:scale(0);
  background:rgba(255,255,255,.55);
  animation:ripple .6s linear;
}
@keyframes ripple{
  to{transform:scale(4);opacity:0}
}
</style>
</body>
</html>
