package com.food_application.Servlet;

import java.io.IOException;
import java.util.List;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAO.RestaurantDAO;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.DAOApplication.RestaurantDAOImpl;
import com.food_application.model.Order;
import com.food_application.model.Restaurant;
import com.food_application.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/restaurantRevenue")
public class RestaurantRevenueServlet extends HttpServlet {

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

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Restaurant restaurant =
                restaurantDAO.getRestaurantByUserId(user.getUserId());

        if (restaurant == null) {

            response.getWriter().println(
                    "<h2>No Restaurant Found.</h2>");

            return;
        }

        int totalOrders =
                orderDAO.getRestaurantOrderCount(
                        restaurant.getRestaurantId());

        int pendingOrders =
                orderDAO.getPendingRestaurantOrders(
                        restaurant.getRestaurantId());

        double totalRevenue =
                orderDAO.getRestaurantRevenue(
                        restaurant.getRestaurantId());

        List<Order> completedOrders =
                orderDAO.getOrdersByRestaurantId(
                        restaurant.getRestaurantId());

        request.setAttribute("restaurant", restaurant);

        request.setAttribute("totalOrders", totalOrders);

        request.setAttribute("pendingOrders", pendingOrders);

        request.setAttribute("totalRevenue", totalRevenue);

        request.setAttribute("completedOrders", completedOrders);

        request.getRequestDispatcher("restaurantRevenue.jsp")
               .forward(request, response);
    }
}