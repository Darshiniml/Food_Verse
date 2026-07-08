package com.food_application.Servlet;

import java.io.IOException;

import org.json.JSONObject;

import com.food_application.model.Cart;
import com.food_application.payment.RazorpayConfig;
import com.food_application.payment.RazorpayService;
import com.razorpay.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/createOrder")
public class CreateRazorpayOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session = request.getSession(false);

            Cart cart =
            (Cart) session.getAttribute("cart");

            RazorpayService service =
                    new RazorpayService();

            Order order =
                    service.createOrder(cart.getGrandTotal());

            request.setAttribute("razorpayOrder",
                    order.toString());

            request.setAttribute("key",
                    RazorpayConfig.KEY_ID);

            request.getRequestDispatcher("payment.jsp")
                    .forward(request, response);

        }

        catch(Exception e) {

            throw new ServletException(e);

        }

    }

}