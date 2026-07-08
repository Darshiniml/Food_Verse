package com.food_application.model;

public class OrderItem {

    private int orderItemId;
    private int orderId;
    private int foodId;
    private int quantity;
    private double subtotal;
    private FoodItem foodItem;
    public OrderItem() {

    }

    public OrderItem(int orderItemId,
                     int orderId,
                     int foodId,
                     int quantity,
                     double subtotal) {

        this.orderItemId = orderItemId;
        this.orderId = orderId;
        this.foodId = foodId;
        this.quantity = quantity;
        this.subtotal = subtotal;
    }

    public int getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getFoodId() {
        return foodId;
    }

    public void setFoodId(int foodId) {
        this.foodId = foodId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
    public FoodItem getFoodItem() {
        return foodItem;
    }

    public void setFoodItem(FoodItem foodItem) {
        this.foodItem = foodItem;
    }

}