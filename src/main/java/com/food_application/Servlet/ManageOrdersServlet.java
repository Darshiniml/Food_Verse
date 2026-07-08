package com.food_application.Servlet;

import java.io.IOException;
import java.util.List;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/manageOrders")
public class ManageOrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO dao;

    @Override
    public void init() {

        dao = new OrderDAOImpl();

    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Order> orders =
                dao.getAllOrders();

        request.setAttribute("orders", orders);

        request.getRequestDispatcher("admin/orders.jsp")
                .forward(request, response);

    }

}