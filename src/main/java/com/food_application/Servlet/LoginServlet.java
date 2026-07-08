package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.UserDAO;
import com.food_application.DAOApplication.UserDAOImpl;
import com.food_application.model.User;
import org.mindrot.jbcrypt.BCrypt;

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

        UserDAO dao = new UserDAOImpl();

        User user = dao.getUserByEmail(email);

        boolean passwordMatches = false;
        if (user != null && user.getPassword() != null) {
            String storedPassword = user.getPassword();
            if (storedPassword.startsWith("$2a$") || storedPassword.startsWith("$2b$") || storedPassword.startsWith("$2y$")) {
                passwordMatches = BCrypt.checkpw(password, storedPassword);
            } else {
                passwordMatches = password != null && password.equals(storedPassword);
            }
        }

        if (user != null && passwordMatches) {

            HttpSession session = request.getSession();

            session.setAttribute("loggedUser", user);

            String role = user.getRole();

            if ("ADMIN".equals(role)) {

<<<<<<< HEAD
            	response.sendRedirect(request.getContextPath() + "/adminDashboard");

            } else if ("RESTAURANT".equals(role)) {

            	response.sendRedirect(request.getContextPath() + "/restaurantDashboard");

            } else if ("DELIVERY_AGENT".equals(role)) {

            	response.sendRedirect(request.getContextPath() + "/deliveryDashboard");
=======
                response.sendRedirect("adminDashboard");

            } else if ("RESTAURANT".equals(role)) {

                response.sendRedirect("restaurantDashboard");

            } else if ("DELIVERY_AGENT".equals(role)) {

                response.sendRedirect("deliveryDashboard");
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

            } else {

                // CUSTOMER
<<<<<<< HEAD
            	response.sendRedirect(request.getContextPath() + "/home");
=======
                response.sendRedirect("home");
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

            }

        } else {

            response.sendRedirect("login.jsp?error=1");

        }

    }

}