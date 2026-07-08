package com.food_application.Servlet;

import java.io.IOException;
import java.util.List;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAO.RestaurantDAO;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.DAOApplication.RestaurantDAOImpl;
import com.food_application.model.Order;
import com.food_application.model.Restaurant;
import com.food_application.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/restaurantOrders")
public class RestaurantOrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RestaurantDAO restaurantDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() {

        restaurantDAO = new RestaurantDAOImpl();
        orderDAO = new OrderDAOImpl();

    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null || session.getAttribute("loggedUser") == null){

            response.sendRedirect("login.jsp");

            return;

        }

        User user = (User) session.getAttribute("loggedUser");

        if(user == null){

            response.sendRedirect("login.jsp");

            return;

        }

        Restaurant restaurant =
                restaurantDAO.getRestaurantByUserId(user.getUserId());

        List<Order> orders =
                orderDAO.getOrdersByRestaurantId(
                        restaurant.getRestaurantId());

        request.setAttribute("restaurant", restaurant);

        request.setAttribute("orders", orders);

        request.getRequestDispatcher("restaurantOrders.jsp")
                .forward(request, response);

    }

}