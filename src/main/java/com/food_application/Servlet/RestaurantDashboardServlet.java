package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAO.RestaurantDAO;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.DAOApplication.RestaurantDAOImpl;
import com.food_application.model.Order;
import com.food_application.model.Restaurant;
import com.food_application.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/restaurantDashboard")
public class RestaurantDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RestaurantDAO restaurantDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() {

        restaurantDAO = new RestaurantDAOImpl();
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

        Restaurant restaurant =
        restaurantDAO.getRestaurantByUserId(user.getUserId());

        if(restaurant == null){

            response.sendRedirect("login.jsp");

            return;

        }

        request.setAttribute("restaurant", restaurant);

        int totalOrders = orderDAO.getRestaurantOrderCount(restaurant.getRestaurantId());
        int pendingOrders = orderDAO.getPendingRestaurantOrders(restaurant.getRestaurantId());
        double revenue = orderDAO.getRestaurantRevenue(restaurant.getRestaurantId());
        java.util.List<Order> recentOrders = orderDAO.getOrdersByRestaurantId(restaurant.getRestaurantId());

        request.setAttribute("orders", totalOrders);
        request.setAttribute("pending", pendingOrders);
        request.setAttribute("revenue", revenue);
        request.setAttribute("recentOrders", recentOrders);

        request.getRequestDispatcher("restaurantDashboard.jsp")
               .forward(request, response);

    }

}