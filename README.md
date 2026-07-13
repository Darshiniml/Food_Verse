# 🍽️ FoodVerse

> A Full Stack Food Ordering Web Application built using Java, JSP, Servlets, JDBC, MySQL, Maven, and Razorpay.

FoodVerse is a complete online food ordering platform that allows customers to browse restaurants, order food, make secure payments, and track orders. It also provides dedicated dashboards for Admin, Restaurant Owners, and Delivery Agents.

---

# 🚀 Features

## 👤 Authentication

- User Registration
- Secure Login
- BCrypt Password Encryption
- Role-Based Authentication
- Session Management

---

## 🍴 Customer Module

- Browse Restaurants
- View Restaurant Menus
- Search Food Items
- Add to Cart
- Update Cart Quantity
- Remove Items from Cart
- Checkout
- Razorpay Payment Integration
- Order Confirmation
- View My Orders

---

## 🍽 Restaurant Module

- Restaurant Dashboard
- Manage Food Items
- Add New Food
- Edit Food
- Delete Food
- View Customer Orders

---

## 🚚 Delivery Module

- Delivery Dashboard
- View Assigned Orders
- Update Delivery Status

---

## 👨‍💼 Admin Module

- Admin Dashboard
- Manage Users
- Manage Restaurants
- Manage Food Items
- Manage Orders
- View System Statistics

---

# 💳 Payment

- Razorpay Payment Gateway
- Secure Online Payments
- Payment Verification
- Payment Status Storage

---

# 🔐 Security

- BCrypt Password Hashing
- Role-Based Access Control
- Session Validation
- Protected Pages
- Secure Authentication

---

# 🛠 Tech Stack

### Frontend

- JSP
- HTML5
- CSS3
- Bootstrap 5
- JavaScript

### Backend

- Java
- Servlets
- JDBC

### Database

- MySQL

### Build Tool

- Maven

### Payment Gateway

- Razorpay

### Server

- Apache Tomcat 10

### IDE

- Eclipse IDE

---

# 📂 Project Structure

```
FoodVerse
│
├── src
│   ├── main
│   │   ├── java
│   │   │   ├── DAO
│   │   │   ├── DAOApplication
│   │   │   ├── Servlet
│   │   │   ├── model
│   │   │   ├── utility
│   │   │   └── payment
│   │   │
│   │   ├── resources
│   │   │
│   │   └── webapp
│   │       ├── admin
│   │       ├── css
│   │       ├── images
│   │       ├── js
│   │       ├── home.jsp
│   │       ├── login.jsp
│   │       ├── register.jsp
│   │       ├── cart.jsp
│   │       ├── checkout.jsp
│   │       ├── payment.jsp
│   │       └── orderSuccess.jsp
│
└── pom.xml
```

---

# ⚙️ Installation

## Clone Repository

```bash
git clone https://github.com/Darshiniml/Food_Verse.git
```

---

## Import Project

- Open Eclipse
- Import Existing Maven Project
- Update Maven Dependencies

---

## Configure Database

Create a MySQL database:

```sql
CREATE DATABASE foodverse;
```

Import the SQL file.

Update database credentials inside:

```
DBConnection.java
```

---

## Configure Razorpay

Update:

```
razorpay.properties
```

with your own:

```
KEY_ID

KEY_SECRET
```

---

## Run

Deploy the project on:

```
Apache Tomcat 10
```

Open:

```
http://localhost:8080/FoodVerse
```

---

## Deploy on Render

FoodVerse now includes a `Dockerfile` and `render.yaml`, so you can deploy it as a Render web service.

### Required environment variables

- `FOODVERSE_DB_URL`
- `FOODVERSE_DB_USERNAME`
- `FOODVERSE_DB_PASSWORD`
- `RAZORPAY_KEY_ID`
- `RAZORPAY_KEY_SECRET`

### Steps

1. Push the repo to GitHub.
2. Create a new **Web Service** on Render.
3. Choose **Docker** as the environment.
4. Point Render to the repository root.
5. Add the environment variables above.
6. Deploy and open the generated `onrender.com` URL.

---

# 📸 Screenshots

- Login Page
- Registration Page
- Home Page
- Restaurant Menu
- Cart
- Checkout
- Razorpay Payment
- Order Success
- My Orders
- Admin Dashboard
- Restaurant Dashboard
- Delivery Dashboard

---

# 📦 Modules

✔ Customer Module

✔ Restaurant Module

✔ Delivery Module

✔ Admin Module

✔ Payment Module

---

# 📊 Database

Main Tables

- users
- restaurants
- food_items
- cart
- cart_items
- orders
- order_items
- payments

---

# 🔄 Application Flow

```
User Registration
        │
        ▼
Login
        │
        ▼
Browse Restaurants
        │
        ▼
View Food Menu
        │
        ▼
Add to Cart
        │
        ▼
Checkout
        │
        ▼
Razorpay Payment
        │
        ▼
Payment Verification
        │
        ▼
Order Placed
        │
        ▼
Order Success
        │
        ▼
My Orders
```

---

# 🌟 Future Enhancements

- AI Chatbot
- Email Notifications
- Live Order Tracking
- Ratings & Reviews
- Wishlist
- Coupons & Discounts
- Order Analytics Dashboard
- PDF Invoice Generation
- Push Notifications
- Restaurant Analytics

---

# 👨‍💻 Developer

**Darshini ML**

Computer Science & Engineering Graduate

Java Full Stack Developer

GitHub:
https://github.com/Darshiniml

LinkedIn:
https://www.linkedin.com/

---

# ⭐ If you like this project

Please consider giving it a ⭐ on GitHub!
