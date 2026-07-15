package com.food_application.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.stream.Collectors;

import org.json.JSONArray;
import org.json.JSONObject;

import com.food_application.DAO.FoodItemDAO;
import com.food_application.DAO.OrderDAO;
import com.food_application.DAO.RestaurantDAO;
import com.food_application.DAOApplication.FoodItemDAOImpl;
import com.food_application.DAOApplication.OrderDAOImpl;
import com.food_application.DAOApplication.RestaurantDAOImpl;
import com.food_application.model.FoodItem;
import com.food_application.model.Order;
import com.food_application.model.Restaurant;
import com.food_application.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/chatbot")
public class ChatbotServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String message = request.getParameter("message");
        if (message == null) {
            message = "";
        }

        String normalized = message.trim().toLowerCase(Locale.ROOT);
        HttpSession session = request.getSession(false);
        User user = session == null ? null
                : (User) session.getAttribute("loggedUser");

        JSONObject payload = new JSONObject();
        payload.put("message", message);
        try {
            payload.put("reply", buildReply(normalized, user));
            payload.put("suggestions", buildSuggestions(normalized));
        } catch (Exception e) {
            payload.put("reply", "Sorry, I could not answer that right now.");
            payload.put("suggestions", defaultSuggestions());
        }

        try (PrintWriter out = response.getWriter()) {
            out.print(payload.toString());
        }
    }

    private String buildReply(String message, User user) {
        RestaurantDAO restaurantDAO = new RestaurantDAOImpl();
        FoodItemDAO foodItemDAO = new FoodItemDAOImpl();
        OrderDAO orderDAO = new OrderDAOImpl();
        String intent = normalizeText(message);

        if (message.isBlank()) {
            return "Sorry, I was unable to find that in the database. Try asking about a restaurant, food item, or your order.";
        }

        List<FoodItem> allFoods = foodItemDAO.getAllFoodItems();
        List<Restaurant> allRestaurants = restaurantDAO.getAllRestaurants();

        if (intent.equals("show best restaurants")
                || intent.equals("best restaurants")
                || intent.equals("show restaurants")
                || intent.equals("popular restaurants")
                || intent.equals("show best restaurant")) {
            List<Restaurant> topRestaurants = allRestaurants.stream()
                    .sorted((left, right) -> Double.compare(right.getRating(), left.getRating()))
                    .limit(3)
                    .collect(Collectors.toList());
            return formatRestaurantReply(topRestaurants);
        }

        if (intent.equals("recommend pizza")
                || intent.equals("available pizza")
                || intent.equals("pizza restaurants")
                || intent.equals("pizza")) {
            List<FoodItem> pizzaItems = filterFoodByKeyword(allFoods, "pizza");
            if (pizzaItems.isEmpty()) {
                pizzaItems = matchFoodItems(message, allFoods);
            }
            return formatFoodReply(pizzaItems);
        }

        if (intent.equals("best burger")
                || intent.equals("burger")
                || intent.equals("show burgers")) {
            List<FoodItem> burgerItems = filterFoodByKeyword(allFoods, "burger");
            if (burgerItems.isEmpty()) {
                burgerItems = matchFoodItems(message, allFoods);
            }
            return formatFoodReply(burgerItems);
        }

        if (intent.equals("my order status")
                || intent.equals("track my order")
                || intent.equals("order status")
                || intent.equals("track order")) {
            if (user == null) {
                return "Please log in first so I can look up your orders.";
            }
            List<Order> orders = orderDAO.getOrdersByUserId(user.getUserId());
            return formatOrderReply(orders);
        }

        List<FoodItem> matchedFoods = matchFoodItems(message, allFoods);
        if (!matchedFoods.isEmpty()) {
            return formatFoodReply(matchedFoods);
        }

        List<Restaurant> matchedRestaurants = matchRestaurants(message, allRestaurants, allFoods);
        if (!matchedRestaurants.isEmpty()) {
            return formatRestaurantReply(matchedRestaurants);
        }

        if (containsAny(message, "order", "track", "status", "my order")) {
            if (user == null) {
                return "Please log in first so I can look up your orders.";
            }
            List<Order> orders = orderDAO.getOrdersByUserId(user.getUserId());
            return formatOrderReply(orders);
        }

        if (containsAny(message, "payment", "razorpay", "upi", "card", "cash", "cod")) {
            return "Payments are available through Razorpay, UPI, cards, and cash on delivery depending on the checkout option.";
        }

        if (containsAny(message, "delivery", "time", "fast")) {
            return "Most orders are delivered in about 25 to 30 minutes, depending on restaurant load and location.";
        }

        return "Sorry, I was unable to find that in the database. Try asking about a restaurant, food item, or your order.";
    }

    private String formatRestaurantReply(List<Restaurant> restaurants) {
        if (restaurants == null || restaurants.isEmpty()) {
            return "Sorry, I could not find that restaurant in the database.";
        }

        List<String> names = new ArrayList<>();
        for (Restaurant restaurant : restaurants) {
            if (restaurant.getRestaurantName() != null) {
                names.add(restaurant.getRestaurantName());
            }
        }

        int count = names.size();
        String preview = String.join(", ", names.subList(0, Math.min(3, names.size())));
        return "I found " + count + " matching restaurants in the database. Try: " + preview + ".";
    }

    private String formatFoodReply(List<FoodItem> foods) {
        if (foods == null || foods.isEmpty()) {
            return "Sorry, I could not find that food item in the database.";
        }

        List<String> names = new ArrayList<>();
        for (FoodItem food : foods) {
            if (food.getFoodName() != null) {
                names.add(food.getFoodName());
            }
        }

        int count = names.size();
        String preview = String.join(", ", names.subList(0, Math.min(3, names.size())));
        return "I found " + count + " matching food items in the database. Try: " + preview + ".";
    }

    private String formatOrderReply(List<Order> orders) {
        if (orders == null || orders.isEmpty()) {
            return "You do not have any orders yet.";
        }

        Order latest = orders.get(0);
        return "You have " + orders.size() + " orders. Latest order #" + latest.getOrderId()
                + " is " + safe(latest.getStatus()) + " and totals ₹"
                + String.format(Locale.ROOT, "%.2f", latest.getTotalAmount()) + ".";
    }

    private boolean containsAny(String message, String... terms) {
        for (String term : terms) {
            if (message.contains(term)) {
                return true;
            }
        }
        return false;
    }

    private List<FoodItem> matchFoodItems(String message, List<FoodItem> foods) {
        List<String> tokens = tokenize(message);
        Set<FoodItem> matches = new LinkedHashSet<>();

        for (FoodItem food : foods) {
            String haystack = normalizeText(
                    safe(food.getFoodName()) + " " +
                    safe(food.getCategory()) + " " +
                    safe(food.getDescription()));

            for (String token : tokens) {
                if (token.length() < 3) {
                    continue;
                }
                if (haystack.contains(token)) {
                    matches.add(food);
                    break;
                }
            }
        }

        if (matches.isEmpty()) {
            if (containsAny(message, "pizza")) {
                matches.addAll(filterFoodByKeyword(foods, "pizza"));
            } else if (containsAny(message, "burger")) {
                matches.addAll(filterFoodByKeyword(foods, "burger"));
            } else if (containsAny(message, "biryani")) {
                matches.addAll(filterFoodByKeyword(foods, "biryani"));
            } else if (containsAny(message, "dosa", "idli")) {
                matches.addAll(filterFoodByKeyword(foods, "dosa", "idli"));
            }
        }

        return new ArrayList<>(matches);
    }

    private List<Restaurant> matchRestaurants(String message,
            List<Restaurant> restaurants,
            List<FoodItem> foods) {

        List<String> tokens = tokenize(message);
        Set<Restaurant> matches = new LinkedHashSet<>();

        for (Restaurant restaurant : restaurants) {
            String haystack = normalizeText(
                    safe(restaurant.getRestaurantName()) + " " +
                    safe(restaurant.getCuisineType()) + " " +
                    safe(restaurant.getAddress()));

            for (String token : tokens) {
                if (token.length() < 3) {
                    continue;
                }
                if (haystack.contains(token)) {
                    matches.add(restaurant);
                    break;
                }
            }
        }

        if (matches.isEmpty()) {
            if (containsAny(message, "restaurant", "restaurants", "best", "popular", "show")) {
                matches.addAll(restaurants.subList(0, Math.min(3, restaurants.size())));
            } else {
                List<FoodItem> foodMatches = matchFoodItems(message, foods);
                Set<Integer> restaurantIds = foodMatches.stream()
                        .map(FoodItem::getRestaurantId)
                        .collect(Collectors.toSet());
                for (Restaurant restaurant : restaurants) {
                    if (restaurantIds.contains(restaurant.getRestaurantId())) {
                        matches.add(restaurant);
                    }
                }
            }
        }

        return new ArrayList<>(matches);
    }

    private List<FoodItem> filterFoodByKeyword(List<FoodItem> foods, String... keywords) {
        List<FoodItem> matches = new ArrayList<>();
        for (FoodItem food : foods) {
            String haystack = normalizeText(
                    safe(food.getFoodName()) + " " +
                    safe(food.getCategory()) + " " +
                    safe(food.getDescription()));
            for (String keyword : keywords) {
                if (haystack.contains(normalizeText(keyword))) {
                    matches.add(food);
                    break;
                }
            }
        }
        return matches;
    }

    private List<String> tokenize(String message) {
        String cleaned = normalizeText(message);
        return Arrays.stream(cleaned.split("\\s+"))
                .filter(token -> !token.isBlank())
                .collect(Collectors.toList());
    }

    private String normalizeText(String text) {
        String normalized = Normalizer.normalize(safe(text), Normalizer.Form.NFD)
                .replaceAll("\\p{M}+", "")
                .toLowerCase(Locale.ROOT);
        return normalized.replaceAll("[^a-z0-9\\s]", " ").replaceAll("\\s+", " ").trim();
    }

    private JSONArray buildSuggestions(String message) {
        JSONArray suggestions = new JSONArray();

        if (containsAny(message, "pizza", "burger", "biryani", "dosa", "food", "menu")) {
            suggestions.put("Show best restaurants");
            suggestions.put("Show available food");
            suggestions.put("Track my order");
            return suggestions;
        }

        if (containsAny(message, "order", "track", "status")) {
            suggestions.put("Track my order");
            suggestions.put("Payment help");
            suggestions.put("Show best restaurants");
            return suggestions;
        }

        if (containsAny(message, "restaurant", "best", "popular")) {
            suggestions.put("Recommend pizza");
            suggestions.put("Best burger");
            suggestions.put("Show restaurants");
            return suggestions;
        }

        return defaultSuggestions();
    }

    private JSONArray defaultSuggestions() {
        JSONArray suggestions = new JSONArray();
        suggestions.put("Show best restaurants");
        suggestions.put("Recommend pizza");
        suggestions.put("My order status");
        suggestions.put("Payment help");
        return suggestions;
    }

    private String safe(String value) {
        return value == null || value.isBlank() ? "unknown" : value;
    }
}
