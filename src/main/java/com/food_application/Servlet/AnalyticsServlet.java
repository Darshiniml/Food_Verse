package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.PaymentDAO;
import com.food_application.DAOApplication.PaymentDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/analytics")
public class AnalyticsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private PaymentDAO paymentDAO;

    @Override
    public void init() {

        paymentDAO = new PaymentDAOImpl();

    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("totalRevenue",
                paymentDAO.getTotalRevenue());

        request.setAttribute("todayRevenue",
                paymentDAO.getTodayRevenue());

        request.setAttribute("monthlyRevenue",
                paymentDAO.getMonthlyRevenue());

        request.setAttribute("totalPayments",
                paymentDAO.getTotalPayments());

        request.setAttribute("successPayments",
                paymentDAO.getSuccessfulPayments());

        request.setAttribute("pendingPayments",
                paymentDAO.getPendingPayments());

        request.getRequestDispatcher("analytics.jsp")
               .forward(request, response);

    }

}