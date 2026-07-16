package com.food_application.Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import org.json.JSONArray;
import org.json.JSONObject;

import com.food_application.DAO.OrderDAO;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.model.Order;
import com.food_application.model.OrderStatus;
import com.food_application.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/trackOrder")
public class TrackOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final OrderDAO orderDAO = new OrderDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("loggedUser");
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        JSONObject payload = new JSONObject();
        if (user == null) {
            payload.put("error", "Please log in first.");
            write(response, payload);
            return;
        }

        Order order = orderDAO.getTrackingDetails(orderId);
        if (order == null || order.getUserId() != user.getUserId()) {
            payload.put("error", "Order not found.");
            write(response, payload);
            return;
        }

        OrderStatus status = orderDAO.getOrderStatus(orderId);
        payload.put("orderId", orderId);
        payload.put("restaurantName", order.getRestaurantName());
        payload.put("deliveryPartner", order.getDeliveryAgentName() == null ? JSONObject.NULL : order.getDeliveryAgentName());
        payload.put("status", status.dbValue());
        payload.put("progress", buildProgress(status));
        payload.put("timeline", buildTimeline(order));
        payload.put("currentIndex", buildCurrentIndex(status));
        payload.put("completed", status == OrderStatus.DELIVERED);

        write(response, payload);
    }

    private JSONArray buildTimeline(Order order) {
        JSONArray timeline = new JSONArray();
        addStep(timeline, "Order Placed", order.getOrderDate() != null, order.getOrderDate());
        addStep(timeline, "Restaurant Accepted", order.getAcceptedAt() != null, order.getAcceptedAt());
        addStep(timeline, "Preparing Food", order.getPreparingAt() != null, order.getPreparingAt());
        addStep(timeline, "Food Ready", order.getReadyAt() != null, order.getReadyAt());
        addStep(timeline, "Picked Up", order.getPickedUpAt() != null, order.getPickedUpAt());
        addStep(timeline, "Out For Delivery", order.getOutForDeliveryAt() != null, order.getOutForDeliveryAt());
        addStep(timeline, "Delivered", order.getDeliveredAt() != null, order.getDeliveredAt());
        return timeline;
    }

    private void addStep(JSONArray timeline, String label, boolean completed, java.sql.Timestamp time) {
        JSONObject step = new JSONObject();
        step.put("label", label);
        step.put("completed", completed);
        step.put("timestamp", time == null ? JSONObject.NULL : time.toString());
        timeline.put(step);
    }

    private int buildProgress(OrderStatus status) {
        switch (status) {
            case PLACED: return 14;
            case ACCEPTED: return 28;
            case PREPARING: return 42;
            case READY: return 57;
            case ASSIGNED: return 71;
            case PICKED_UP: return 85;
            case OUT_FOR_DELIVERY: return 93;
            case DELIVERED: return 100;
            case CANCELLED: default: return 0;
        }
    }

    private int buildCurrentIndex(OrderStatus status) {
        switch (status) {
            case PLACED: return 0;
            case ACCEPTED: return 1;
            case PREPARING: return 2;
            case READY: return 3;
            case ASSIGNED: return 4;
            case PICKED_UP: return 5;
            case OUT_FOR_DELIVERY: return 6;
            case DELIVERED: return 6;
            case CANCELLED: default: return 0;
        }
    }

    private void write(HttpServletResponse response, JSONObject payload) throws IOException {
        try (PrintWriter out = response.getWriter()) {
            out.print(payload.toString());
        }
    }
}
