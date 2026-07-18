package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.UserDAO;
import com.food_application.DAOApplication.UserDAOImpl;
import com.food_application.model.User;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("loggedUser");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = trim(request.getParameter("name"));
        String email = trim(request.getParameter("email"));
        String phone = trim(request.getParameter("phone"));
        String address = trim(request.getParameter("address"));

        if (name.isEmpty() || email.isEmpty() || !email.contains("@")) {
            response.sendRedirect("profile?error=invalid");
            return;
        }

        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);

        UserDAO userDAO = new UserDAOImpl();
        userDAO.updateUser(user);
        session.setAttribute("loggedUser", user);
        response.sendRedirect("profile?updated=1");
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
