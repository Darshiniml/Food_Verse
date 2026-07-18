package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.model.Order;
import com.food_application.model.OrderStatus;
import com.food_application.model.User;
import com.food_application.utility.NotificationService;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cancelOrder")
public class CancelOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        cancel(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        cancel(request, response);
    }

    private void cancel(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("loggedUser");
        String orderIdValue = request.getParameter("orderId");

        if (user == null || orderIdValue == null) {
            response.sendRedirect("myOrders?cancelError=1");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdValue);
            OrderDAO orderDAO = new OrderDAOImpl();
            Order order = orderDAO.getOrderById(orderId);
            OrderStatus status = orderDAO.getOrderStatus(orderId);

            boolean belongsToUser = order != null && order.getUserId() == user.getUserId();
            boolean canCancel = status == OrderStatus.PLACED || status == OrderStatus.ACCEPTED;

            if (belongsToUser && canCancel) {
                orderDAO.updateOrderStatus(orderId, OrderStatus.CANCELLED);
                NotificationService.forStatus(user.getUserId(), orderId, OrderStatus.CANCELLED);
                response.sendRedirect("myOrders?cancelled=1");
            } else {
                response.sendRedirect("myOrders?cancelError=1");
            }
        } catch (NumberFormatException ex) {
            response.sendRedirect("myOrders?cancelError=1");
        }
    }
}
