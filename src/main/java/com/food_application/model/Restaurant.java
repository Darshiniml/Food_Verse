package com.food_application.model;

public class Restaurant {

    private int restaurantId;
    private String restaurantName;
    private String cuisineType;
    private String address;
    private double rating;
    private String image;
    private int userId;

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
    public Restaurant() {
    }

    public Restaurant(int restaurantId, String restaurantName,
            String cuisineType, String address,
            double rating, String image) {

        this.restaurantId = restaurantId;
        this.restaurantName = restaurantName;
        this.cuisineType = cuisineType;
        this.address = address;
        this.rating = rating;
        this.image = image;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public String getRestaurantName() {
        return restaurantName;
    }

    public void setRestaurantName(String restaurantName) {
        this.restaurantName = restaurantName;
    }

    public String getCuisineType() {
        return cuisineType;
    }

    public void setCuisineType(String cuisineType) {
        this.cuisineType = cuisineType;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

	
}