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

@WebServlet("/updateRestaurant")
public class UpdateRestaurantServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RestaurantDAO dao;

    @Override
    public void init() {

        dao = new RestaurantDAOImpl();

    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String restaurantName = request.getParameter("restaurantName");
        String cuisineType = request.getParameter("cuisineType");
        String address = request.getParameter("address");
        String ratingText = request.getParameter("rating");

        if (restaurantName == null || restaurantName.trim().isEmpty()
                || cuisineType == null || cuisineType.trim().isEmpty()
                || address == null || address.trim().isEmpty()
                || ratingText == null || ratingText.trim().isEmpty()) {
            response.sendRedirect("manageRestaurants?error=1");
            return;
        }

        Restaurant restaurant = new Restaurant();

        restaurant.setRestaurantId(
                Integer.parseInt(request.getParameter("restaurantId")));

        restaurant.setRestaurantName(restaurantName.trim());
        restaurant.setCuisineType(cuisineType.trim());
        restaurant.setAddress(address.trim());
        restaurant.setRating(Double.parseDouble(ratingText.trim()));
        restaurant.setImage(request.getParameter("image") == null ? "" : request.getParameter("image").trim());

        dao.updateRestaurant(restaurant);

        response.sendRedirect("manageRestaurants");

    }

}