package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.RestaurantDAO;
import com.food_application.DAOApplication.RestaurantDAOImpl;
import com.food_application.model.Restaurant;
import com.food_application.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/addRestaurant")
public class AddRestaurantServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RestaurantDAO dao;

    @Override
    public void init() throws ServletException {

        dao = new RestaurantDAOImpl();

    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String restaurantName = request.getParameter("restaurantName");
            String cuisineType = request.getParameter("cuisineType");
            String address = request.getParameter("address");
            String image = request.getParameter("image");
            String ratingText = request.getParameter("rating");

            if (restaurantName == null || restaurantName.trim().isEmpty()
                    || cuisineType == null || cuisineType.trim().isEmpty()
                    || address == null || address.trim().isEmpty()
                    || ratingText == null || ratingText.trim().isEmpty()) {
                response.sendRedirect("manageRestaurants?error=1");
                return;
            }

            Restaurant restaurant = new Restaurant();

            restaurant.setRestaurantName(restaurantName.trim());
            restaurant.setCuisineType(cuisineType.trim());
            restaurant.setAddress(address.trim());
            restaurant.setRating(Double.parseDouble(ratingText.trim()));
            restaurant.setImage(image == null ? "" : image.trim());

            User loggedUser = (User) request.getSession(false).getAttribute("loggedUser");
            if (loggedUser != null) {
                restaurant.setUserId(loggedUser.getUserId());
            }

            dao.addRestaurant(restaurant);

            response.sendRedirect("manageRestaurants");

        }

        catch(Exception e) {

            e.printStackTrace();

            response.sendRedirect("manageRestaurants?error=1");

        }

    }

}