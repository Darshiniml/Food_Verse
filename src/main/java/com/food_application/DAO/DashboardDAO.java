package com.food_application.DAO;

import java.util.List;
import java.util.Map;
import com.food_application.model.Activity;
import com.food_application.model.DashboardStats;
import com.food_application.model.RecentOrder;
import com.food_application.model.TopFood;
import com.food_application.model.TopRestaurant;

public interface DashboardDAO {

    // Dashboard Cards
    DashboardStats getDashboardStats();

    // Recent Orders
    List<RecentOrder> getRecentOrders();

    // Top Restaurant
    TopRestaurant getTopRestaurant();

    // Best Selling Food
    TopFood getTopFood();

    // Revenue Chart
    Map<String, Double> getMonthlyRevenue();

    // Order Status Chart
    Map<String, Integer> getOrderStatus();
    List<Activity> getRecentActivities();

}