package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.FoodItemDAO;
import com.food_application.DAO.OrderDAO;
import com.food_application.DAO.RestaurantDAO;
import com.food_application.DAO.UserDAO;
import com.food_application.DAOApplication.FoodItemDAOImpl;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.DAOApplication.RestaurantDAOImpl;
import com.food_application.DAOApplication.UserDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO userDAO = new UserDAOImpl();
        RestaurantDAO restaurantDAO = new RestaurantDAOImpl();
        FoodItemDAO foodDAO = new FoodItemDAOImpl();
        OrderDAO orderDAO = new OrderDAOImpl();

        request.setAttribute("users",
                userDAO.getUserCount());

        request.setAttribute("restaurants",
                restaurantDAO.getRestaurantCount());

        request.setAttribute("foods",
                foodDAO.getFoodItemCount());

        request.setAttribute("orders",
                orderDAO.getOrderCount());

        request.setAttribute("revenue",
                orderDAO.getTotalRevenue());

        request.setAttribute("pending",
                orderDAO.getPendingOrderCount());

        request.getRequestDispatcher("adminDashboard.jsp")
               .forward(request, response);
    }
}