package com.food_application.model;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {

    private Map<Integer, CartItem> items = new LinkedHashMap<>();


    // Add Item
    public void addItem(FoodItem food) {

        if(items.containsKey(food.getFoodId())) {

            CartItem item = items.get(food.getFoodId());

            item.setQuantity(item.getQuantity()+1);

        }
        else {

            items.put(food.getFoodId(),

                    new CartItem(food,1));

        }

    }


    // Remove Item
    public void removeItem(int foodId) {

        items.remove(foodId);

    }


    // Increase Quantity

    public void increaseQuantity(int foodId) {

        CartItem item = items.get(foodId);

        item.setQuantity(item.getQuantity()+1);

    }


    // Decrease Quantity

    public void decreaseQuantity(int foodId) {

        CartItem item = items.get(foodId);

        if(item.getQuantity()>1) {

            item.setQuantity(item.getQuantity()-1);

        }
        else {

            items.remove(foodId);

        }

    }


    // Total Amount

    public double getGrandTotal() {

        double total = 0;

        for(CartItem item : items.values()) {

            total += item.getTotalPrice();

        }

        return total;

    }


    // Get Cart Items

    public Collection<CartItem> getItems(){

        return items.values();

    }

}