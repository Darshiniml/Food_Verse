<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Track Order | FoodVerse</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
<style>
:root{
  --bg:#eef2ff;
  --card:#ffffff;
  --text:#0f172a;
  --muted:#64748b;
  --primary:#f97316;
  --primary2:#fb7185;
  --success:#16a34a;
  --warning:#f59e0b;
  --line:#dbe4ee;
}
*{box-sizing:border-box}
body{
  margin:0;
  background:
    radial-gradient(circle at top left, rgba(249,115,22,.10), transparent 28%),
    radial-gradient(circle at bottom right, rgba(251,113,133,.12), transparent 24%),
    var(--bg);
  color:var(--text);
  font-family:'Segoe UI',sans-serif;
}
.page{
  max-width:1200px;
  margin:0 auto;
  padding:28px 16px 36px;
}
.hero{
  position:relative;
  overflow:hidden;
  border-radius:28px;
  padding:24px 28px;
  background:linear-gradient(135deg, #0f172a, #1e293b 48%, #334155);
  color:#fff;
  box-shadow:0 20px 50px rgba(15,23,42,.22);
  margin-bottom:22px;
}
.hero::after{
  content:"";
  position:absolute;
  inset:auto -60px -70px auto;
  width:240px;height:240px;
  border-radius:50%;
  background:radial-gradient(circle, rgba(249,115,22,.35), transparent 68%);
  pointer-events:none;
}
.hero-top{
  display:flex;
  justify-content:space-between;
  gap:16px;
  align-items:flex-start;
}
.hero h1{
  font-size:clamp(1.9rem,3vw,2.8rem);
  margin:0 0 8px;
  font-weight:800;
}
.hero p{
  margin:0;
  color:rgba(255,255,255,.78);
}
.hero-pill{
  display:inline-flex;
  gap:8px;
  align-items:center;
  padding:10px 14px;
  border-radius:999px;
  background:rgba(255,255,255,.10);
  border:1px solid rgba(255,255,255,.12);
  font-size:.92rem;
  margin-top:14px;
}
.summary-card,.timeline-card{
  background:var(--card);
  border-radius:24px;
  box-shadow:0 14px 34px rgba(15,23,42,.08);
  border:1px solid rgba(148,163,184,.14);
  height:100%;
}
.summary-card{
  padding:22px;
}
.timeline-card{
  padding:22px 22px 16px;
}
.section-title{
  font-size:1.1rem;
  font-weight:700;
  margin:0 0 16px;
  display:flex;
  align-items:center;
  gap:10px;
}
.meta-grid{
  display:grid;
  gap:12px;
}
.meta-item{
  padding:14px 16px;
  border-radius:18px;
  background:#f8fafc;
  border:1px solid #e2e8f0;
}
.meta-item .label{
  color:var(--muted);
  font-size:.86rem;
}
.meta-item .value{
  font-size:1.02rem;
  font-weight:700;
  margin-top:2px;
}
.status-badge{
  font-size:.82rem;
  letter-spacing:.3px;
}
.progress-track{
  height:14px;
  border-radius:999px;
  background:#e2e8f0;
  overflow:hidden;
  margin-top:16px;
}
.progress-fill{
  height:100%;
  width:14%;
  border-radius:999px;
  background:linear-gradient(90deg,var(--primary),var(--primary2));
  box-shadow:0 8px 18px rgba(249,115,22,.2);
  transition:width .45s ease;
}
.progress-steps{
  display:flex;
  justify-content:space-between;
  font-size:.8rem;
  color:var(--muted);
  margin-top:10px;
}
.timeline{
  display:grid;
  gap:0;
}
.step-row{
  display:grid;
  grid-template-columns:26px 1fr;
  gap:12px;
  align-items:flex-start;
}
.step-dot{
  width:18px;height:18px;
  border-radius:50%;
  margin-top:4px;
  background:#cbd5e1;
  box-shadow:0 0 0 6px rgba(203,213,225,.18);
}
.step.completed .step-dot{
  background:var(--success);
  box-shadow:0 0 0 6px rgba(22,163,74,.12);
}
.step.active .step-dot{
  background:var(--warning);
  box-shadow:0 0 0 6px rgba(245,158,11,.14);
}
.step.future .step-dot{
  background:#cbd5e1;
}
.step-line{
  width:2px;
  min-height:26px;
  margin-left:8px;
  background:var(--line);
}
.step-card{
  padding:14px 16px 14px 0;
}
.step-card .title{
  font-weight:700;
  margin-bottom:4px;
}
.step-card .time{
  color:var(--muted);
  font-size:.9rem;
}
.step-card .desc{
  margin-top:6px;
  color:#334155;
  font-size:.94rem;
}
.current-chip{
  display:inline-flex;
  align-items:center;
  gap:6px;
  margin-left:8px;
  padding:4px 10px;
  border-radius:999px;
  background:#fff7ed;
  color:#c2410c;
  font-size:.76rem;
  font-weight:700;
}
.toolbar{
  display:flex;
  justify-content:flex-end;
}
.toast-container{
  z-index:1090;
}
@media (max-width: 992px){
  .hero-top{flex-direction:column}
  .toolbar{justify-content:flex-start}
}
</style>
</head>
<body>
<div class="page">
  <div class="hero">
    <div class="hero-top">
      <div>
        <h1>Track your order in real time</h1>
        <p id="trackingMessage">Follow each step from placement to delivery with automatic updates every 5 seconds.</p>
        <div class="hero-pill"><i class="bi bi-lightning-charge-fill"></i> Live order updates</div>
      </div>
      <div class="toolbar">
        <a href="myOrders" class="btn btn-light btn-lg rounded-pill px-4">
          <i class="bi bi-arrow-left me-2"></i>Back to Orders
        </a>
      </div>
    </div>
  </div>

  <div class="row g-4">
    <div class="col-lg-4">
      <div class="summary-card">
        <div class="section-title"><i class="bi bi-receipt-cutoff text-warning"></i>Order Summary</div>
        <div class="meta-grid">
          <div class="meta-item">
            <div class="label">Order Number</div>
            <div class="value" id="orderNumber">-</div>
          </div>
          <div class="meta-item">
            <div class="label">Restaurant</div>
            <div class="value" id="restaurantName">-</div>
          </div>
          <div class="meta-item">
            <div class="label">Delivery Partner</div>
            <div class="value" id="deliveryPartner">Not assigned yet</div>
          </div>
          <div class="meta-item">
            <div class="label">Current Status</div>
            <div class="value">
              <span id="statusBadge" class="badge rounded-pill text-bg-warning status-badge">PLACED</span>
            </div>
          </div>
        </div>
        <div class="progress-track" aria-hidden="true">
          <div id="progressBar" class="progress-fill"></div>
        </div>
        <div class="progress-steps">
          <span>Placed</span><span>Accepted</span><span>Prepared</span><span>Delivered</span>
        </div>
      </div>
    </div>

    <div class="col-lg-8">
      <div class="timeline-card">
        <div class="section-title"><i class="bi bi-clock-history text-success"></i>Timeline</div>
        <div id="timeline" class="timeline"></div>
      </div>
    </div>
  </div>
</div>

<script>
const params = new URLSearchParams(window.location.search);
const orderId = params.get('orderId');
const orderNumber = document.getElementById('orderNumber');
const restaurantName = document.getElementById('restaurantName');
const deliveryPartner = document.getElementById('deliveryPartner');
const statusBadge = document.getElementById('statusBadge');
const progressBar = document.getElementById('progressBar');
const timeline = document.getElementById('timeline');
const trackingMessage = document.getElementById('trackingMessage');
let lastStatus = '';
let refreshTimer;

orderNumber.textContent = orderId || '-';

function stepClass(step){
  if(step.completed) return 'completed';
  if(step.current) return 'active';
  return 'future';
}

function renderTimeline(data){
  const labels = ['Order Placed','Restaurant Accepted','Preparing Food','Food Ready','Delivery Partner Assigned','Picked Up','Out For Delivery','Delivered'];
  const map = new Map((data.timeline || []).map(item => [item.label, item]));
  timeline.innerHTML = '';

  labels.forEach((label, index) => {
    const step = map.get(label) || {};
    const wrapper = document.createElement('div');
    wrapper.className = 'step ' + stepClass({completed: step.completed, current: !step.completed && index === data.currentIndex});

    const isCurrent = !step.completed && index === data.currentIndex;
    const currentChip = isCurrent ? '<span class="current-chip"><i class="bi bi-dot"></i>Current</span>' : '';
    const description = step.completed ? 'Completed' : (isCurrent ? 'In progress' : 'Waiting for this step');
    wrapper.innerHTML =
      '<div class="step-row">' +
        '<div class="step-dot"></div>' +
        '<div class="step-card">' +
          '<div class="title">' + label + currentChip + '</div>' +
          '<div class="time">' + formatTimestamp(step.timestamp) + '</div>' +
          '<div class="desc">' + description + '</div>' +
        '</div>' +
      '</div>';

    timeline.appendChild(wrapper);
    if (index < labels.length - 1) {
      const line = document.createElement('div');
      line.className = 'step-line';
      timeline.appendChild(line);
    }
  });
}

function formatTimestamp(timestamp){
  if(!timestamp) return 'Awaiting update';
  const date = new Date(String(timestamp).replace(' ', 'T'));
  return Number.isNaN(date.getTime()) ? timestamp : date.toLocaleString([], {
    day: 'numeric', month: 'short', hour: 'numeric', minute: '2-digit'
  });
}

function toast(message){
  let host = document.getElementById('toastHost');
  if(!host){
    host = document.createElement('div');
    host.id = 'toastHost';
    host.className = 'toast-container position-fixed top-0 end-0 p-3';
    document.body.appendChild(host);
  }
  const el = document.createElement('div');
  el.className = 'toast align-items-center text-bg-primary border-0';
  el.setAttribute('role','alert');
  el.innerHTML = '<div class="d-flex"><div class="toast-body">' + message + '</div><button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button></div>';
  host.appendChild(el);
  new bootstrap.Toast(el,{delay:3000}).show();
}

function update(data){
  if(data.error){
    statusBadge.textContent = 'UNAVAILABLE';
    statusBadge.className = 'badge rounded-pill status-badge text-bg-danger';
    trackingMessage.textContent = data.error;
    return;
  }
  restaurantName.textContent = data.restaurantName || '-';
  deliveryPartner.textContent = data.deliveryPartner || 'Not assigned yet';
  statusBadge.textContent = data.status || 'PLACED';
  const status = data.status || 'PLACED';
  statusBadge.className = 'badge rounded-pill status-badge ' + (
    status === 'DELIVERED' ? 'text-bg-success' :
    status === 'CANCELLED' ? 'text-bg-danger' :
    'text-bg-warning'
  );
  progressBar.style.width = (data.progress || 0) + '%';
  const messages = {
    PLACED: 'Your order has been placed. The restaurant will confirm it shortly.',
    ACCEPTED: 'The restaurant has accepted your order.',
    PREPARING: 'Your meal is being freshly prepared.',
    READY: 'Your order is ready for pickup.',
    ASSIGNED: 'A delivery partner has been assigned to your order.',
    PICKED_UP: 'Your delivery partner has picked up your order.',
    OUT_FOR_DELIVERY: 'Your order is on its way to you.',
    DELIVERED: 'Delivered successfully. Enjoy your meal!',
    CANCELLED: 'This order has been cancelled.'
  };
  trackingMessage.textContent = messages[status] || 'We are checking the latest order update.';
  renderTimeline(data);
}

async function load(){
  if(!orderId) return;
  try {
    const response = await fetch('trackOrder?orderId=' + encodeURIComponent(orderId), {cache: 'no-store'});
    if(!response.ok) throw new Error('Could not refresh the order status.');
    const data = await response.json();
  if(data.status && data.status !== lastStatus && lastStatus){
    const messages = {
      ACCEPTED:'Restaurant accepted your order.',
      PREPARING:'Your food is being prepared.',
      READY:'Your food is ready.',
      ASSIGNED:'A delivery partner has been assigned.',
      PICKED_UP:'Delivery partner picked up your order.',
      OUT_FOR_DELIVERY:'Your order is out for delivery.',
      DELIVERED:'Order delivered successfully.'
    };
    if(messages[data.status]) toast(messages[data.status]);
  }
    lastStatus = data.status || lastStatus;
    update(data);
    if(data.completed && refreshTimer){
      clearInterval(refreshTimer);
      refreshTimer = null;
    }
  } catch (error) {
    update({error: error.message || 'Could not refresh the order status.'});
  }
}

if(orderId){
  load();
  refreshTimer = setInterval(load, 5000);
}
</script>
<jsp:include page="/includes/notifications.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
