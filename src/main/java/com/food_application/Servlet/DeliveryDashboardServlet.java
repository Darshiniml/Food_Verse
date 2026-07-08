package com.food_application.Servlet;

import java.io.IOException;
import java.util.List;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.model.Order;
import com.food_application.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/deliveryDashboard")
public class DeliveryDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;

    @Override
    public void init() {

        orderDAO = new OrderDAOImpl();

    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null){

            response.sendRedirect("login.jsp");

            return;

        }

        User user =
        (User)session.getAttribute("loggedUser");

        if(user == null){

            response.sendRedirect("login.jsp");

            return;

        }

        request.setAttribute(
                "available",
                orderDAO.getReadyForPickupOrders().size());

        request.setAttribute(
                "assigned",
                orderDAO.getDeliveryCount(user.getUserId()));

        request.setAttribute(
                "completed",
                orderDAO.getCompletedDeliveries(user.getUserId()));

        List<Order> orders =
                orderDAO.getOrdersByDeliveryAgent(
                        user.getUserId());

        request.setAttribute("orders", orders);

        request.getRequestDispatcher("deliveryDashboard.jsp")
               .forward(request, response);

    }

}