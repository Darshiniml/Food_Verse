package com.food_application.Servlet;

import java.io.IOException;
import java.util.List;

import com.food_application.DAO.FoodItemDAO;
import com.food_application.DAO.RestaurantDAO;
import com.food_application.DAOApplication.FoodItemDAOImpl;
import com.food_application.DAOApplication.RestaurantDAOImpl;
import com.food_application.model.FoodItem;
import com.food_application.model.Restaurant;
import com.food_application.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/restaurantMenu")
public class RestaurantMenuServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RestaurantDAO restaurantDAO;
    private FoodItemDAO foodDAO;

    @Override
    public void init() {

        restaurantDAO = new RestaurantDAOImpl();
        foodDAO = new FoodItemDAOImpl();

    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Restaurant restaurant =
                restaurantDAO.getRestaurantByUserId(user.getUserId());

        if (restaurant == null) {

            response.getWriter().println(
                    "<h2>No Restaurant is linked to this account.</h2>");

            return;
        }

        List<FoodItem> foods =
                foodDAO.getFoodItemsByRestaurantId(
                        restaurant.getRestaurantId());

        request.setAttribute("restaurant", restaurant);
        request.setAttribute("foods", foods);

        request.getRequestDispatcher("restaurantMenu.jsp")
               .forward(request, response);
    }
}