package com.food_application.model;

import java.sql.Timestamp;

public class Order {

    private int orderId;
    private int userId;
    private int restaurantId;
    private Timestamp orderDate;
    private double totalAmount;
    private String status;
    private String orderStatus;
    private String deliveryAddress;
    private Timestamp acceptedAt;
    private Timestamp preparingAt;
    private Timestamp readyAt;
    private Timestamp assignedAt;
    private Timestamp pickedUpAt;
    private Timestamp outForDeliveryAt;
    private Timestamp deliveredAt;
    private String customerName;
    private String restaurantName;
    private String deliveryAgentName;
    private int deliveryAgentId;

    public Order() {
    }

    public Order(int orderId, int userId, int restaurantId, Timestamp orderDate,
            double totalAmount, String status, String deliveryAddress) {
        this.orderId = orderId;
        this.userId = userId;
        this.restaurantId = restaurantId;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.status = status;
        this.orderStatus = status;
        this.deliveryAddress = deliveryAddress;
    }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public String getStatus() { return orderStatus != null ? orderStatus : status; }
    public void setStatus(String status) { this.status = status; this.orderStatus = status; }
    public String getOrderStatus() { return orderStatus != null ? orderStatus : status; }
    public void setOrderStatus(String orderStatus) { this.orderStatus = orderStatus; this.status = orderStatus; }
    public String getDeliveryAddress() { return deliveryAddress; }
    public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }
    public Timestamp getAcceptedAt() { return acceptedAt; }
    public void setAcceptedAt(Timestamp acceptedAt) { this.acceptedAt = acceptedAt; }
    public Timestamp getPreparingAt() { return preparingAt; }
    public void setPreparingAt(Timestamp preparingAt) { this.preparingAt = preparingAt; }
    public Timestamp getReadyAt() { return readyAt; }
    public void setReadyAt(Timestamp readyAt) { this.readyAt = readyAt; }
    public Timestamp getAssignedAt() { return assignedAt; }
    public void setAssignedAt(Timestamp assignedAt) { this.assignedAt = assignedAt; }
    public Timestamp getPickedUpAt() { return pickedUpAt; }
    public void setPickedUpAt(Timestamp pickedUpAt) { this.pickedUpAt = pickedUpAt; }
    public Timestamp getOutForDeliveryAt() { return outForDeliveryAt; }
    public void setOutForDeliveryAt(Timestamp outForDeliveryAt) { this.outForDeliveryAt = outForDeliveryAt; }
    public Timestamp getDeliveredAt() { return deliveredAt; }
    public void setDeliveredAt(Timestamp deliveredAt) { this.deliveredAt = deliveredAt; }
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    public String getRestaurantName() { return restaurantName; }
    public void setRestaurantName(String restaurantName) { this.restaurantName = restaurantName; }
    public String getDeliveryAgentName() { return deliveryAgentName; }
    public void setDeliveryAgentName(String deliveryAgentName) { this.deliveryAgentName = deliveryAgentName; }
    public int getDeliveryAgentId() { return deliveryAgentId; }
    public void setDeliveryAgentId(int deliveryAgentId) { this.deliveryAgentId = deliveryAgentId; }
}
