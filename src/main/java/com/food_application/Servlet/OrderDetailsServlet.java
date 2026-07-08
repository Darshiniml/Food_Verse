package com.food_application.Servlet;

import java.io.IOException;
import java.util.List;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAO.OrderItemDAO;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.DAOApplication.OrderItemDAOImpl;
import com.food_application.model.Order;
import com.food_application.model.OrderItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/orderDetails")
public class OrderDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int orderId =
                Integer.parseInt(
                        request.getParameter("orderId"));

        OrderDAO orderDAO =
                new OrderDAOImpl();

        OrderItemDAO itemDAO =
                new OrderItemDAOImpl();

        Order order =
                orderDAO.getOrderById(orderId);

        List<OrderItem> items =
                itemDAO.getOrderItemsByOrderId(orderId);

        request.setAttribute("order", order);

        request.setAttribute("items", items);

        request.getRequestDispatcher("orderDetails.jsp")
               .forward(request, response);

    }

}