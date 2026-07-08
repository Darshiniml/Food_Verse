package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.FoodItemDAO;
import com.food_application.DAOApplication.FoodItemDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/deleteFood")
public class DeleteFoodServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private FoodItemDAO dao;

    @Override
    public void init() {

        dao = new FoodItemDAOImpl();

    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int foodId =
                Integer.parseInt(request.getParameter("id"));

        dao.deleteFoodItem(foodId);

        response.sendRedirect("manageFood?deleted=1");

    }

}