package com.food_application.DAOApplication;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.food_application.DAO.FoodItemDAO;
import com.food_application.model.FoodItem;
import com.food_application.utility.DBConnection;

public class FoodItemDAOImpl implements FoodItemDAO {

    private Connection con;

    public FoodItemDAOImpl() {
        con = DBConnection.getConnection();
    }

    @Override
    public void addFoodItem(FoodItem food) {

        String query = "INSERT INTO food_items(restaurant_id,food_name,description,price,category,image,available) VALUES(?,?,?,?,?,?,?)";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, food.getRestaurantId());
            ps.setString(2, food.getFoodName());
            ps.setString(3, food.getDescription());
            ps.setDouble(4, food.getPrice());
            ps.setString(5, food.getCategory());
            ps.setString(6, food.getImage());
            ps.setBoolean(7, food.isAvailable());

            ps.executeUpdate();

            System.out.println("Food Item Added Successfully");

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public FoodItem getFoodItemById(int foodId) {

        FoodItem food = null;

        String query = "SELECT * FROM food_items WHERE food_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, foodId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                food = new FoodItem();

                food.setFoodId(rs.getInt("food_id"));
                food.setRestaurantId(rs.getInt("restaurant_id"));
                food.setFoodName(rs.getString("food_name"));
                food.setDescription(rs.getString("description"));
                food.setPrice(rs.getDouble("price"));
                food.setCategory(rs.getString("category"));
                food.setImage(rs.getString("image"));
                food.setAvailable(rs.getBoolean("available"));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return food;
    }
    @Override
    public int getFoodItemCount() {

        int count = 0;

        String query = "SELECT COUNT(*) FROM food_items";

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
    public List<FoodItem> getAllFoodItems() {

        List<FoodItem> foods = new ArrayList<>();

        String query = "SELECT * FROM food_items";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                FoodItem food = new FoodItem();

                food.setFoodId(rs.getInt("food_id"));
                food.setRestaurantId(rs.getInt("restaurant_id"));
                food.setFoodName(rs.getString("food_name"));
                food.setDescription(rs.getString("description"));
                food.setPrice(rs.getDouble("price"));
                food.setCategory(rs.getString("category"));
                food.setImage(rs.getString("image"));
                food.setAvailable(rs.getBoolean("available"));

                foods.add(food);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return foods;
    }

    @Override
    public List<FoodItem> getFoodItemsByRestaurantId(int restaurantId) {

        List<FoodItem> foods = new ArrayList<>();

        String query = "SELECT * FROM food_items WHERE restaurant_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, restaurantId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                FoodItem food = new FoodItem();

                food.setFoodId(rs.getInt("food_id"));
                food.setRestaurantId(rs.getInt("restaurant_id"));
                food.setFoodName(rs.getString("food_name"));
                food.setDescription(rs.getString("description"));
                food.setPrice(rs.getDouble("price"));
                food.setCategory(rs.getString("category"));
                food.setImage(rs.getString("image"));
                food.setAvailable(rs.getBoolean("available"));

                foods.add(food);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return foods;
    }

   
    @Override
    public void deleteFoodItem(int foodId) {

        String query = "DELETE FROM food_items WHERE food_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, foodId);

            ps.executeUpdate();

            System.out.println("Food Item Deleted Successfully");

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

	@Override
	
	    public void updateFoodItem(FoodItem food) {

	        String query = "UPDATE food_items SET restaurant_id=?, food_name=?, description=?, price=?, category=?, image=?, available=? WHERE food_id=?";

	        try {

	            PreparedStatement ps = con.prepareStatement(query);

	            ps.setInt(1, food.getRestaurantId());
	            ps.setString(2, food.getFoodName());
	            ps.setString(3, food.getDescription());
	            ps.setDouble(4, food.getPrice());
	            ps.setString(5, food.getCategory());
	            ps.setString(6, food.getImage());
	            ps.setBoolean(7, food.isAvailable());
	            ps.setInt(8, food.getFoodId());

	            ps.executeUpdate();

	            System.out.println("Food Item Updated Successfully");

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	    }


	@Override
	public List<FoodItem> getFoodByCategory(String category){

	    List<FoodItem> foods=new ArrayList<>();

	    String sql="SELECT * FROM food_items WHERE LOWER(category)=LOWER(?)";

	    try{

	        PreparedStatement ps=con.prepareStatement(sql);

	        ps.setString(1,category);

	        ResultSet rs=ps.executeQuery();

	        while(rs.next()){

	            FoodItem food=new FoodItem();

	            food.setFoodId(rs.getInt("food_id"));
	            food.setFoodName(rs.getString("food_name"));
	            food.setPrice(rs.getDouble("price"));
	            food.setCategory(rs.getString("category"));
	            food.setRestaurantId(rs.getInt("restaurant_id"));

	            foods.add(food);

	        }

	    }

	    catch(Exception e){

	        e.printStackTrace();

	    }

	    return foods;

	}
	@Override
	public List<FoodItem> getFoodUnderPrice(double price){

	    List<FoodItem> foods=new ArrayList<>();

	    String sql="SELECT * FROM food_items WHERE price<=?";

	    try{

	        PreparedStatement ps=con.prepareStatement(sql);

	        ps.setDouble(1,price);

	        ResultSet rs=ps.executeQuery();

	        while(rs.next()){

	            FoodItem food=new FoodItem();

	            food.setFoodId(rs.getInt("food_id"));
	            food.setFoodName(rs.getString("food_name"));
	            food.setPrice(rs.getDouble("price"));
	            food.setCategory(rs.getString("category"));
	            food.setRestaurantId(rs.getInt("restaurant_id"));

	            foods.add(food);

	        }

	    }

	    catch(Exception e){

	        e.printStackTrace();

	    }

	    return foods;

	}
	@Override
	public List<FoodItem> searchFood(String keyword){

	    List<FoodItem> foods=new ArrayList<>();

	    String sql="""
	    SELECT *
	    FROM food_items
	    WHERE LOWER(food_name) LIKE ?
	    OR LOWER(category) LIKE ?
	    """;

	    try{

	        PreparedStatement ps=con.prepareStatement(sql);

	        ps.setString(1,"%"+keyword.toLowerCase()+"%");
	        ps.setString(2,"%"+keyword.toLowerCase()+"%");

	        ResultSet rs=ps.executeQuery();

	        while(rs.next()){

	            FoodItem food=new FoodItem();

	            food.setFoodId(rs.getInt("food_id"));
	            food.setFoodName(rs.getString("food_name"));
	            food.setPrice(rs.getDouble("price"));
	            food.setCategory(rs.getString("category"));
	            food.setRestaurantId(rs.getInt("restaurant_id"));

	            foods.add(food);

	        }

	    }

	    catch(Exception e){

	        e.printStackTrace();

	    }

	    return foods;

	}
	
	@Override
	public List<FoodItem> getFoodByCategoryAndPrice(String category,double price){

	    List<FoodItem> foods=new ArrayList<>();

	    String sql="""
	    SELECT *
	    FROM food_items
	    WHERE LOWER(category)=LOWER(?)
	    AND price<=?
	    """;

	    try{

	        PreparedStatement ps=con.prepareStatement(sql);

	        ps.setString(1,category);
	        ps.setDouble(2,price);

	        ResultSet rs=ps.executeQuery();

	        while(rs.next()){

	            FoodItem food=new FoodItem();

	            food.setFoodId(rs.getInt("food_id"));
	            food.setFoodName(rs.getString("food_name"));
	            food.setPrice(rs.getDouble("price"));
	            food.setCategory(rs.getString("category"));
	            food.setRestaurantId(rs.getInt("restaurant_id"));

	            foods.add(food);

	        }

	    }

	    catch(Exception e){

	        e.printStackTrace();

	    }

	    return foods;

	}


	


}