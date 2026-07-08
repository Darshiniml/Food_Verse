package com.food_application.Servlet;

import java.io.IOException;
import java.util.List;

import com.food_application.DAO.FoodItemDAO;
import com.food_application.DAO.RestaurantDAO;
import com.food_application.DAOApplication.FoodItemDAOImpl;
import com.food_application.DAOApplication.RestaurantDAOImpl;
import com.food_application.model.FoodItem;
import com.food_application.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/manageFood")
public class ManageFoodServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private FoodItemDAO foodDAO;
    private RestaurantDAO restaurantDAO;

    @Override
    public void init() {

        foodDAO = new FoodItemDAOImpl();
        restaurantDAO = new RestaurantDAOImpl();

    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<FoodItem> foods =
                foodDAO.getAllFoodItems();

        List<Restaurant> restaurants =
                restaurantDAO.getAllRestaurants();

        request.setAttribute("foods", foods);
        request.setAttribute("restaurants", restaurants);

        request.getRequestDispatcher("admin/food.jsp")
                .forward(request, response);

    }

}