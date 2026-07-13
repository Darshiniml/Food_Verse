package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAOApplication.UserDAOImpl;
import com.food_application.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email != null) {
            email = email.trim();
        }
        if (password != null) {
            password = password.trim();
        }

        User user = new UserDAOImpl().validateUser(email, password);

        if (user != null) {

            HttpSession session = request.getSession();

            session.setAttribute("loggedUser", user);

            String role = user.getRole();

            if ("ADMIN".equals(role)) {

            	response.sendRedirect(request.getContextPath() + "/adminDashboard");

            } else if ("RESTAURANT".equals(role)) {

            	response.sendRedirect(request.getContextPath() + "/restaurantDashboard");

            } else if ("DELIVERY_AGENT".equals(role)) {

            	response.sendRedirect(request.getContextPath() + "/deliveryDashboard");

            } else {

                // CUSTOMER
            	response.sendRedirect(request.getContextPath() + "/home");

            }

        } else {

            response.sendRedirect("login.jsp?error=1");

        }

    }

}
