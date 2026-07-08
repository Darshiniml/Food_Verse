package com.food_application.Servlet;

import java.io.IOException;
import java.util.List;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.model.Order;
import com.food_application.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/myDeliveries")
public class MyDeliveriesServlet extends HttpServlet {

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

        HttpSession session = request.getSession(false);

        if(session == null || session.getAttribute("loggedUser") == null){

            response.sendRedirect("login.jsp");
            return;

        }

        User user = (User) session.getAttribute("loggedUser");

        if (user == null) {

            response.sendRedirect("login.jsp");
            return;

        }

        List<Order> orders =
                orderDAO.getOrdersByDeliveryAgent(
                        user.getUserId());

        request.setAttribute("orders", orders);

        request.getRequestDispatcher("myDeliveries.jsp")
                .forward(request, response);

    }

}