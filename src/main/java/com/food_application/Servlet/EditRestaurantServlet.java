package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.RestaurantDAO;
import com.food_application.DAOApplication.RestaurantDAOImpl;
import com.food_application.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/editRestaurant")
public class EditRestaurantServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RestaurantDAO dao;

    @Override
    public void init() {
        dao = new RestaurantDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int restaurantId =
                Integer.parseInt(request.getParameter("id"));

        Restaurant restaurant =
                dao.getRestaurantById(restaurantId);

        request.setAttribute("restaurant", restaurant);

        request.getRequestDispatcher("admin/editRestaurant.jsp")
                .forward(request, response);

    }

}