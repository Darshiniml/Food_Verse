package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAOApplication.OrderDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/updateOrderStatus")
public class UpdateOrderStatusServlet extends HttpServlet {

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

        dao.updateOrderStatus(orderId, status);

        response.sendRedirect("manageOrders");

    }

}