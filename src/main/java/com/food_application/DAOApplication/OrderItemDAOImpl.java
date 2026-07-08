package com.food_application.DAOApplication;
import com.food_application.DAO.FoodItemDAO;
import com.food_application.DAOApplication.FoodItemDAOImpl;
import com.food_application.model.FoodItem;
import com.food_application.model.OrderItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.food_application.DAO.OrderItemDAO;
import com.food_application.model.FoodItem;
import com.food_application.model.OrderItem;
import com.food_application.utility.DBConnection;

public class OrderItemDAOImpl implements OrderItemDAO {

    private Connection con;

    public OrderItemDAOImpl() {

        con = DBConnection.getConnection();

    }

    @Override
    public void addOrderItem(OrderItem item) {

        String query =
                "INSERT INTO order_items(order_id, food_id, quantity, subtotal) VALUES(?,?,?,?)";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, item.getOrderId());
            ps.setInt(2, item.getFoodId());
            ps.setInt(3, item.getQuantity());
            ps.setDouble(4, item.getSubtotal());

            ps.executeUpdate();

        } catch (Exception e) {

            e.printStackTrace();

        }

    }

    @Override
    public OrderItem getOrderItemById(int orderItemId) {

        OrderItem item = null;

        String query =
                "SELECT * FROM order_items WHERE order_item_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, orderItemId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                item = new OrderItem();

                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setFoodId(rs.getInt("food_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setSubtotal(rs.getDouble("subtotal"));

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return item;

    }

    @Override
    public List<OrderItem> getAllOrderItems() {

        List<OrderItem> list = new ArrayList<>();

        String query = "SELECT * FROM order_items";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                OrderItem item = new OrderItem();

                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setFoodId(rs.getInt("food_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setSubtotal(rs.getDouble("subtotal"));

                list.add(item);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }

    @Override
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {

        List<OrderItem> items = new ArrayList<>();

        String query =
        "SELECT * FROM order_items WHERE order_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            FoodItemDAO foodDAO = new FoodItemDAOImpl();

            while(rs.next()){

                OrderItem item = new OrderItem();

                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setFoodId(rs.getInt("food_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setSubtotal(rs.getDouble("subtotal"));

                // VERY IMPORTANT
                FoodItem food = foodDAO.getFoodItemById(item.getFoodId());

                item.setFoodItem(food);

                items.add(item);

            }

        } catch(Exception e){

            e.printStackTrace();

        }

        return items;

    }
    @Override
    public void updateOrderItem(OrderItem item) {

        String query =
                "UPDATE order_items SET order_id=?, food_id=?, quantity=?, subtotal=? WHERE order_item_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, item.getOrderId());
            ps.setInt(2, item.getFoodId());
            ps.setInt(3, item.getQuantity());
            ps.setDouble(4, item.getSubtotal());
            ps.setInt(5, item.getOrderItemId());

            ps.executeUpdate();

        } catch (Exception e) {

            e.printStackTrace();

        }

    }

    @Override
    public void deleteOrderItem(int orderItemId) {

        String query =
                "DELETE FROM order_items WHERE order_item_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, orderItemId);

            ps.executeUpdate();

        } catch (Exception e) {

            e.printStackTrace();

        }

    }

}