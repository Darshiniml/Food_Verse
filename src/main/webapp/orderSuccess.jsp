<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<<<<<<< HEAD
<jsp:include page="admin/includes/chatbot.jsp"/>
<%
Integer orderId = (Integer) request.getAttribute("orderId");

if(orderId == null){
    orderId = 0;
}

String paymentId = (String) request.getAttribute("paymentId");

if(paymentId == null){
    paymentId = "N/A";
=======

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<%
Integer orderId=(Integer)request.getAttribute("orderId");

if(orderId==null){

orderId=0;

>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Order Success</title>

<<<<<<< HEAD
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
=======
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<<<<<<< HEAD
<script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.9.3/dist/confetti.browser.min.js"></script>

<style>

*{
    font-family:'Poppins',sans-serif;
=======
<style>

*{

font-family:'Poppins',sans-serif;

>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
}

body{

<<<<<<< HEAD
    background:linear-gradient(135deg,#eef2ff,#ffffff);

    min-height:100vh;

    display:flex;

    justify-content:center;

    align-items:center;

    padding:30px;

}

.success-card{

    width:100%;

    max-width:760px;

    background:white;

    border-radius:25px;

    padding:45px;

    box-shadow:0 15px 40px rgba(0,0,0,.12);

    animation:popup .6s ease;

}

.icon{

    width:120px;

    height:120px;

    background:#22c55e;

    border-radius:50%;

    display:flex;

    justify-content:center;

    align-items:center;

    margin:auto;

    color:white;

    font-size:60px;

    animation:bounce 1.5s infinite;
=======
background:linear-gradient(135deg,#eef2ff,#ffffff);

display:flex;

justify-content:center;

align-items:center;

height:100vh;

}

/* Card */

.success-card{

width:700px;

background:white;

padding:50px;

border-radius:25px;

text-align:center;

box-shadow:0 15px 40px rgba(0,0,0,.12);

animation:popup .6s ease;

}

/* Success Icon */

.icon{

width:120px;

height:120px;

margin:auto;

border-radius:50%;

background:#22c55e;

display:flex;

justify-content:center;

align-items:center;

font-size:60px;

color:white;

margin-bottom:25px;

animation:bounce 1.2s infinite;
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

}

h1{

<<<<<<< HEAD
    margin-top:25px;

    font-weight:700;

    text-align:center;

}

.subtitle{

    text-align:center;

    color:#64748b;

    margin-bottom:30px;
=======
font-weight:700;

color:#1e293b;

margin-bottom:15px;

}

p{

color:#64748b;

font-size:18px;
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

}

.info{

<<<<<<< HEAD
    background:#f8fafc;

    border-radius:18px;

    padding:25px;
=======
margin-top:35px;

background:#f8fafc;

padding:20px;

border-radius:15px;

text-align:left;
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

}

.info h5{

<<<<<<< HEAD
    margin:15px 0;
=======
margin:12px 0;
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

}

.buttons{

<<<<<<< HEAD
    margin-top:35px;

    display:grid;

    grid-template-columns:repeat(2,1fr);

    gap:15px;

}

.buttons a{

    padding:14px;

    border-radius:12px;

    text-decoration:none;

    text-align:center;

    font-weight:600;

}

.footer{

    margin-top:35px;

    text-align:center;

    color:#6c757d;

}

.footer a{

    text-decoration:none;
=======
margin-top:40px;

display:flex;

justify-content:center;

gap:20px;

}

.btn-home{

background:#4F46E5;

color:white;

padding:12px 30px;

border-radius:12px;

text-decoration:none;

font-weight:600;

}

.btn-home:hover{

background:#4338ca;

color:white;

}

.btn-orders{

background:#10b981;

color:white;

padding:12px 30px;

border-radius:12px;

text-decoration:none;

font-weight:600;

}

.btn-orders:hover{

background:#059669;

color:white;
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

}

@keyframes popup{

<<<<<<< HEAD
    from{

        opacity:0;

        transform:scale(.8);

    }

    to{

        opacity:1;

        transform:scale(1);

    }
=======
0%{

transform:scale(.5);

opacity:0;

}

100%{

transform:scale(1);

opacity:1;

}
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

}

@keyframes bounce{

<<<<<<< HEAD
    0%,100%{

        transform:scale(1);

    }

    50%{

        transform:scale(1.08);

    }
=======
0%{

transform:scale(1);

}

50%{

transform:scale(1.08);

}

100%{

transform:scale(1);

}
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

}

</style>

</head>

<body>

<div class="success-card">

<div class="icon">

<i class="bi bi-check-lg"></i>

</div>

<h1>

<<<<<<< HEAD
🎉 Order Placed Successfully!

</h1>

<p class="subtitle">

Thank you for choosing <b>FoodVerse</b> ❤️

<br>

Your delicious meal is now being prepared.
=======
Order Placed Successfully!

</h1>

<p>

Thank you for choosing FoodVerse.

Your delicious meal is being prepared.
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

</p>

<div class="info">

<h5>

<b>Order ID :</b>

#<%=orderId%>

</h5>

<h5>

<<<<<<< HEAD
<b>Payment ID :</b>

<%=paymentId%>

</h5>

<h5>

<b>Payment Status :</b>

<span class="text-success fw-bold">

<i class="bi bi-check-circle-fill"></i>
=======
<b>Payment Status :</b>

<span class="text-success">
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

Paid Successfully

</span>

</h5>

<h5>

<b>Estimated Delivery :</b>

25 - 35 Minutes

</h5>

<h5>

<b>Status :</b>

<<<<<<< HEAD
👨‍🍳 Preparing Your Order
=======
Preparing Your Order
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

</h5>

</div>

<div class="buttons">

<<<<<<< HEAD
<a href="downloadInvoice?orderId=<%=orderId%>"
class="btn btn-danger">

<i class="bi bi-file-earmark-pdf-fill"></i>

Download Invoice

</a>

<a href="myOrders"
class="btn btn-warning">

<i class="bi bi-geo-alt-fill"></i>

Track Order

</a>

<a href="myOrders"
class="btn btn-success">

<i class="bi bi-bag-check-fill"></i>

My Orders

</a>

<a href="home"
class="btn btn-primary">
=======
<a href="home"

class="btn-home">
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

<i class="bi bi-house-fill"></i>

Continue Shopping

</a>

<<<<<<< HEAD
</div>

<div class="footer">

<hr>

<p>

Need help?

<a href="#">

Contact Support

</a>

</p>

<p>

Thank you for choosing

<b>FoodVerse ❤️</b>

</p>

=======
<a href="myOrders"

class="btn-orders">

<i class="bi bi-bag-check-fill"></i>

My Orders

</a>

>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
</div>

</div>

<<<<<<< HEAD
<script>

window.onload=function(){

confetti({

particleCount:180,

spread:120,

origin:{y:0.6}

});

};

</script>

=======
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
</body>

</html>