package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAOApplication.OrderDAOImpl;

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

        orderDAO.updateOrderStatus(orderId, status);

        response.sendRedirect("myDeliveries");

    }

}