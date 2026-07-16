package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.model.OrderStatus;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/updateRestaurantOrder")
public class UpdateRestaurantOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO dao;

    @Override
    public void init() {

        dao = new OrderDAOImpl();

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
        OrderStatus currentStatus = dao.getOrderStatus(orderId);

        boolean allowed =
                (currentStatus == OrderStatus.PLACED && nextStatus == OrderStatus.ACCEPTED) ||
                (currentStatus == OrderStatus.ACCEPTED && nextStatus == OrderStatus.PREPARING) ||
                (currentStatus == OrderStatus.PREPARING && nextStatus == OrderStatus.READY);

        if (allowed) {
            dao.updateOrderStatus(orderId, nextStatus);
        }

        response.sendRedirect("restaurantOrders");

    }

}
