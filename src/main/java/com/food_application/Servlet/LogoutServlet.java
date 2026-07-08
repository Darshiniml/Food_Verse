package com.food_application.Servlet;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet{

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        if(session != null){

            session.invalidate();

        }

        response.sendRedirect("home");

    }

}