package com.food_application.Servlet;

import java.io.IOException;

<<<<<<< HEAD
import org.mindrot.jbcrypt.BCrypt;

import com.food_application.DAO.UserDAO;
import com.food_application.DAOApplication.UserDAOImpl;
import com.food_application.email.EmailTemplates;
import com.food_application.email.EmailUtility;
import com.food_application.model.User;
=======
import com.food_application.DAO.UserDAO;
import com.food_application.DAOApplication.UserDAOImpl;
import com.food_application.model.User;
import org.mindrot.jbcrypt.BCrypt;
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
<<<<<<< HEAD
=======
import jakarta.servlet.http.HttpSession;
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

<<<<<<< HEAD
        // ==========================
        // Get Form Data
        // ==========================

=======
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String role = request.getParameter("role");
<<<<<<< HEAD

        // ==========================
        // Trim Values
        // ==========================

        if (name != null) name = name.trim();
        if (email != null) email = email.trim();
        if (password != null) password = password.trim();
        if (phone != null) phone = phone.trim();
        if (address != null) address = address.trim();

        String normalizedRole =
                (role == null || role.isBlank())
                        ? "CUSTOMER"
                        : role.toUpperCase();

        // ==========================
        // Validation
        // ==========================

        if (name == null || name.isEmpty()
                || email == null || email.isEmpty()
                || password == null || password.isEmpty()) {

            response.sendRedirect("register.jsp?error=1");
            return;
=======
        String normalizedRole = (role == null || role.isBlank()) ? "CUSTOMER" : role.toUpperCase();

        if (name != null) {
            name = name.trim();
        }
        if (email != null) {
            email = email.trim();
        }
        if (phone != null) {
            phone = phone.trim();
        }
        if (address != null) {
            address = address.trim();
        }
        if (password != null) {
            password = password.trim();
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
        }

        UserDAO dao = new UserDAOImpl();

<<<<<<< HEAD
        // ==========================
        // Check Existing Email
        // ==========================
=======
        if (name == null || name.isEmpty() || email == null || email.isEmpty() || password == null || password.isEmpty()) {
            response.sendRedirect("register.jsp?error=1");
            return;
        }
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

        if (dao.getUserByEmail(email) != null) {

            response.sendRedirect("register.jsp?exists=1");
            return;
<<<<<<< HEAD

        }

        // ==========================
        // Create User
        // ==========================

=======
        }

>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
        User user = new User();

        user.setName(name);
        user.setEmail(email);
<<<<<<< HEAD
=======

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        user.setPassword(hashedPassword);

>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
        user.setPhone(phone);
        user.setAddress(address);
        user.setRole(normalizedRole);

<<<<<<< HEAD
        // Encrypt Password

        String hashedPassword =
                BCrypt.hashpw(password, BCrypt.gensalt());

        user.setPassword(hashedPassword);

        // Save User

        dao.addUser(user);

        // ==========================
        // Send Welcome Email
        // ==========================

        try {

            EmailUtility.sendEmail(

                    user.getEmail(),

                    "🎉 Welcome to FoodVerse - Your Food Journey Starts Here!",

                    EmailTemplates.welcomeEmail(

                            user.getName()

                    )

            );

            System.out.println("Welcome email sent successfully.");

        }

        catch (Exception e) {

            System.out.println("Email sending failed.");

            e.printStackTrace();

        }

        // ==========================
        // Redirect to Login Page
        // ==========================

        response.sendRedirect("login.jsp?registered=1");

    }

=======
        dao.addUser(user);

        HttpSession session = request.getSession();
        session.setAttribute("loggedUser", user);

        if ("ADMIN".equals(normalizedRole)) {
            response.sendRedirect("adminDashboard");
        } else if ("RESTAURANT".equals(normalizedRole)) {
            response.sendRedirect("restaurantDashboard");
        } else if ("DELIVERY_AGENT".equals(normalizedRole)) {
            response.sendRedirect("deliveryDashboard");
        } else {
            response.sendRedirect("home");
        }
    }
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
}