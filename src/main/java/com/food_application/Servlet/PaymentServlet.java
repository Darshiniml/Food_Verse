package com.food_application.Servlet;

import java.io.IOException;

import org.json.JSONObject;

import com.food_application.model.Cart;
import com.food_application.model.User;
import com.food_application.payment.RazorpayConfig;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {

            response.sendRedirect("login.jsp");
            return;

        }

        User user = (User) session.getAttribute("loggedUser");
        Cart cart = (Cart) session.getAttribute("cart");

        if (user == null || cart == null || cart.getItems().isEmpty()) {

            response.sendRedirect("login.jsp");
            return;

        }

        String address = request.getParameter("address");

        String paymentMethod =
                request.getParameter("paymentMethod");

        if (address == null || address.trim().isEmpty()
                || paymentMethod == null
                || paymentMethod.trim().isEmpty()) {

            response.sendRedirect("checkout.jsp?error=1");
            return;

        }

        try {

            // Save delivery address for VerifyPaymentServlet
            session.setAttribute("deliveryAddress", address);

            RazorpayClient razorpay =

                    new RazorpayClient(

                            RazorpayConfig.KEY_ID,

                            RazorpayConfig.KEY_SECRET

                    );

            JSONObject options = new JSONObject();

            // Razorpay amount is in paise
            options.put(
                    "amount",
                    (int) (cart.getGrandTotal() * 100));

            options.put("currency", "INR");

            options.put(
                    "receipt",
                    "FV_" + System.currentTimeMillis());

            Order razorpayOrder =
                    razorpay.orders.create(options);

            request.setAttribute(
                    "razorpayOrderId",
                    razorpayOrder.get("id"));

            request.setAttribute(
                    "amount",
                    cart.getGrandTotal());

            request.setAttribute(
                    "key",
                    RazorpayConfig.KEY_ID);

            request.setAttribute(
                    "customerName",
                    user.getName());

            request.setAttribute(
                    "customerEmail",
                    user.getEmail());

            request.setAttribute(
                    "customerPhone",
                    user.getPhone());

            request.getRequestDispatcher("payment.jsp")
                    .forward(request, response);

        }

        catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect("checkout.jsp?error=1");

        }

    }

}