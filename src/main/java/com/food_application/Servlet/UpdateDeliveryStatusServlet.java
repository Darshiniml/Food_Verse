package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.model.Order;
import com.food_application.model.OrderStatus;
import com.food_application.model.User;
import com.food_application.utility.NotificationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/updateDeliveryStatus")
public class UpdateDeliveryStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {

        orderDAO = new OrderDAOImpl();

    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("loggedUser");

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            OrderStatus nextStatus = OrderStatus.fromString(request.getParameter("status"));
            Order currentOrder = orderDAO.getTrackingDetails(orderId);
            OrderStatus currentStatus = orderDAO.getOrderStatus(orderId);

            boolean belongsToDeliveryAgent = user != null && currentOrder != null
                    && currentOrder.getDeliveryAgentId() == user.getUserId();
            boolean allowed = belongsToDeliveryAgent
                    && deliveryStage(nextStatus) > deliveryStage(currentStatus);

            if (allowed) {
                orderDAO.updateOrderStatus(orderId, nextStatus);
                NotificationService.forStatus(currentOrder.getUserId(), orderId, nextStatus);
            }
        } catch (NumberFormatException ignored) {
            // Invalid input is ignored and the delivery list is reloaded.
        }

        response.sendRedirect("myDeliveries");

    }

    private int deliveryStage(OrderStatus status) {
        switch (status) {
            case ASSIGNED: return 1;
            case PICKED_UP: return 2;
            case OUT_FOR_DELIVERY: return 3;
            case DELIVERED: return 4;
            default: return -1;
        }
    }

}
