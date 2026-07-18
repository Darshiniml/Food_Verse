package com.food_application.Servlet;

import java.io.IOException;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.model.OrderStatus;
import com.food_application.model.User;
import com.food_application.utility.NotificationService;
import com.food_application.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/acceptDelivery")
public class AcceptDeliveryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO dao;

    @Override
    public void init() {

        dao = new OrderDAOImpl();

    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user =
        (User)session.getAttribute("loggedUser");

        int orderId =
        Integer.parseInt(request.getParameter("orderId"));

        if (dao.getOrderStatus(orderId) == OrderStatus.READY) {
            dao.assignDeliveryAgent(orderId,
                    user.getUserId());
            NotificationService.forStatus(dao.getTrackingDetails(orderId).getUserId(), orderId, OrderStatus.ASSIGNED);
        }

        response.sendRedirect("availableOrders");

    }

}
