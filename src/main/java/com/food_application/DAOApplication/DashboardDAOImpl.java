package com.food_application.DAOApplication;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import com.food_application.model.Activity;
import com.food_application.DAO.DashboardDAO;
import com.food_application.model.DashboardStats;
import com.food_application.model.RecentOrder;
import com.food_application.model.TopFood;
import com.food_application.model.TopRestaurant;
import com.food_application.utility.DBConnection;

public class DashboardDAOImpl implements DashboardDAO {

	@Override
	public DashboardStats getDashboardStats() {

	    DashboardStats stats = new DashboardStats();

	    try (Connection con = DBConnection.getConnection()) {

	        PreparedStatement ps;
	        ResultSet rs;

	        // ================= USERS =================

	        ps = con.prepareStatement(
	                "SELECT COUNT(*) FROM users");
	        rs = ps.executeQuery();

	        if (rs.next()) {
	            stats.setTotalUsers(rs.getInt(1));
	        }

	        rs.close();
	        ps.close();

	        // ================= RESTAURANTS =================

	        ps = con.prepareStatement(
	                "SELECT COUNT(*) FROM restaurants");
	        rs = ps.executeQuery();

	        if (rs.next()) {
	            stats.setTotalRestaurants(rs.getInt(1));
	        }

	        rs.close();
	        ps.close();

	        // ================= FOOD ITEMS =================

	        ps = con.prepareStatement(
	                "SELECT COUNT(*) FROM food_items");
	        rs = ps.executeQuery();

	        if (rs.next()) {
	            stats.setTotalFoodItems(rs.getInt(1));
	        }

	        rs.close();
	        ps.close();

	        // ================= ORDERS =================

	        ps = con.prepareStatement(
	                "SELECT COUNT(*) FROM orders");
	        rs = ps.executeQuery();

	        if (rs.next()) {
	            stats.setTotalOrders(rs.getInt(1));
	        }

	        rs.close();
	        ps.close();

	        // ================= PENDING ORDERS =================

	        ps = con.prepareStatement(
	                "SELECT COUNT(*) FROM orders WHERE status='PENDING'");
	        rs = ps.executeQuery();

	        if (rs.next()) {
	            stats.setPendingOrders(rs.getInt(1));
	        }

	        rs.close();
	        ps.close();

	        // ================= REVENUE =================

	        ps = con.prepareStatement(
	                "SELECT IFNULL(SUM(amount),0) FROM payments WHERE payment_status='SUCCESS'");
	        rs = ps.executeQuery();

	        if (rs.next()) {
	            stats.setTotalRevenue(rs.getDouble(1));
	        }

	        rs.close();
	        ps.close();

	    }

	    catch (Exception e) {

	        e.printStackTrace();

	    }

	    return stats;

	}

	@Override
	public List<RecentOrder> getRecentOrders() {

	    List<RecentOrder> orders = new ArrayList<>();

	    String sql = """
	        SELECT
	            o.order_id,
	            u.name,
	            r.restaurant_name,
	            o.total_amount,
	            o.status
	        FROM orders o
	        INNER JOIN users u
	            ON o.user_id = u.user_id
	        INNER JOIN restaurants r
	            ON o.restaurant_id = r.restaurant_id
	        ORDER BY o.order_id DESC
	        LIMIT 5
	        """;

	    try (
	        Connection con = DBConnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();
	    ) {

	        while (rs.next()) {

	            RecentOrder order = new RecentOrder();

	            order.setOrderId(rs.getInt("order_id"));
	            order.setCustomerName(rs.getString("name"));
	            order.setRestaurantName(rs.getString("restaurant_name"));
	            order.setAmount(rs.getDouble("total_amount"));
	            order.setStatus(rs.getString("status"));

	            orders.add(order);
	        }

	    } catch (Exception e) {

	        e.printStackTrace();

	    }

	    return orders;

	}

	@Override
	public TopRestaurant getTopRestaurant() {

	    TopRestaurant restaurant = new TopRestaurant();

	    String sql = """
	        SELECT
	            r.restaurant_name,
	            COUNT(o.order_id) totalOrders
	        FROM restaurants r
	        INNER JOIN orders o
	            ON r.restaurant_id = o.restaurant_id
	        GROUP BY r.restaurant_name
	        ORDER BY totalOrders DESC
	        LIMIT 1
	        """;

	    try (
	        Connection con = DBConnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();
	    ) {

	        if (rs.next()) {

	            restaurant.setRestaurantName(rs.getString("restaurant_name"));
	            restaurant.setTotalOrders(rs.getInt("totalOrders"));

	        }

	    } catch (Exception e) {

	        e.printStackTrace();

	    }

	    return restaurant;

	}

	@Override
	public TopFood getTopFood() {

	    TopFood food = new TopFood();

	    String sql = """
	        SELECT
	            f.food_name,
	            SUM(oi.quantity) totalSold
	        FROM food_items f
	        INNER JOIN order_items oi
	            ON f.food_id = oi.food_id
	        GROUP BY f.food_name
	        ORDER BY totalSold DESC
	        LIMIT 1
	        """;

	    try (
	        Connection con = DBConnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();
	    ) {

	        if (rs.next()) {

	            food.setFoodName(rs.getString("food_name"));
	            food.setTotalOrders(rs.getInt("totalSold"));

	        }

	    } catch (Exception e) {

	        e.printStackTrace();

	    }

	    return food;

	}
	@Override
	public Map<String, Double> getMonthlyRevenue() {

	    Map<String, Double> revenue = new LinkedHashMap<>();

	    String sql = """
	        SELECT

	            MONTHNAME(order_date) month,

	            SUM(total_amount) revenue

	        FROM orders

	        GROUP BY MONTH(order_date),

	                 MONTHNAME(order_date)

	        ORDER BY MONTH(order_date)
	        """;

	    try (
	        Connection con = DBConnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();
	    ) {

	        while (rs.next()) {

	            revenue.put(

	                    rs.getString("month"),

	                    rs.getDouble("revenue")

	            );

	        }

	    } catch (Exception e) {

	        e.printStackTrace();

	    }

	    return revenue;

	}

    @Override
    public Map<String, Integer> getOrderStatus() {

        Map<String, Integer> status = new LinkedHashMap<>();

        String sql = """
            SELECT
                status,
                COUNT(*) total
            FROM orders
            GROUP BY status
            """;

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
        ) {

            while (rs.next()) {

                status.put(

                        rs.getString("status"),

                        rs.getInt("total")

                );

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return status;

    }
    @Override
    public List<Activity> getRecentActivities() {

        List<Activity> activities = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            // Latest Orders
            String orderSql = """
                SELECT order_id,status
                FROM orders
                ORDER BY order_date DESC
                LIMIT 3
                """;

            PreparedStatement ps = con.prepareStatement(orderSql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                activities.add(new Activity(

                        "bi-bag-check-fill",

                        "Order #" + rs.getInt("order_id")
                                + " is "
                                + rs.getString("status"),

                        "success"));

            }

            rs.close();
            ps.close();

            // Latest Payment
            String paymentSql = """
                SELECT payment_id,amount
                FROM payments
                ORDER BY payment_date DESC
                LIMIT 1
                """;

            ps = con.prepareStatement(paymentSql);
            rs = ps.executeQuery();

            if (rs.next()) {

                activities.add(new Activity(

                        "bi-credit-card-fill",

                        "Payment ₹"
                                + rs.getDouble("amount")
                                + " received",

                        "primary"));

            }

            rs.close();
            ps.close();

            // Latest User
            String userSql = """
                SELECT name
                FROM users
                ORDER BY user_id DESC
                LIMIT 1
                """;

            ps = con.prepareStatement(userSql);
            rs = ps.executeQuery();

            if (rs.next()) {

                activities.add(new Activity(

                        "bi-person-plus-fill",

                        rs.getString("name")
                                + " registered",

                        "warning"));

            }

            rs.close();
            ps.close();

            // Latest Restaurant
            String restaurantSql = """
                SELECT restaurant_name
                FROM restaurants
                ORDER BY restaurant_id DESC
                LIMIT 1
                """;

            ps = con.prepareStatement(restaurantSql);
            rs = ps.executeQuery();

            if (rs.next()) {

                activities.add(new Activity(

                        "bi-shop",

                        rs.getString("restaurant_name")
                                + " added",

                        "info"));

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return activities;

    }

}