<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.food_application.model.User" %>
<%
User user = (User) request.getAttribute("user");
if (user == null) { response.sendRedirect("login.jsp"); return; }
String initials = "";
if (user.getName() != null) {
    for (String part : user.getName().trim().split("\\s+")) {
        if (!part.isEmpty()) initials += part.substring(0, 1).toUpperCase();
    }
}
if (initials.isEmpty()) initials = "FV";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>My Profile | FoodVerse</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
:root{--ink:#172033;--muted:#687386;--line:#e7ebf1;--accent:#f97316;--soft:#fff7ed}
*{box-sizing:border-box} body{margin:0;background:#f7f8fb;color:var(--ink);font-family:'DM Sans',sans-serif}
.topbar{height:72px;background:rgba(255,255,255,.88);border-bottom:1px solid var(--line);backdrop-filter:blur(14px);display:flex;align-items:center}
.brand{font-size:1.35rem;font-weight:700;color:var(--ink);text-decoration:none}.brand i{color:var(--accent)}.nav-link{color:#4b5563;font-weight:600}.nav-link:hover{color:var(--accent)}
.page{max-width:1040px;margin:0 auto;padding:42px 20px 60px}.profile-hero{padding:34px;border-radius:24px;background:linear-gradient(125deg,#182235,#263652);color:#fff;box-shadow:0 20px 45px rgba(23,32,51,.16)}
.avatar{width:82px;height:82px;border-radius:24px;display:grid;place-items:center;background:linear-gradient(135deg,#fb923c,#f43f5e);font-size:1.7rem;font-weight:700;box-shadow:0 10px 25px rgba(249,115,22,.25)}
.eyebrow{font-size:.73rem;letter-spacing:1.4px;text-transform:uppercase;color:#fbbf24;font-weight:700}.profile-hero h1{font-size:clamp(1.8rem,4vw,2.5rem);margin:4px 0}.profile-hero p{margin:0;color:rgba(255,255,255,.72)}
.role{display:inline-flex;margin-top:14px;padding:6px 10px;border:1px solid rgba(255,255,255,.15);border-radius:999px;background:rgba(255,255,255,.08);font-size:.78rem;font-weight:600}.edit-btn{background:#fff;color:#172033;border:0;border-radius:12px;padding:11px 17px;font-weight:700}.edit-btn:hover{background:#fff1e7;color:#c2410c}
.profile-grid{display:grid;grid-template-columns:1.55fr .9fr;gap:20px;margin-top:20px}.panel{background:#fff;border:1px solid var(--line);border-radius:20px;padding:26px;box-shadow:0 8px 25px rgba(15,23,42,.035)}
.panel-title{font-size:1.05rem;font-weight:700;margin:0 0 20px;display:flex;gap:9px;align-items:center}.panel-title i{color:var(--accent)}.detail{padding:14px 0;border-bottom:1px solid #edf0f5}.detail:last-child{border:0;padding-bottom:0}.detail-label{display:block;color:var(--muted);font-size:.78rem;margin-bottom:4px}.detail-value{font-weight:600;word-break:break-word}.account-note{padding:16px;border-radius:15px;background:var(--soft);color:#9a3412;font-size:.9rem}
.action{display:flex;align-items:center;justify-content:space-between;padding:14px 0;border-bottom:1px solid #edf0f5;color:var(--ink);text-decoration:none;font-weight:600}.action:last-child{border:0}.action i:first-child{color:var(--accent);margin-right:11px}.action:hover{color:#c2410c}.status-dot{width:9px;height:9px;border-radius:99px;background:#22c55e;display:inline-block;margin-right:7px}.modal-content{border:0;border-radius:20px}.modal-header{border:0;padding:24px 24px 10px}.modal-body{padding:16px 24px 24px}.form-label{font-size:.82rem;font-weight:700;color:#475569}.form-control{border:1px solid #dce2ea;border-radius:11px;padding:11px 13px}.form-control:focus{border-color:#fb923c;box-shadow:0 0 0 4px rgba(249,115,22,.12)}.save-btn{background:var(--accent);border:0;border-radius:11px;padding:11px 16px;font-weight:700}.save-btn:hover{background:#ea580c}
.footer{text-align:center;color:#94a3b8;font-size:.82rem;margin-top:28px}@media(max-width:767px){.page{padding:22px 15px 40px}.profile-hero{padding:25px}.profile-grid{grid-template-columns:1fr}.edit-btn{width:100%;margin-top:18px}.avatar{width:68px;height:68px;border-radius:20px}.panel{padding:21px}}
</style>
</head>
<body>
<nav class="topbar"><div class="container d-flex justify-content-between align-items-center"><a class="brand" href="home"><i class="bi bi-bag-heart-fill me-2"></i>FoodVerse</a><div class="d-flex gap-3"><a class="nav-link" href="home">Home</a><a class="nav-link" href="myOrders">My Orders</a></div></div></nav>
<main class="page">
<% if("1".equals(request.getParameter("updated"))){ %><div class="alert alert-success border-0 rounded-4 mb-3"><i class="bi bi-check-circle-fill me-2"></i>Your profile has been updated.</div><% } %>
<% if("invalid".equals(request.getParameter("error"))){ %><div class="alert alert-danger border-0 rounded-4 mb-3">Please provide a valid name and email address.</div><% } %>
<section class="profile-hero"><div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3"><div class="d-flex align-items-center gap-3"><div class="avatar"><%=initials%></div><div><div class="eyebrow">My account</div><h1><%=user.getName()%></h1><p><i class="bi bi-envelope me-2"></i><%=user.getEmail()%></p><span class="role"><span class="status-dot"></span><%=user.getRole()%> account</span></div></div><button class="edit-btn" type="button" data-bs-toggle="modal" data-bs-target="#editProfileModal"><i class="bi bi-pencil-square me-2"></i>Edit profile</button></div></section>
<section class="profile-grid"><div class="panel"><h2 class="panel-title"><i class="bi bi-person-vcard"></i>Personal details</h2><div class="detail"><span class="detail-label">FULL NAME</span><span class="detail-value"><%=user.getName()%></span></div><div class="detail"><span class="detail-label">EMAIL ADDRESS</span><span class="detail-value"><%=user.getEmail()%></span></div><div class="detail"><span class="detail-label">PHONE NUMBER</span><span class="detail-value"><%=user.getPhone()==null || user.getPhone().isEmpty() ? "Not added" : user.getPhone()%></span></div><div class="detail"><span class="detail-label">DELIVERY ADDRESS</span><span class="detail-value"><%=user.getAddress()==null || user.getAddress().isEmpty() ? "Not added" : user.getAddress()%></span></div></div><aside class="d-grid gap-3"><div class="panel"><h2 class="panel-title"><i class="bi bi-shield-check"></i>Account status</h2><p class="mb-2 fw-semibold"><span class="status-dot"></span>Active account</p><p class="text-secondary small mb-0">Your profile details are used for orders, receipts, and delivery updates.</p></div><div class="panel"><h2 class="panel-title"><i class="bi bi-lightning-charge"></i>Quick links</h2><a class="action" href="myOrders"><span><i class="bi bi-bag-check"></i>Order history</span><i class="bi bi-chevron-right"></i></a><a class="action" href="home"><span><i class="bi bi-compass"></i>Explore food</span><i class="bi bi-chevron-right"></i></a><a class="action" href="logout"><span><i class="bi bi-box-arrow-right"></i>Log out</span><i class="bi bi-chevron-right"></i></a></div><div class="account-note"><i class="bi bi-info-circle me-2"></i>Keep your phone number and address current for smooth delivery.</div></aside></section>
<p class="footer">© 2026 FoodVerse · Good food, delivered simply.</p>
</main>
<div class="modal fade" id="editProfileModal" tabindex="-1" aria-hidden="true"><div class="modal-dialog modal-dialog-centered"><div class="modal-content"><form action="updateProfile" method="post"><div class="modal-header"><div><h5 class="modal-title fw-bold">Edit profile</h5><p class="text-secondary small mb-0">Update the details used for your orders.</p></div><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div><div class="modal-body"><div class="mb-3"><label class="form-label" for="name">FULL NAME</label><input class="form-control" id="name" name="name" value="<%=user.getName()%>" required></div><div class="mb-3"><label class="form-label" for="email">EMAIL ADDRESS</label><input type="email" class="form-control" id="email" name="email" value="<%=user.getEmail()%>" required></div><div class="mb-3"><label class="form-label" for="phone">PHONE NUMBER</label><input class="form-control" id="phone" name="phone" value="<%=user.getPhone()==null ? "" : user.getPhone()%>"></div><div class="mb-4"><label class="form-label" for="address">DELIVERY ADDRESS</label><textarea class="form-control" id="address" name="address" rows="3"><%=user.getAddress()==null ? "" : user.getAddress()%></textarea></div><button class="btn btn-primary save-btn w-100" type="submit">Save changes</button></div></form></div></div></div>
<jsp:include page="/includes/notifications.jsp" />
<jsp:include page="/includes/notifications.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
