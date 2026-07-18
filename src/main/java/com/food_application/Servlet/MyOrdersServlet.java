package com.food_application.Servlet;

import java.io.IOException;
import java.util.List;
import java.util.LinkedHashMap;
import java.util.Map;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAO.OrderItemDAO;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.DAOApplication.OrderItemDAOImpl;
import com.food_application.model.Order;
import com.food_application.model.OrderItem;
import com.food_application.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/myOrders")
public class MyOrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null || session.getAttribute("loggedUser") == null){

            response.sendRedirect("login.jsp");

            return;
        }

        User user = (User)session.getAttribute("loggedUser");

        if(user == null){

            response.sendRedirect("login.jsp");

            return;
        }

        OrderDAO dao = new OrderDAOImpl();

        List<Order> orders =
                dao.getOrdersByUserId(user.getUserId());

        OrderItemDAO orderItemDAO = new OrderItemDAOImpl();
        Map<Integer, List<OrderItem>> orderItemsByOrder = new LinkedHashMap<>();
        for (Order order : orders) {
            orderItemsByOrder.put(order.getOrderId(),
                    orderItemDAO.getOrderItemsByOrderId(order.getOrderId()));
        }

        request.setAttribute("orders", orders);
        request.setAttribute("orderItemsByOrder", orderItemsByOrder);

        request.getRequestDispatcher("myOrders.jsp")
               .forward(request, response);

    }

}
