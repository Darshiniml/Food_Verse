package com.food_application.Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

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
import com.food_application.utility.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {

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

        if(user == null || cart == null || cart.getItems().isEmpty()) {

            response.sendRedirect("login.jsp");

            return;

        }

        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod");

        if (address == null || address.trim().isEmpty() || paymentMethod == null || paymentMethod.trim().isEmpty()) {
            response.sendRedirect("checkout.jsp?error=1");
            return;
        }

        Connection connection = null;
        int orderId = 0;

        try {
            connection = DBConnection.getConnection();
            if (connection == null) {
                throw new SQLException("Database connection is null");
            }
            connection.setAutoCommit(false);
            DBConnection.bindConnection(connection);

            OrderDAO orderDAO = new OrderDAOImpl();
            OrderItemDAO orderItemDAO = new OrderItemDAOImpl();
            PaymentDAO paymentDAO = new PaymentDAOImpl();

            Order order = new Order();
            order.setUserId(user.getUserId());

            int restaurantId = cart.getItems().iterator().next()
                    .getFoodItem().getRestaurantId();

            order.setRestaurantId(restaurantId);
            order.setTotalAmount(cart.getGrandTotal());
            order.setStatus("PLACED");
            order.setDeliveryAddress(address.trim());

            orderId = orderDAO.addOrder(order);

            for(CartItem item : cart.getItems()) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(orderId);
                orderItem.setFoodId(item.getFoodItem().getFoodId());
                orderItem.setQuantity(item.getQuantity());
                orderItem.setSubtotal(item.getTotalPrice());
                orderItemDAO.addOrderItem(orderItem);
            }

            Payment payment = new Payment();
            payment.setOrderId(orderId);
            payment.setAmount(cart.getGrandTotal());
            payment.setPaymentMethod(paymentMethod.trim());
            payment.setPaymentStatus("SUCCESS");
            paymentDAO.addPayment(payment);

            connection.commit();
            session.removeAttribute("cart");

            request.setAttribute("orderId", orderId);
            request.getRequestDispatcher("orderSuccess.jsp").forward(request, response);
        } catch (Exception e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            e.printStackTrace();
            response.sendRedirect("checkout.jsp?error=1");
        } finally {
            DBConnection.clearBoundConnection();
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                    connection.close();
                } catch (SQLException closeEx) {
                    closeEx.printStackTrace();
                }
            }
        }

    }

}
