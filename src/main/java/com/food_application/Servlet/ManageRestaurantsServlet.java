package com.food_application.Servlet;

import java.io.IOException;
import java.util.List;

import com.food_application.DAO.RestaurantDAO;
import com.food_application.DAOApplication.RestaurantDAOImpl;
import com.food_application.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/manageRestaurants")
public class ManageRestaurantsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RestaurantDAO dao;

    @Override
    public void init() {
        dao = new RestaurantDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if(action == null) {

            List<Restaurant> restaurants =
                    dao.getAllRestaurants();

            request.setAttribute("restaurants", restaurants);

            request.getRequestDispatcher("manageRestaurants.jsp")
                   .forward(request, response);

            return;
        }

        switch(action) {

        case "delete":

            int id =
                Integer.parseInt(request.getParameter("id"));

            dao.deleteRestaurant(id);

            response.sendRedirect("manageRestaurants");

            break;

        default:

            response.sendRedirect("manageRestaurants");
        }
    }
    }
