package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.RestaurantDAO;
import com.food_application.DAOApplication.RestaurantDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/deleteRestaurant")
public class DeleteRestaurantServlet extends HttpServlet {

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

        dao.deleteRestaurant(restaurantId);

        response.sendRedirect("manageRestaurants");

    }

}