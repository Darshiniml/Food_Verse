package com.food_application.email;

public class EmailTemplates {

	public static String welcomeEmail(String name){

		return """

		<html>

		<body style="font-family:Arial;
		padding:25px;
		background:#f8f9fa;">

		<div style="max-width:650px;
		margin:auto;
		background:white;
		border-radius:15px;
		overflow:hidden;
		box-shadow:0 5px 20px rgba(0,0,0,.1);">

		<div style="background:#ff6b35;
		padding:25px;
		color:white;
		text-align:center;">

		<h1>🍔 FoodVerse</h1>

		<h3>Your Food Journey Starts Here!</h3>

		</div>

		<div style="padding:30px;">

		<h2>

		Hi %s 👋

		</h2>

		<p>

		Congratulations!

		Your FoodVerse account has been created successfully.

		</p>

		<p>

		Now you can enjoy a seamless food ordering experience with exciting features.

		</p>

		<h3>

		What you can do now

		</h3>

		<ul>

		<li>🍕 Explore hundreds of restaurants</li>

		<li>🍔 Order your favourite dishes</li>

		<li>💳 Pay securely online</li>

		<li>📦 Track orders in real time</li>

		<li>🧾 Download payment invoices</li>

		</ul>

		<hr>

		<p>

		We are excited to serve you.

		Thank you for choosing FoodVerse ❤️

		</p>

		<p>

		Happy Ordering!

		</p>

		<br>

		<b>

		Team FoodVerse

		</b>

		</div>

		<div style="background:#f1f1f1;
		padding:15px;
		text-align:center;
		font-size:13px;
		color:gray;">

		© 2026 FoodVerse

		</div>

		</div>

		</body>

		</html>

		""".formatted(name);

		}

	public static String orderConfirmationEmail(

	        String customerName,

	        int orderId,

	        String paymentId,

	        double amount) {

	    return """

	<html>

	<body style="font-family:Arial;
	background:#f5f5f5;
	padding:30px;">

	<div style="max-width:700px;
	margin:auto;
	background:white;
	border-radius:15px;
	overflow:hidden;
	box-shadow:0 5px 20px rgba(0,0,0,.15);">

	<div style="background:#22c55e;
	color:white;
	padding:25px;
	text-align:center;">

	<h1>🍔 FoodVerse</h1>

	<h2>Order Confirmed ✅</h2>

	</div>

	<div style="padding:30px;">

	<h2>

	Hello %s 👋

	</h2>

	<p>

	Great news!

	Your payment has been received successfully and your order is now being prepared.

	</p>

	<hr>

	<table style="width:100%%;
	font-size:16px;">

	<tr>

	<td><b>Order ID</b></td>

	<td>#%d</td>

	</tr>

	<tr>

	<td><b>Payment ID</b></td>

	<td>%s</td>

	</tr>

	<tr>

	<td><b>Amount Paid</b></td>

	<td>₹ %.2f</td>

	</tr>

	<tr>

	<td><b>Payment Status</b></td>

	<td style="color:green;"><b>SUCCESS</b></td>

	</tr>

	<tr>

	<td><b>Estimated Delivery</b></td>

	<td>25 - 35 Minutes</td>

	</tr>

	</table>

	<hr>

	<p>

	You can track your order anytime from your <b>My Orders</b> page.

	</p>

	<p>

	Thank you for choosing FoodVerse ❤️

	</p>

	<br>

	<b>

	Happy Ordering!

	</b>

	</div>

	<div style="background:#eeeeee;
	padding:15px;
	text-align:center;
	color:gray;">

	© 2026 FoodVerse

	</div>

	</div>

	</body>

	</html>

	""".formatted(

	customerName,

	orderId,

	paymentId,

	amount);

	}
}