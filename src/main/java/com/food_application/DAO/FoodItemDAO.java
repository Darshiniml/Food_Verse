package com.food_application.DAO;

import java.util.List;

import com.food_application.model.FoodItem;

public interface FoodItemDAO {

    void addFoodItem(FoodItem food);

    FoodItem getFoodItemById(int foodId);

    List<FoodItem> getAllFoodItems();

    List<FoodItem> getFoodItemsByRestaurantId(int restaurantId);

    void updateFoodItem(FoodItem food);

    void deleteFoodItem(int foodId);
    int getFoodItemCount();
<<<<<<< HEAD
    List<FoodItem> getFoodByCategory(String category);

    List<FoodItem> getFoodUnderPrice(double price);

    List<FoodItem> searchFood(String keyword);

    List<FoodItem> getFoodByCategoryAndPrice(String category,double price);
=======

>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
}