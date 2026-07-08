package com.food_application.DAOApplication;

import java.sql.*;
import java.util.*;

import com.food_application.DAO.RestaurantDAO;
import com.food_application.model.Restaurant;
import com.food_application.utility.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO {

    private Connection con;

    public RestaurantDAOImpl() {
        con = DBConnection.getConnection();
    }

    @Override
    public void addRestaurant(Restaurant restaurant) {

        String query =
        "INSERT INTO restaurants(restaurant_name,cuisine_type,address,rating,image,user_id) VALUES(?,?,?,?,?,?)";

        try {

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setString(1, restaurant.getRestaurantName());
            ps.setString(2, restaurant.getCuisineType());
            ps.setString(3, restaurant.getAddress());
            ps.setDouble(4, restaurant.getRating());
            ps.setString(5, restaurant.getImage());
            ps.setInt(6, restaurant.getUserId());
            ps.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Restaurant getRestaurantById(int restaurantId) {

        Restaurant restaurant = null;

        String query = "SELECT * FROM restaurants WHERE restaurant_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, restaurantId);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                restaurant = new Restaurant();

                restaurant.setRestaurantId(rs.getInt("restaurant_id"));
                restaurant.setRestaurantName(rs.getString("restaurant_name"));
                restaurant.setCuisineType(rs.getString("cuisine_type"));
                restaurant.setAddress(rs.getString("address"));
                restaurant.setRating(rs.getDouble("rating"));
                restaurant.setImage(rs.getString("image"));
                restaurant.setUserId(rs.getInt("user_id"));
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return restaurant;
    }
    @Override
    public int getRestaurantCount() {

        int count = 0;

        String query = "SELECT COUNT(*) FROM restaurants";

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
    public Restaurant getRestaurantByUserId(int userId){

        Restaurant restaurant=null;

        String query=
        "SELECT * FROM restaurants WHERE user_id=?";

        try{

            PreparedStatement ps=
                    con.prepareStatement(query);

            ps.setInt(1,userId);

            ResultSet rs=ps.executeQuery();

            if(rs.next()){

                restaurant=new Restaurant();

                restaurant.setRestaurantId(rs.getInt("restaurant_id"));
                restaurant.setRestaurantName(rs.getString("restaurant_name"));
                restaurant.setCuisineType(rs.getString("cuisine_type"));
                restaurant.setAddress(rs.getString("address"));
                restaurant.setRating(rs.getDouble("rating"));
                restaurant.setImage(rs.getString("image"));
                restaurant.setUserId(rs.getInt("user_id"));

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return restaurant;

    }
    @Override
    public List<Restaurant> getAllRestaurants() {

        List<Restaurant> restaurants = new ArrayList<>();

        String query = "SELECT * FROM restaurants";

        try {

            System.out.println("Connection = " + con);

            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                System.out.println("Restaurant Found : "
                        + rs.getString("restaurant_name"));

                Restaurant restaurant = new Restaurant();

                restaurant.setRestaurantId(rs.getInt("restaurant_id"));
                restaurant.setRestaurantName(rs.getString("restaurant_name"));
                restaurant.setCuisineType(rs.getString("cuisine_type"));
                restaurant.setAddress(rs.getString("address"));
                restaurant.setRating(rs.getDouble("rating"));
                restaurant.setImage(rs.getString("image"));
                restaurant.setUserId(rs.getInt("user_id"));
                restaurants.add(restaurant);
            }

            System.out.println("Total Restaurants = " + restaurants.size());

        } catch(Exception e) {
            e.printStackTrace();
        }

        return restaurants;
    }
    @Override
    public void updateRestaurant(Restaurant restaurant) {

        String query =
        "UPDATE restaurants SET restaurant_name=?, cuisine_type=?, address=?, rating=?, image=? WHERE restaurant_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, restaurant.getRestaurantName());
            ps.setString(2, restaurant.getCuisineType());
            ps.setString(3, restaurant.getAddress());
            ps.setDouble(4, restaurant.getRating());
            ps.setString(5, restaurant.getImage());
            
            ps.setInt(6, restaurant.getRestaurantId());

            ps.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    @Override
    public void deleteRestaurant(int restaurantId) {

        String query =
                "DELETE FROM restaurants WHERE restaurant_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, restaurantId);

            ps.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    }