package com.food_application.DAOApplication;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.food_application.DAO.OrderDAO;
import com.food_application.model.Order;
import com.food_application.model.OrderStatus;
import com.food_application.utility.DBConnection;

public class OrderDAOImpl implements OrderDAO {

    private Connection con;

    public OrderDAOImpl() {
        con = DBConnection.getConnection();
        ensureTrackingColumns();
    }

    private void ensureTrackingColumns() {
        try {
            addColumnIfMissing("order_status", "VARCHAR(30) DEFAULT 'PLACED'");
            addColumnIfMissing("accepted_at", "TIMESTAMP NULL");
            addColumnIfMissing("preparing_at", "TIMESTAMP NULL");
            addColumnIfMissing("ready_at", "TIMESTAMP NULL");
            addColumnIfMissing("assigned_at", "TIMESTAMP NULL");
            addColumnIfMissing("picked_up_at", "TIMESTAMP NULL");
            addColumnIfMissing("out_for_delivery_at", "TIMESTAMP NULL");
            addColumnIfMissing("delivered_at", "TIMESTAMP NULL");
            try (PreparedStatement ps = con.prepareStatement(
                    "UPDATE orders SET order_status = COALESCE(order_status, status, 'PLACED') WHERE order_status IS NULL OR order_status = ''")) {
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void addColumnIfMissing(String columnName, String definition) throws Exception {
        try (ResultSet rs = con.getMetaData().getColumns(null, null, "orders", columnName)) {
            if (!rs.next()) {
                try (PreparedStatement ps = con.prepareStatement(
                        "ALTER TABLE orders ADD COLUMN " + columnName + " " + definition)) {
                    ps.executeUpdate();
                }
            }
        }
    }

    private String normalizeStatus(String status) {
        return OrderStatus.fromString(status).dbValue();
    }

    private TimestampColumnPair timestampForStatus(OrderStatus status) {
        switch (status) {
            case ACCEPTED:
                return new TimestampColumnPair("accepted_at");
            case PREPARING:
                return new TimestampColumnPair("preparing_at");
            case READY:
                return new TimestampColumnPair("ready_at");
            case ASSIGNED:
                return new TimestampColumnPair("assigned_at");
            case PICKED_UP:
                return new TimestampColumnPair("picked_up_at");
            case OUT_FOR_DELIVERY:
                return new TimestampColumnPair("out_for_delivery_at");
            case DELIVERED:
                return new TimestampColumnPair("delivered_at");
            default:
                return new TimestampColumnPair(null);
        }
    }

    private static class TimestampColumnPair {
        private final String columnName;
        private TimestampColumnPair(String columnName) {
            this.columnName = columnName;
        }
    }

    @Override
    public int addOrder(Order order) {

        int orderId = 0;

        String query =
        "INSERT INTO orders(user_id,restaurant_id,total_amount,status,order_status,delivery_address,accepted_at,preparing_at,ready_at,assigned_at,picked_up_at,out_for_delivery_at,delivered_at) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";

        try {

            PreparedStatement ps = con.prepareStatement(query,
                    PreparedStatement.RETURN_GENERATED_KEYS);

            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getRestaurantId());
            ps.setDouble(3, order.getTotalAmount());
            ps.setString(4, normalizeStatus(order.getStatus()));
            ps.setString(5, normalizeStatus(order.getStatus()));
            ps.setString(6, order.getDeliveryAddress());
            ps.setTimestamp(7, order.getAcceptedAt());
            ps.setTimestamp(8, order.getPreparingAt());
            ps.setTimestamp(9, order.getReadyAt());
            ps.setTimestamp(10, order.getAssignedAt());
            ps.setTimestamp(11, order.getPickedUpAt());
            ps.setTimestamp(12, order.getOutForDeliveryAt());
            ps.setTimestamp(13, order.getDeliveredAt());

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

        "WHERE COALESCE(o.order_status,o.status)='READY' " +

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

        "UPDATE orders SET delivery_agent_id=?,status='ASSIGNED',order_status='ASSIGNED',assigned_at=COALESCE(assigned_at,NOW()) WHERE order_id=?";

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
                "AND COALESCE(order_status,status)='DELIVERED'";

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
                "WHERE restaurant_id=? AND COALESCE(order_status,status)='PLACED'";

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
                "WHERE restaurant_id=? AND COALESCE(order_status,status)='DELIVERED'";

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
        "SELECT * FROM orders WHERE COALESCE(order_status,status)='PLACED'";

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
        "UPDATE orders SET status=?, order_status=?, accepted_at=CASE WHEN ?='ACCEPTED' AND accepted_at IS NULL THEN NOW() ELSE accepted_at END, "
        + "preparing_at=CASE WHEN ?='PREPARING' AND preparing_at IS NULL THEN NOW() ELSE preparing_at END, "
        + "ready_at=CASE WHEN ?='READY' AND ready_at IS NULL THEN NOW() ELSE ready_at END, "
        + "assigned_at=CASE WHEN ?='ASSIGNED' AND assigned_at IS NULL THEN NOW() ELSE assigned_at END, "
        + "picked_up_at=CASE WHEN ?='PICKED_UP' AND picked_up_at IS NULL THEN NOW() ELSE picked_up_at END, "
        + "out_for_delivery_at=CASE WHEN ?='OUT_FOR_DELIVERY' AND out_for_delivery_at IS NULL THEN NOW() ELSE out_for_delivery_at END, "
        + "delivered_at=CASE WHEN ?='DELIVERED' AND delivered_at IS NULL THEN NOW() ELSE delivered_at END WHERE order_id=?";

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
    public void updateOrderStatus(int orderId, OrderStatus status) {
        updateOrderStatus(orderId, status == null ? null : status.dbValue());
    }

    @Override
    public OrderStatus getOrderStatus(int orderId) {
        String query = "SELECT COALESCE(order_status, status) AS current_status FROM orders WHERE order_id=?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return OrderStatus.fromString(rs.getString("current_status"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return OrderStatus.PLACED;
    }

    @Override
    public Order getTrackingDetails(int orderId) {
        String query =
                "SELECT o.*, r.restaurant_name, da.name delivery_agent_name " +
                "FROM orders o " +
                "LEFT JOIN restaurants r ON o.restaurant_id=r.restaurant_id " +
                "LEFT JOIN users da ON o.delivery_agent_id=da.user_id " +
                "WHERE o.order_id=?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setRestaurantId(rs.getInt("restaurant_id"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("order_status") != null ? rs.getString("order_status") : rs.getString("status"));
                    order.setDeliveryAddress(rs.getString("delivery_address"));
                    order.setAcceptedAt(rs.getTimestamp("accepted_at"));
                    order.setPreparingAt(rs.getTimestamp("preparing_at"));
                    order.setReadyAt(rs.getTimestamp("ready_at"));
                    order.setAssignedAt(rs.getTimestamp("assigned_at"));
                    order.setPickedUpAt(rs.getTimestamp("picked_up_at"));
                    order.setOutForDeliveryAt(rs.getTimestamp("out_for_delivery_at"));
                    order.setDeliveredAt(rs.getTimestamp("delivered_at"));
                    order.setRestaurantName(rs.getString("restaurant_name"));
                    order.setDeliveryAgentName(rs.getString("delivery_agent_name"));
                    order.setDeliveryAgentId(rs.getInt("delivery_agent_id"));
                    return order;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    @Override
    public int getPendingOrderCount() {

        int count = 0;

        String query =
        "SELECT COUNT(*) FROM orders WHERE COALESCE(order_status,status)='PLACED'";

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
