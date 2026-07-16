package com.food_application.DAO;

import java.util.List;
import com.food_application.model.Order;
import com.food_application.model.OrderStatus;

public interface OrderDAO {

    int addOrder(Order order);

    Order getOrderById(int orderId);

    List<Order> getAllOrders();

    List<Order> getOrdersByUserId(int userId);

    void updateOrder(Order order);

    void deleteOrder(int orderId);
    int getOrderCount();

    double getTotalRevenue();

    int getPendingOrderCount();
    List<Order> getPendingOrders();

    List<Order> getOrdersByStatus(String status);

    void updateOrderStatus(int orderId, String status);
    void updateOrderStatus(int orderId, OrderStatus status);
    OrderStatus getOrderStatus(int orderId);
    Order getTrackingDetails(int orderId);
    List<Order> getOrdersByRestaurantId(int restaurantId);

    int getRestaurantOrderCount(int restaurantId);

    double getRestaurantRevenue(int restaurantId);

    int getPendingRestaurantOrders(int restaurantId);
    List<Order> getReadyForPickupOrders();

    List<Order> getOrdersByDeliveryAgent(int deliveryAgentId);

    void assignDeliveryAgent(int orderId,int deliveryAgentId);

    int getDeliveryCount(int deliveryAgentId);

    int getCompletedDeliveries(int deliveryAgentId);
}
