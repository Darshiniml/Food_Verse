package com.food_application.DAOApplication;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.food_application.DAO.OrderDAO;
import com.food_application.model.Order;
import com.food_application.utility.DBConnection;

public class OrderDAOImpl implements OrderDAO {

    private Connection con;

    public OrderDAOImpl() {
        con = DBConnection.getConnection();
    }

    @Override
    public int addOrder(Order order) {

        int orderId = 0;

        String query =
        "INSERT INTO orders(user_id,restaurant_id,total_amount,status,delivery_address) VALUES(?,?,?,?,?)";

        try {

            PreparedStatement ps = con.prepareStatement(query,
                    PreparedStatement.RETURN_GENERATED_KEYS);

            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getRestaurantId());
            ps.setDouble(3, order.getTotalAmount());
            ps.setString(4, order.getStatus());
            ps.setString(5, order.getDeliveryAddress());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();

            if(rs.next()){

                orderId = rs.getInt(1);

            }

        }

        catch(Exception e){

            e.printStackTrace();

        }

        return orderId;

    } 
    @Override
    public Order getOrderById(int orderId) {

        Order order = null;

        String query = "SELECT * FROM orders WHERE order_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                order = new Order();

                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setRestaurantId(rs.getInt("restaurant_id"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setOrderDate(rs.getTimestamp("order_date"));

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return order;
    }

    @Override
    public List<Order> getAllOrders() {

        List<Order> orders = new ArrayList<>();

        String query = "SELECT\r\n"
        		+ "o.*,\r\n"
        		+ "u.name AS customer_name,\r\n"
        		+ "r.restaurant_name\r\n"
        		+ "FROM orders o\r\n"
        		+ "JOIN users u\r\n"
        		+ "ON o.user_id=u.user_id\r\n"
        		+ "JOIN restaurants r\r\n"
        		+ "ON o.restaurant_id=r.restaurant_id\r\n"
        		+ "ORDER BY o.order_date DESC;";

        try {

            PreparedStatement ps =
                    con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

            	Order order = new Order();

            	order.setOrderId(rs.getInt("order_id"));
            	order.setUserId(rs.getInt("user_id"));
            	order.setRestaurantId(rs.getInt("restaurant_id"));
            	order.setTotalAmount(rs.getDouble("total_amount"));
            	order.setStatus(rs.getString("status"));
            	order.setDeliveryAddress(rs.getString("delivery_address"));
            	order.setOrderDate(rs.getTimestamp("order_date"));
            	order.setCustomerName(rs.getString("customer_name"));
            	order.setRestaurantName(rs.getString("restaurant_name"));
            	orders.add(order);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return orders;
    }
    @Override
    public List<Order> getReadyForPickupOrders(){

        List<Order> orders=new ArrayList<>();

        String query=

        "SELECT o.*,u.name customer_name,r.restaurant_name " +

        "FROM orders o " +

        "JOIN users u ON o.user_id=u.user_id " +

        "JOIN restaurants r ON o.restaurant_id=r.restaurant_id " +

        "WHERE o.status='READY_FOR_PICKUP' " +

        "AND o.delivery_agent_id IS NULL";

        try{

            PreparedStatement ps=con.prepareStatement(query);

            ResultSet rs=ps.executeQuery();

            while(rs.next()){

                Order order=new Order();

                order.setOrderId(rs.getInt("order_id"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setRestaurantName(rs.getString("restaurant_name"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setDeliveryAddress(rs.getString("delivery_address"));

                orders.add(order);

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return orders;

    }
    @Override
    public void assignDeliveryAgent(int orderId,
            int deliveryAgentId){

        String query=

        "UPDATE orders SET delivery_agent_id=?,status='OUT_FOR_DELIVERY' WHERE order_id=?";

        try{

            PreparedStatement ps=con.prepareStatement(query);

            ps.setInt(1,deliveryAgentId);

            ps.setInt(2,orderId);

            ps.executeUpdate();

        }catch(Exception e){

            e.printStackTrace();

        }

    }
    @Override
    public List<Order> getOrdersByRestaurantId(int restaurantId) {

        List<Order> orders = new ArrayList<>();

        String query =
                "SELECT o.*, u.name AS customer_name " +
                "FROM orders o " +
                "JOIN users u ON o.user_id = u.user_id " +
                "WHERE o.restaurant_id=? " +
                "ORDER BY o.order_date DESC";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, restaurantId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Order order = new Order();

                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setRestaurantId(rs.getInt("restaurant_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setCustomerName(rs.getString("customer_name"));

                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }
    @Override
    public int getDeliveryCount(int deliveryAgentId) {

        int count = 0;

        String query =
                "SELECT COUNT(*) FROM orders WHERE delivery_agent_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, deliveryAgentId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return count;
    }
    @Override
    public int getCompletedDeliveries(int deliveryAgentId) {

        int count = 0;

        String query =
                "SELECT COUNT(*) FROM orders " +
                "WHERE delivery_agent_id=? " +
                "AND status='DELIVERED'";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, deliveryAgentId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return count;
    }
    @Override
    public int getRestaurantOrderCount(int restaurantId) {

        int count = 0;

        String query =
                "SELECT COUNT(*) FROM orders WHERE restaurant_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, restaurantId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
    @Override
    public List<Order> getOrdersByDeliveryAgent(int deliveryAgentId) {

        List<Order> orders = new ArrayList<>();

        String query =
                "SELECT o.*, " +
                "u.name AS customer_name, " +
                "r.restaurant_name " +
                "FROM orders o " +
                "JOIN users u ON o.user_id = u.user_id " +
                "JOIN restaurants r ON o.restaurant_id = r.restaurant_id " +
                "WHERE o.delivery_agent_id = ? " +
                "ORDER BY o.order_date DESC";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, deliveryAgentId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Order order = new Order();

                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setRestaurantId(rs.getInt("restaurant_id"));
                order.setDeliveryAgentId(rs.getInt("delivery_agent_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setDeliveryAddress(rs.getString("delivery_address"));

                order.setCustomerName(rs.getString("customer_name"));
                order.setRestaurantName(rs.getString("restaurant_name"));

                orders.add(order);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return orders;
    }
    @Override
    public int getPendingRestaurantOrders(int restaurantId) {

        int count = 0;

        String query =
                "SELECT COUNT(*) FROM orders " +
                "WHERE restaurant_id=? AND status='PENDING'";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, restaurantId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
    @Override
    public double getRestaurantRevenue(int restaurantId) {

        double revenue = 0;

        String query =
                "SELECT SUM(total_amount) FROM orders " +
                "WHERE restaurant_id=? AND status='DELIVERED'";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, restaurantId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                revenue = rs.getDouble(1);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return revenue;
    }
    @Override
    public List<Order> getOrdersByUserId(int userId) {

        List<Order> orders = new ArrayList<>();

        String query =
        "SELECT * FROM orders WHERE user_id=? ORDER BY order_date DESC";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                Order order = new Order();

                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setRestaurantId(rs.getInt("restaurant_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setDeliveryAddress(rs.getString("delivery_address"));

                orders.add(order);

            }

        }

        catch(Exception e){

            e.printStackTrace();

        }

        return orders;

    }
    @Override
    public void updateOrder(Order order) {

        String query =
                "UPDATE orders SET user_id=?, restaurant_id=?, total_amount=?, status=?, delivery_address=? WHERE order_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getRestaurantId());
            ps.setDouble(3, order.getTotalAmount());
            ps.setString(4, order.getStatus());
            ps.setString(5, order.getDeliveryAddress());
            ps.setInt(6, order.getOrderId());

            ps.executeUpdate();

        } catch (Exception e) {

            e.printStackTrace();

        }
    }
    @Override
    public double getTotalRevenue() {

        double revenue = 0;

        String query = "SELECT SUM(total_amount) FROM orders";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                revenue = rs.getDouble(1);

            }

        } catch(Exception e) {

            e.printStackTrace();

        }

        return revenue;
    }
    @Override
    public List<Order> getPendingOrders(){

        List<Order> list=new ArrayList<>();

        String query=
        "SELECT * FROM orders WHERE status='PENDING'";

        try{

            PreparedStatement ps=
                    con.prepareStatement(query);

            ResultSet rs=ps.executeQuery();

            while(rs.next()){

                Order order=new Order();

                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setRestaurantId(rs.getInt("restaurant_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setDeliveryAddress(
                        rs.getString("delivery_address"));

                list.add(order);

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return list;

    }
    @Override
    public List<Order> getOrdersByStatus(String status){

        List<Order> list=new ArrayList<>();

        String query=
        "SELECT * FROM orders WHERE status=?";

        try{

            PreparedStatement ps=
                    con.prepareStatement(query);

            ps.setString(1,status);

            ResultSet rs=ps.executeQuery();

            while(rs.next()){

                Order order=new Order();

                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setRestaurantId(rs.getInt("restaurant_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setDeliveryAddress(
                        rs.getString("delivery_address"));

                list.add(order);

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return list;

    }
    @Override
    public void updateOrderStatus(int orderId,
            String status){

        String query=
        "UPDATE orders SET status=? WHERE order_id=?";

        try{

            PreparedStatement ps=
                    con.prepareStatement(query);

            ps.setString(1,status);

            ps.setInt(2,orderId);

            ps.executeUpdate();

        }

        catch(Exception e){

            e.printStackTrace();

        }

    }
    @Override
    public int getPendingOrderCount() {

        int count = 0;

        String query =
        "SELECT COUNT(*) FROM orders WHERE status='PENDING'";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                count = rs.getInt(1);

            }

        } catch(Exception e) {

            e.printStackTrace();

        }

        return count;
    }
    @Override
    public int getOrderCount() {

        int count = 0;

        String query = "SELECT COUNT(*) FROM orders";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                count = rs.getInt(1);

            }

        } catch(Exception e) {

            e.printStackTrace();

        }

        return count;
    }
    @Override
    public void deleteOrder(int orderId) {

        String query =
        "DELETE FROM orders WHERE order_id=?";

        try {

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, orderId);

            ps.executeUpdate();

            System.out.println("Order Deleted Successfully");

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}