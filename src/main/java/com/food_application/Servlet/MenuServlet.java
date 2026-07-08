package com.food_application.Servlet;

import java.io.IOException;
import java.util.List;

import com.food_application.DAO.FoodItemDAO;
import com.food_application.DAOApplication.FoodItemDAOImpl;
import com.food_application.model.FoodItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int restaurantId =
        Integer.parseInt(request.getParameter("restaurantId"));

        FoodItemDAO dao =
                new FoodItemDAOImpl();

        List<FoodItem> foods =
                dao.getFoodItemsByRestaurantId(restaurantId);

        request.setAttribute("foods", foods);

        request.getRequestDispatcher("menu.jsp")
               .forward(request, response);

    }

}