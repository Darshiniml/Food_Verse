package com.food_application.Servlet;

import java.io.IOException;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAO.OrderItemDAO;
import com.food_application.DAO.PaymentDAO;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.DAOApplication.OrderItemDAOImpl;
import com.food_application.DAOApplication.PaymentDAOImpl;
import com.food_application.model.Cart;
import com.food_application.model.CartItem;
import com.food_application.model.Order;
import com.food_application.model.OrderItem;
import com.food_application.model.Payment;
import com.food_application.model.User;
import com.food_application.payment.RazorpayConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/verifyPayment")
public class VerifyPaymentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null){

            response.sendRedirect("login.jsp");

            return;

        }

        User user =
        (User)session.getAttribute("loggedUser");

        Cart cart =
        (Cart)session.getAttribute("cart");

        if(user == null ||
           cart == null ||
           cart.getItems().isEmpty()){

            response.sendRedirect("login.jsp");

            return;

        }

        String paymentId =
                request.getParameter("razorpay_payment_id");

        String orderId =
                request.getParameter("razorpay_order_id");

        String signature =
                request.getParameter("razorpay_signature");

        try{

            String payload =
                    orderId + "|" + paymentId;

            String generatedSignature =
                    generateSignature(
                            payload,
                            RazorpayConfig.KEY_SECRET);

            if(!generatedSignature.equals(signature)){

                response.sendRedirect(
                        "payment.jsp?failed=1");

                return;

            }

            OrderDAO orderDAO =
                    new OrderDAOImpl();

            OrderItemDAO orderItemDAO =
                    new OrderItemDAOImpl();

            PaymentDAO paymentDAO =
                    new PaymentDAOImpl();

            String address =
            (String)session.getAttribute(
                    "deliveryAddress");

            if(address == null){

                address = "Address Not Available";

            }

            Order order = new Order();

            order.setUserId(user.getUserId());

            int restaurantId =
                    cart.getItems()
                    .iterator()
                    .next()
                    .getFoodItem()
                    .getRestaurantId();

            order.setRestaurantId(
                    restaurantId);

            order.setTotalAmount(
                    cart.getGrandTotal());

            order.setStatus("PENDING");

            order.setDeliveryAddress(
                    address);

            int newOrderId =
                    orderDAO.addOrder(order);
            // Save Order Items

            for(CartItem cartItem : cart.getItems()){

                OrderItem item = new OrderItem();

                item.setOrderId(newOrderId);

                item.setFoodId(
                        cartItem.getFoodItem().getFoodId());

                item.setQuantity(
                        cartItem.getQuantity());

                item.setSubtotal(
                        cartItem.getTotalPrice());

                orderItemDAO.addOrderItem(item);

            }


            // Save Payment Details

            Payment payment = new Payment();

            payment.setOrderId(newOrderId);

            payment.setAmount(cart.getGrandTotal());

            payment.setPaymentMethod("RAZORPAY");

            payment.setPaymentStatus("SUCCESS");

            paymentDAO.addPayment(payment);

            
            // Clear Cart

            session.removeAttribute("cart");

            session.removeAttribute("deliveryAddress");


            // Send Order Id to Success Page

            request.setAttribute(
                    "orderId",
                    newOrderId);

            request.setAttribute(
                    "paymentId",
                    paymentId);

            request.setAttribute(
                    "paymentStatus",
            		 "SUCCESS");
                    request.getRequestDispatcher("orderSuccess.jsp")
                    .forward(request, response);

         }

         catch (Exception e) {

             e.printStackTrace();

             response.sendRedirect("payment.jsp?failed=1");

         }

     }


     private String generateSignature(String data,
             String secret) throws Exception {

         SecretKeySpec keySpec =
                 new SecretKeySpec(
                         secret.getBytes("UTF-8"),
                         "HmacSHA256");

         Mac mac = Mac.getInstance("HmacSHA256");

         mac.init(keySpec);

         byte[] hash =
                 mac.doFinal(data.getBytes("UTF-8"));

         StringBuilder hex = new StringBuilder();

         for(byte b : hash){

             hex.append(String.format("%02x", b));

         }

         return hex.toString();

     }

 }

