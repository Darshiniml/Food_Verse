package com.food_application.Servlet;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.food_application.DAO.UserDAO;
import com.food_application.DAOApplication.UserDAOImpl;
import com.food_application.email.EmailTemplates;
import com.food_application.email.EmailUtility;
import com.food_application.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String role = request.getParameter("role");

        // Trim Input
        if (name != null) name = name.trim();
        if (email != null) email = email.trim();
        if (password != null) password = password.trim();
        if (phone != null) phone = phone.trim();
        if (address != null) address = address.trim();

        String normalizedRole =
                (role == null || role.isBlank())
                        ? "CUSTOMER"
                        : role.toUpperCase();

        // Validation
        if (name == null || name.isEmpty()
                || email == null || email.isEmpty()
                || password == null || password.isEmpty()) {

            response.sendRedirect("register.jsp?error=1");
            return;
        }

        UserDAO dao = new UserDAOImpl();

        // Check Existing User
        if (dao.getUserByEmail(email) != null) {

            response.sendRedirect("register.jsp?exists=1");
            return;
        }

        // Create User
        User user = new User();

        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);
        user.setRole(normalizedRole);

        // Encrypt Password
        String hashedPassword =
                BCrypt.hashpw(password, BCrypt.gensalt());

        user.setPassword(hashedPassword);

        // Save User
        dao.addUser(user);

        System.out.println("User Registered Successfully");

        // Send Welcome Email
        try {

            boolean sent = EmailUtility.sendEmail(

                    user.getEmail(),

                    "🎉 Welcome to FoodVerse - Your Food Journey Starts Here!",

                    EmailTemplates.welcomeEmail(user.getName())

            );

            if(sent){

                System.out.println("Welcome email sent successfully.");

            }
            else{

                System.out.println("Welcome email failed.");

            }

        }

        catch(Exception e){

            System.out.println("Email sending failed.");

            e.printStackTrace();

        }

        // Create Session
        HttpSession session = request.getSession();

        session.setAttribute("loggedUser", user);

        // Redirect Based on Role
        switch(normalizedRole){

        case "ADMIN":

            response.sendRedirect("adminDashboard");
            break;

        case "RESTAURANT":

            response.sendRedirect("restaurantDashboard");
            break;

        case "DELIVERY_AGENT":

            response.sendRedirect("deliveryDashboard");
            break;

        default:

            response.sendRedirect("home");
            break;

        }

    }

}