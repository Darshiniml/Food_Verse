package com.food_application.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import org.json.JSONArray;
import org.json.JSONObject;

import com.food_application.model.User;
import com.food_application.utility.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/chatbot")
public class ChatbotServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String FALLBACK_REPLY =
            "Sorry, I was unable to find that in the database. Try asking about a restaurant, food item, or your order.";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String message = request.getParameter("message");
        if (message == null) {
            message = "";
        }

        HttpSession session = request.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("loggedUser");

        JSONObject payload = new JSONObject();
        payload.put("message", message);
        payload.put("reply", getReply(message, user));
        payload.put("suggestions", getSuggestions(message));

        try (PrintWriter out = response.getWriter()) {
            out.print(payload.toString());
        }
    }

    private String getReply(String message, User user) {
        String intent = normalize(message);
        System.out.println("FoodVerse chatbot intent = [" + intent + "]");

        if (intent.isBlank()) {
            return FALLBACK_REPLY;
        }

        if (contains(intent, "show best restaurants", "best restaurants", "popular restaurants", "top restaurants")) {
            return replyWithRestaurants("SELECT restaurant_name, cuisine_type, rating FROM restaurants ORDER BY rating DESC, restaurant_id ASC LIMIT 3");
        }

        if (contains(intent, "recommend pizza", "available pizza", "pizza restaurants", "show pizza") || intent.equals("pizza")) {
            return replyWithFood("SELECT food_name, price, category FROM food_items WHERE LOWER(food_name) LIKE ? OR LOWER(category) LIKE ? OR LOWER(description) LIKE ? LIMIT 5",
                    "%pizza%", "%pizza%", "%pizza%");
        }

        if (contains(intent, "recommend burger", "available burger", "burger restaurants") || intent.equals("burger")) {
            return replyWithFood("SELECT food_name, price, category FROM food_items WHERE LOWER(food_name) LIKE ? OR LOWER(category) LIKE ? OR LOWER(description) LIKE ? LIMIT 5",
                    "%burger%", "%burger%", "%burger%");
        }

        if (contains(intent, "my order status", "track my order", "order status", "track order", "my orders")) {
            if (user == null) {
                return "Please log in first so I can look up your orders.";
            }
            return replyWithOrders(user.getUserId());
        }

        if (contains(intent, "payment help", "payment", "razorpay", "upi", "card", "cash", "cod")) {
            return "💳 Payment options available:\n"
                    + "• Razorpay\n"
                    + "• UPI\n"
                    + "• Cards\n"
                    + "• Cash on delivery\n"
                    + "You’ll see the available options during checkout.";
        }

        if (contains(intent, "delivery help", "delivery", "time", "fast")) {
            return "🚚 Typical delivery time is around 25–30 minutes, depending on your location and restaurant load.";
        }

        if (contains(intent, "what is rate of", "what is the rate of", "rate of", "price of", "cost of", "how much is", "how much for")) {
            String target = extractAfterTrigger(intent,
                    "what is rate of",
                    "what is the rate of",
                    "rate of",
                    "price of",
                    "cost of",
                    "how much is",
                    "how much for");
            if (!target.isBlank()) {
                String priceReply = replyWithFood("SELECT food_name, price, category FROM food_items WHERE LOWER(food_name) LIKE ? OR LOWER(category) LIKE ? OR LOWER(description) LIKE ? LIMIT 5",
                        "%" + target + "%", "%" + target + "%", "%" + target + "%");
                if (!FALLBACK_REPLY.equals(priceReply)) {
                    return priceReply;
                }
            }

            String priceReply = replyWithFood("SELECT food_name, price, category FROM food_items WHERE LOWER(food_name) LIKE ? OR LOWER(category) LIKE ? OR LOWER(description) LIKE ? LIMIT 5",
                    "%" + intent + "%", "%" + intent + "%", "%" + intent + "%");
            if (!FALLBACK_REPLY.equals(priceReply)) {
                return priceReply;
            }
        }

        try {
            String restaurantItemsReply = replyWithRestaurantItems(intent);
            if (!FALLBACK_REPLY.equals(restaurantItemsReply)) {
                return restaurantItemsReply;
            }

            String foodReply = replyWithFood("SELECT food_name, price, category FROM food_items WHERE LOWER(food_name) LIKE ? OR LOWER(category) LIKE ? OR LOWER(description) LIKE ? LIMIT 5",
                    "%" + intent + "%", "%" + intent + "%", "%" + intent + "%");
            if (!FALLBACK_REPLY.equals(foodReply)) {
                return foodReply;
            }

            String restaurantReply = replyWithRestaurants(
                    "SELECT restaurant_name, cuisine_type, rating FROM restaurants WHERE LOWER(restaurant_name) LIKE ? OR LOWER(cuisine_type) LIKE ? OR LOWER(address) LIKE ? LIMIT 5",
                    "%" + intent + "%", "%" + intent + "%", "%" + intent + "%");
            if (!FALLBACK_REPLY.equals(restaurantReply)) {
                return restaurantReply;
            }
        } catch (Exception e) {
            System.out.println("FoodVerse chatbot database lookup error: " + e.getMessage());
        }

        return FALLBACK_REPLY;
    }

    private String replyWithRestaurantItems(String intent) {
        String cleaned = intent.replace("what are items in", "")
                .replace("what are there in", "")
                .replace("what is there in", "")
                .replace("items in", "")
                .replace("items of", "")
                .replace("menu of", "")
                .replace("menu for", "")
                .replace("what is in", "")
                .replace("show items in", "")
                .replace("show menu of", "")
                .trim();

        if (cleaned.isBlank()) {
            return FALLBACK_REPLY;
        }

        String query = normalizeLoose(cleaned);
        String restaurantLike = "%" + query + "%";
        String restaurantLikeNoS = "%" + trimTrailingS(query) + "%";

        String restaurantSql = "SELECT restaurant_id, restaurant_name, cuisine_type FROM restaurants " +
                "WHERE LOWER(restaurant_name) LIKE ? OR LOWER(restaurant_name) LIKE ? " +
                "OR LOWER(cuisine_type) LIKE ? OR LOWER(address) LIKE ? " +
                "ORDER BY rating DESC, restaurant_id ASC LIMIT 5";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement restaurantStatement = connection.prepareStatement(restaurantSql)) {

            restaurantStatement.setString(1, restaurantLike);
            restaurantStatement.setString(2, restaurantLikeNoS);
            restaurantStatement.setString(3, restaurantLike);
            restaurantStatement.setString(4, restaurantLike);

            try (ResultSet restaurantRs = restaurantStatement.executeQuery()) {
                List<String> responses = new ArrayList<>();
                while (restaurantRs.next()) {
                    int restaurantId = restaurantRs.getInt("restaurant_id");
                    String restaurantName = restaurantRs.getString("restaurant_name");
                    List<String> items = fetchFoodItemsByRestaurantId(connection, restaurantId);
                    if (!items.isEmpty()) {
                        responses.add("🍽 " + restaurantName + "\n• " + String.join("\n• ", items.subList(0, Math.min(5, items.size()))));
                    }
                }

                if (responses.isEmpty()) {
                    return FALLBACK_REPLY;
                }

                return String.join("\n\n", responses);
            }
        } catch (Exception e) {
            System.out.println("FoodVerse chatbot restaurant-items query error: " + e.getMessage());
            return FALLBACK_REPLY;
        }
    }

    private List<String> fetchFoodItemsByRestaurantId(Connection connection, int restaurantId) throws Exception {
        String sql = "SELECT food_name, price FROM food_items WHERE restaurant_id=? ORDER BY food_id ASC";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, restaurantId);
            try (ResultSet rs = statement.executeQuery()) {
                List<String> items = new ArrayList<>();
                while (rs.next()) {
                    String foodName = rs.getString("food_name");
                    double price = rs.getDouble("price");
                    if (foodName != null && !foodName.isBlank()) {
                        items.add(foodName + " (₹" + String.format(Locale.ROOT, "%.2f", price) + ")");
                    }
                }
                return items;
            }
        }
    }

    private String replyWithRestaurants(String sql, String... params) {
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            for (int i = 0; i < params.length; i++) {
                statement.setString(i + 1, params[i]);
            }

            try (ResultSet rs = statement.executeQuery()) {
                List<String> names = new ArrayList<>();
                while (rs.next()) {
                    String name = rs.getString("restaurant_name");
                    double rating = rs.getDouble("rating");
                    if (name != null && !name.isBlank()) {
                        names.add(name + " (" + String.format(Locale.ROOT, "%.1f", rating) + "★)");
                    }
                }
                if (names.isEmpty()) {
                    return FALLBACK_REPLY;
                }
                return "🏆 Top restaurant picks from the database:\n• "
                        + String.join("\n• ", names.subList(0, Math.min(3, names.size())));
            }
        } catch (Exception e) {
            System.out.println("FoodVerse chatbot restaurant query error: " + e.getMessage());
            return FALLBACK_REPLY;
        }
    }

    private String replyWithFood(String sql, String... params) {
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            for (int i = 0; i < params.length; i++) {
                statement.setString(i + 1, params[i]);
            }

            try (ResultSet rs = statement.executeQuery()) {
                List<String> names = new ArrayList<>();
                while (rs.next()) {
                    String name = rs.getString("food_name");
                    double price = rs.getDouble("price");
                    if (name != null && !name.isBlank()) {
                        names.add(name + " (₹" + String.format(Locale.ROOT, "%.2f", price) + ")");
                    }
                }
                if (names.isEmpty()) {
                    return FALLBACK_REPLY;
                }
                return "🍕 Matching food items from the database:\n• "
                        + String.join("\n• ", names.subList(0, Math.min(3, names.size())));
            }
        } catch (Exception e) {
            System.out.println("FoodVerse chatbot food query error: " + e.getMessage());
            return FALLBACK_REPLY;
        }
    }

    private String replyWithOrders(int userId) {
        String sql = "SELECT order_id, status, total_amount FROM orders WHERE user_id=? ORDER BY order_date DESC LIMIT 5";
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);
            try (ResultSet rs = statement.executeQuery()) {
                if (!rs.next()) {
                    return "You do not have any orders yet.";
                }
                int orderCount = 1;
                int latestOrderId = rs.getInt("order_id");
                String latestStatus = rs.getString("status");
                double latestAmount = rs.getDouble("total_amount");
                while (rs.next()) {
                    orderCount++;
                }
                return "You have " + orderCount + " orders. Latest order #" + latestOrderId
                        + " is " + safe(latestStatus) + " and totals ₹"
                        + String.format(Locale.ROOT, "%.2f", latestAmount) + ".";
            }
        } catch (Exception e) {
            System.out.println("FoodVerse chatbot order query error: " + e.getMessage());
            return FALLBACK_REPLY;
        }
    }

    private JSONArray getSuggestions(String message) {
        String intent = normalize(message);
        List<String> suggestions;
        if (intent.contains("pizza")) {
            suggestions = Arrays.asList("Show best restaurants", "What are items in Meghana", "Payment help");
        } else if (intent.contains("order")) {
            suggestions = Arrays.asList("My order status", "Payment help", "Show best restaurants");
        } else {
            suggestions = Arrays.asList("Show best restaurants", "Recommend pizza", "What is rate of biryani");
        }
        return new JSONArray(suggestions);
    }

    private boolean contains(String intent, String... options) {
        for (String option : options) {
            if (intent.contains(option)) {
                return true;
            }
        }
        return false;
    }

    private String normalize(String text) {
        if (text == null) {
            return "";
        }
        String normalized = Normalizer.normalize(text, Normalizer.Form.NFD)
                .replaceAll("\\p{M}", "")
                .toLowerCase(Locale.ROOT);
        return normalized.replaceAll("[^a-z0-9\\s]", " ").replaceAll("\\s+", " ").trim();
    }

    private String extractAfterTrigger(String intent, String... triggers) {
        for (String trigger : triggers) {
            if (intent.contains(trigger)) {
                String extracted = intent.substring(intent.indexOf(trigger) + trigger.length()).trim();
                return extracted;
            }
        }
        return "";
    }

    private String normalizeLoose(String text) {
        String normalized = normalize(text);
        normalized = normalized.replace("foods", "food").replace("restaurants", "restaurant");
        normalized = normalized.replaceAll("\\bthe\\b", " ").replaceAll("\\bplease\\b", " ");
        normalized = normalized.replaceAll("\\s+", " ").trim();
        return normalized;
    }

    private String trimTrailingS(String text) {
        if (text == null || text.length() < 2) {
            return text == null ? "" : text;
        }
        return text.endsWith("s") ? text.substring(0, text.length() - 1) : text;
    }

    private String safe(String value) {
        return value == null ? "" : value;
    }
}
