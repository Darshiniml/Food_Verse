<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Track Order | FoodVerse</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
<style>
body{background:#f8fafc;font-family:Segoe UI,sans-serif}
.track-wrap{max-width:980px;margin:40px auto;padding:0 16px}
.card-soft{background:#fff;border-radius:22px;box-shadow:0 12px 30px rgba(15,23,42,.08)}
.step{display:flex;gap:12px;align-items:flex-start;padding:14px 0}
.step-dot{width:16px;height:16px;border-radius:50%;background:#cbd5e1;margin-top:5px;flex:none}
.step.completed .step-dot{background:#16a34a}
.step.active .step-dot{background:#f59e0b;box-shadow:0 0 0 6px rgba(245,158,11,.14)}
.step.future .step-dot{background:#cbd5e1}
.step-line{width:2px;background:#e2e8f0;min-height:28px;margin-left:7px}
.status-badge{font-size:.85rem}
</style>
</head>
<body>
<div class="track-wrap">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <div>
      <h2 class="mb-1">Track Order</h2>
      <p class="text-muted mb-0">Live order updates every 5 seconds</p>
    </div>
    <a href="myOrders" class="btn btn-outline-secondary">Back to Orders</a>
  </div>
  <div class="row g-4">
    <div class="col-lg-4">
      <div class="card-soft p-4">
        <h5 class="mb-3">Order Summary</h5>
        <div class="mb-2"><strong>Order Number:</strong> <span id="orderNumber">-</span></div>
        <div class="mb-2"><strong>Restaurant:</strong> <span id="restaurantName">-</span></div>
        <div class="mb-2"><strong>Delivery Partner:</strong> <span id="deliveryPartner">-</span></div>
        <div class="mb-3"><strong>Status:</strong> <span id="statusBadge" class="badge text-bg-warning status-badge">PLACED</span></div>
        <div class="progress" style="height:12px;border-radius:999px">
          <div id="progressBar" class="progress-bar bg-success" style="width:14%"></div>
        </div>
      </div>
    </div>
    <div class="col-lg-8">
      <div class="card-soft p-4">
        <h5 class="mb-3">Timeline</h5>
        <div id="timeline"></div>
      </div>
    </div>
  </div>
</div>
<script>
const params=new URLSearchParams(window.location.search);
const orderId=params.get('orderId');
const orderNumber=document.getElementById('orderNumber');
const restaurantName=document.getElementById('restaurantName');
const deliveryPartner=document.getElementById('deliveryPartner');
const statusBadge=document.getElementById('statusBadge');
const progressBar=document.getElementById('progressBar');
const timeline=document.getElementById('timeline');
let lastStatus='';
orderNumber.textContent=orderId||'-';

function stepClass(step){
  if(step.completed) return 'completed';
  if(step.current) return 'active';
  return 'future';
}

function renderTimeline(data){
  const labels=['Order Placed','Restaurant Accepted','Preparing Food','Food Ready','Picked Up','Out For Delivery','Delivered'];
  const map=new Map((data.timeline||[]).map(item=>[item.label,item]));
  timeline.innerHTML='';
  labels.forEach((label,index)=>{
    const step=map.get(label)||{};
    const div=document.createElement('div');
    div.className='step '+stepClass({completed:step.completed,current:!step.completed && index===data.currentIndex});
    div.innerHTML=`<div class="step-dot"></div><div><div class="fw-semibold">${label}</div><div class="text-muted small">${step.timestamp||''}</div></div>`;
    timeline.appendChild(div);
    if(index<labels.length-1){
      const line=document.createElement('div');
      line.className='step-line';
      timeline.appendChild(line);
    }
  });
}

function toast(message){
  const host=document.getElementById('toastHost')||document.body.appendChild(Object.assign(document.createElement('div'),{id:'toastHost',className:'toast-container position-fixed top-0 end-0 p-3'}));
  const el=document.createElement('div');
  el.className='toast align-items-center text-bg-primary border-0';
  el.role='alert';
  el.innerHTML=`<div class="d-flex"><div class="toast-body">${message}</div><button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button></div>`;
  host.appendChild(el);
  new bootstrap.Toast(el,{delay:3000}).show();
}

function update(data){
  if(data.error){ return; }
  restaurantName.textContent=data.restaurantName||'-';
  deliveryPartner.textContent=data.deliveryPartner||'Not assigned yet';
  statusBadge.textContent=data.status||'PLACED';
  const status=data.status||'PLACED';
  statusBadge.className='badge status-badge '+(status==='DELIVERED'?'text-bg-success':status==='CANCELLED'?'text-bg-danger':'text-bg-warning');
  progressBar.style.width=(data.progress||0)+'%';
  renderTimeline(data);
}

async function load(){
  if(!orderId) return;
  const response=await fetch('trackOrder?orderId='+encodeURIComponent(orderId));
  const data=await response.json();
  if(data.status && data.status!==lastStatus && lastStatus){
    const messages={
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
  lastStatus=data.status||lastStatus;
  update(data);
}

if(orderId){
  load();
  setInterval(load,5000);
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
