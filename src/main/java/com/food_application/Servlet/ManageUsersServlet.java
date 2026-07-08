package com.food_application.Servlet;

import java.io.IOException;
import java.util.List;

import com.food_application.DAO.UserDAO;
import com.food_application.DAOApplication.UserDAOImpl;
import com.food_application.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/manageUsers")
public class ManageUsersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO dao;

    @Override
    public void init() {

        dao = new UserDAOImpl();

    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<User> users = dao.getAllUsers();

        request.setAttribute("users", users);

        request.getRequestDispatcher("admin/users.jsp")
               .forward(request, response);

    }

}