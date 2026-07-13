package com.food_application.model;

public class DashboardStats {

    private int totalUsers;
    private int totalRestaurants;
    private int totalFoodItems;
    private int totalOrders;
    private int pendingOrders;
    private double totalRevenue;

    public DashboardStats() {}

    public int getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(int totalUsers) {
        this.totalUsers = totalUsers;
    }

    public int getTotalRestaurants() {
        return totalRestaurants;
    }

    public void setTotalRestaurants(int totalRestaurants) {
        this.totalRestaurants = totalRestaurants;
    }

    public int getTotalFoodItems() {
        return totalFoodItems;
    }

    public void setTotalFoodItems(int totalFoodItems) {
        this.totalFoodItems = totalFoodItems;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    public int getPendingOrders() {
        return pendingOrders;
    }

    public void setPendingOrders(int pendingOrders) {
        this.pendingOrders = pendingOrders;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

}