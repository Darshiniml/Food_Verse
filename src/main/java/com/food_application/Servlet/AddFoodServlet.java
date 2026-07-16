package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.FoodItemDAO;
import com.food_application.DAO.RestaurantDAO;
import com.food_application.DAOApplication.FoodItemDAOImpl;
import com.food_application.DAOApplication.RestaurantDAOImpl;
import com.food_application.model.FoodItem;
import com.food_application.model.Restaurant;
import com.food_application.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/addFood")
public class AddFoodServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private FoodItemDAO dao;
    private RestaurantDAO restaurantDAO;

    @Override
    public void init() {

        dao = new FoodItemDAOImpl();
        restaurantDAO = new RestaurantDAOImpl();

    }

    private boolean isRestaurantUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }
        User user = (User) session.getAttribute("loggedUser");
        return user != null && "RESTAURANT".equalsIgnoreCase(user.getRole());
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        if (!isRestaurantUser(request)) {
            response.sendRedirect(request.getContextPath() + "/403.jsp");
            return;
        }

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("loggedUser");
        Restaurant restaurant = restaurantDAO.getRestaurantByUserId(user.getUserId());
        if (restaurant == null) {
            response.sendRedirect(request.getContextPath() + "/403.jsp");
            return;
        }

        request.setAttribute("restaurant", restaurant);
        request.setAttribute("preselectedRestaurantId", restaurant.getRestaurantId());
        request.getRequestDispatcher("admin/food.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!isRestaurantUser(request)) {
            response.sendRedirect(request.getContextPath() + "/403.jsp");
            return;
        }

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("loggedUser");
        Restaurant restaurant = restaurantDAO.getRestaurantByUserId(user.getUserId());
        if (restaurant == null) {
            response.sendRedirect(request.getContextPath() + "/403.jsp");
            return;
        }

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

        food.setRestaurantId(restaurant.getRestaurantId());

        food.setFoodName(foodName.trim());
        food.setDescription(description.trim());
        food.setPrice(Double.parseDouble(priceText.trim()));
        food.setCategory(category.trim());
        food.setImage(request.getParameter("image") == null ? "" : request.getParameter("image").trim());
        food.setAvailable(Boolean.parseBoolean(request.getParameter("available")));

        dao.addFoodItem(food);

        response.sendRedirect("manageFood");

    }

}
