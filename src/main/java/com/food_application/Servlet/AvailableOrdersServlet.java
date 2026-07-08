package com.food_application.Servlet;

import java.io.IOException;
import java.util.List;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/availableOrders")
public class AvailableOrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {

        orderDAO = new OrderDAOImpl();

    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Order> orders =
                orderDAO.getReadyForPickupOrders();

        request.setAttribute("orders", orders);

        request.getRequestDispatcher("availableOrders.jsp")
                .forward(request, response);

    }

}