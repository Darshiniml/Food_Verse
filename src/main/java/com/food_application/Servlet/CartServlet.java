package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.FoodItemDAO;
import com.food_application.DAOApplication.FoodItemDAOImpl;
import com.food_application.model.Cart;
import com.food_application.model.FoodItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String action = request.getParameter("action");

        FoodItemDAO dao = new FoodItemDAOImpl();

        if (action != null) {

            switch (action) {

            case "add":

                int foodId = Integer.parseInt(request.getParameter("foodId"));

                FoodItem food = dao.getFoodItemById(foodId);

                if (food != null) {
                    cart.addItem(food);
                }

                break;

            case "remove":

                foodId = Integer.parseInt(request.getParameter("foodId"));

                cart.removeItem(foodId);

                break;

            case "increase":

                foodId = Integer.parseInt(request.getParameter("foodId"));

                cart.increaseQuantity(foodId);

                break;

            case "decrease":

                foodId = Integer.parseInt(request.getParameter("foodId"));

                cart.decreaseQuantity(foodId);

                break;

            }

        }

        response.sendRedirect("cart.jsp");

    }

}