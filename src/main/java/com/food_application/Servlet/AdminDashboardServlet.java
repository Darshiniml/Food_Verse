package com.food_application.Servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.food_application.DAO.DashboardDAO;
import com.food_application.DAOApplication.DashboardDAOImpl;
import com.food_application.model.DashboardStats;
import com.food_application.model.RecentOrder;
import com.food_application.model.TopFood;
import com.food_application.model.TopRestaurant;
import com.food_application.model.Activity;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DashboardDAO dao;

    @Override
    public void init() throws ServletException {

        dao = new DashboardDAOImpl();

    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            DashboardStats stats = dao.getDashboardStats();

            List<RecentOrder> recentOrders = dao.getRecentOrders();

            TopRestaurant topRestaurant = dao.getTopRestaurant();

            TopFood topFood = dao.getTopFood();

            Map<String,Integer> orderStatus =
                    dao.getOrderStatus();

            Map<String,Double> monthlyRevenue =
                    dao.getMonthlyRevenue();
            List<Activity> activities =
                    dao.getRecentActivities();
           
            request.setAttribute("activities", activities);

            request.setAttribute("stats", stats);

            request.setAttribute("recentOrders",
                    recentOrders);

            request.setAttribute("topRestaurant",
                    topRestaurant);

            request.setAttribute("topFood",
                    topFood);

            request.setAttribute("orderStatus",
                    orderStatus);

            request.setAttribute("monthlyRevenue",
                    monthlyRevenue);

            request.getRequestDispatcher(
                    "/adminDashboard.jsp")
                    .forward(request,response);
            
            

            
        }

        catch(Exception e) {

            e.printStackTrace();

            throw new ServletException(e);

        }

    }

}