package com.food_application.Servlet;

import java.io.IOException;
import java.util.List;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAO.OrderItemDAO;
import com.food_application.DAO.PaymentDAO;
import com.food_application.DAO.RestaurantDAO;
import com.food_application.DAO.UserDAO;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.DAOApplication.OrderItemDAOImpl;
import com.food_application.DAOApplication.PaymentDAOImpl;
import com.food_application.DAOApplication.RestaurantDAOImpl;
import com.food_application.DAOApplication.UserDAOImpl;
import com.food_application.invoice.InvoiceGenerator;
import com.food_application.model.Order;
import com.food_application.model.OrderItem;
import com.food_application.model.Payment;
import com.food_application.model.Restaurant;
import com.food_application.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/downloadInvoice")
public class InvoiceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int orderId =
                    Integer.parseInt(
                            request.getParameter("orderId"));

            OrderDAO orderDAO =
                    new OrderDAOImpl();

            OrderItemDAO orderItemDAO =
                    new OrderItemDAOImpl();

            PaymentDAO paymentDAO =
                    new PaymentDAOImpl();

            UserDAO userDAO =
                    new UserDAOImpl();

            RestaurantDAO restaurantDAO =
                    new RestaurantDAOImpl();

            Order order =
                    orderDAO.getOrderById(orderId);

            if(order == null){

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Order not found");

                return;

            }

            User customer =
                    userDAO.getUserById(
                            order.getUserId());

            Restaurant restaurant =
                    restaurantDAO.getRestaurantById(
                            order.getRestaurantId());
            List<OrderItem> orderItems =
                    orderItemDAO.getOrderItemsByOrderId(
                            orderId);

            List<Payment> payments =
                    paymentDAO.getPaymentsByOrderId(
                            orderId);

            Payment payment = null;

            if(payments != null && !payments.isEmpty()){

                payment = payments.get(0);

            }
            else{

                payment = new Payment();

                payment.setPaymentMethod("RAZORPAY");

                payment.setPaymentStatus("SUCCESS");

                payment.setAmount(order.getTotalAmount());

            }


            response.setContentType("application/pdf");

            response.setHeader(
                    "Content-Disposition",
                    "attachment; filename=FoodVerse_Invoice_"
                    + orderId + ".pdf");


            InvoiceGenerator.generateInvoice(

                    response.getOutputStream(),

                    order,

                    customer,

                    payment,

                    orderItems,

                    restaurant.getRestaurantName()

            );
        }

        catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid Order ID");

        }

        catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to generate invoice.");

        }

    }

}