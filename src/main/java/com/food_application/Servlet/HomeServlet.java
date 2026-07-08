package com.food_application.Servlet;

import java.io.IOException;
import java.util.List;

import com.food_application.DAO.RestaurantDAO;
import com.food_application.DAOApplication.RestaurantDAOImpl;
import com.food_application.model.Restaurant;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("========== HOME SERVLET CALLED ==========");

        RestaurantDAO dao = new RestaurantDAOImpl();

        List<Restaurant> restaurants = dao.getAllRestaurants();

        System.out.println("Restaurant List = " + restaurants);

        request.setAttribute("restaurants", restaurants);

        request.getRequestDispatcher("/home.jsp")
               .forward(request, response);
    }
}