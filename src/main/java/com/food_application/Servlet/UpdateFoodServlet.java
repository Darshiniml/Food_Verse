package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.FoodItemDAO;
import com.food_application.DAOApplication.FoodItemDAOImpl;
import com.food_application.model.FoodItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/updateFood")
public class UpdateFoodServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private FoodItemDAO dao;

    @Override
    public void init() {

        dao = new FoodItemDAOImpl();

    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String foodName = request.getParameter("foodName");
        String description = request.getParameter("description");
        String priceText = request.getParameter("price");
        String category = request.getParameter("category");

        if (foodName == null || foodName.trim().isEmpty()
                || description == null || description.trim().isEmpty()
                || priceText == null || priceText.trim().isEmpty()
                || category == null || category.trim().isEmpty()) {
            response.sendRedirect("manageFood?error=1");
            return;
        }

        FoodItem food = new FoodItem();

        food.setFoodId(
                Integer.parseInt(request.getParameter("foodId")));

        food.setRestaurantId(
                Integer.parseInt(request.getParameter("restaurantId")));

        food.setFoodName(foodName.trim());
        food.setDescription(description.trim());
        food.setPrice(Double.parseDouble(priceText.trim()));
        food.setCategory(category.trim());
        food.setImage(request.getParameter("image") == null ? "" : request.getParameter("image").trim());
        food.setAvailable(
                request.getParameter("available") != null);

        dao.updateFoodItem(food);

        response.sendRedirect("manageFood?updated=1");

    }

}