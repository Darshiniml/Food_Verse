package com.food_application.DAO;

import java.util.List;
import com.food_application.model.Restaurant;

public interface RestaurantDAO {

    void addRestaurant(Restaurant restaurant);

    Restaurant getRestaurantById(int restaurantId);

    List<Restaurant> getAllRestaurants();

    void updateRestaurant(Restaurant restaurant);

    void deleteRestaurant(int restaurantId);
    int getRestaurantCount();
    Restaurant getRestaurantByUserId(int userId);
}