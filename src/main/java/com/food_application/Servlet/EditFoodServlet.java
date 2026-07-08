package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.FoodItemDAO;
import com.food_application.DAO.RestaurantDAO;
import com.food_application.DAOApplication.FoodItemDAOImpl;
import com.food_application.DAOApplication.RestaurantDAOImpl;
import com.food_application.model.FoodItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/editFood")
public class EditFoodServlet extends HttpServlet {

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

        int foodId =
                Integer.parseInt(request.getParameter("id"));

        FoodItem food =
                foodDAO.getFoodItemById(foodId);

        request.setAttribute("food", food);

        request.setAttribute("restaurants",
                restaurantDAO.getAllRestaurants());

        request.getRequestDispatcher("admin/editFood.jsp")
                .forward(request, response);

    }

}