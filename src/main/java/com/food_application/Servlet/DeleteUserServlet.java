package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.UserDAO;
import com.food_application.DAOApplication.UserDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {

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

        int userId =
                Integer.parseInt(request.getParameter("id"));

        dao.deleteUser(userId);

        response.sendRedirect("manageUsers?deleted=1");

    }

}