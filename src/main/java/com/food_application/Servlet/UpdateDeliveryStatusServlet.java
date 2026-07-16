package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.model.OrderStatus;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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

        int orderId =
                Integer.parseInt(request.getParameter("orderId"));

        String status =
                request.getParameter("status");
        OrderStatus nextStatus = OrderStatus.fromString(status);
        OrderStatus currentStatus = orderDAO.getOrderStatus(orderId);

        boolean allowed =
                (currentStatus == OrderStatus.READY && nextStatus == OrderStatus.ASSIGNED) ||
                (currentStatus == OrderStatus.ASSIGNED && nextStatus == OrderStatus.PICKED_UP) ||
                (currentStatus == OrderStatus.PICKED_UP && nextStatus == OrderStatus.OUT_FOR_DELIVERY) ||
                (currentStatus == OrderStatus.OUT_FOR_DELIVERY && nextStatus == OrderStatus.DELIVERED);

        if (allowed) {
            orderDAO.updateOrderStatus(orderId, nextStatus);
        }

        response.sendRedirect("myDeliveries");

    }

}
