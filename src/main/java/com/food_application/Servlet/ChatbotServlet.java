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

        if (containsPhrase(intent, "show best restaurants", "best restaurants", "popular restaurants", "top restaurants")) {
            return replyWithRestaurants("SELECT restaurant_name, cuisine_type, rating FROM restaurants ORDER BY rating DESC, restaurant_id ASC LIMIT 3");
        }

        if (containsWord(intent, "pizza")) {
            return replyWithFood("SELECT food_name, price, category FROM food_items WHERE LOWER(food_name) LIKE ? OR LOWER(category) LIKE ? OR LOWER(description) LIKE ? LIMIT 5",
                    "%pizza%", "%pizza%", "%pizza%");
        }

        if (containsWord(intent, "burger")) {
            return replyWithFood("SELECT food_name, price, category FROM food_items WHERE LOWER(food_name) LIKE ? OR LOWER(category) LIKE ? OR LOWER(description) LIKE ? LIMIT 5",
                    "%burger%", "%burger%", "%burger%");
        }

        if (containsPhrase(intent, "my order status", "track my order", "order status", "track order", "my orders")) {
            if (user == null) {
                return "Please log in first so I can look up your orders.";
            }
            return replyWithOrders(user.getUserId());
        }

        if (containsPhrase(intent, "payment help", "payment", "razorpay", "card", "cash", "cod") || containsWord(intent, "upi")) {
            return "💳 Payment options available:\n"
                    + "• Razorpay\n"
                    + "• UPI\n"
                    + "• Cards\n"
                    + "• Cash on delivery\n"
                    + "You’ll see the available options during checkout.";
        }

        if (containsPhrase(intent, "delivery help", "delivery", "time", "fast")) {
            return "🚚 Typical delivery time is around 25–30 minutes, depending on your location and restaurant load.";
        }

        if (containsPhrase(intent, "where is", "where are", "located", "location of", "address of", "find")) {
            String place = extractAfterTrigger(intent, "where is", "where are", "located", "location of", "address of", "find");
            if (!place.isBlank()) {
                String locationReply = replyWithRestaurantLocation(place);
                if (!FALLBACK_REPLY.equals(locationReply)) {
                    return locationReply;
                }
            }
        }

        if (containsPhrase(intent, "tell me about order number", "order number", "order no", "order #", "order id")) {
            String orderIdText = extractOrderId(intent);
            if (!orderIdText.isBlank()) {
                String orderReply = replyWithOrderById(user, orderIdText);
                if (!FALLBACK_REPLY.equals(orderReply)) {
                    return orderReply;
                }
            }
        }

        if (containsPhrase(intent, "what is rate of", "what is the rate of", "rate of", "price of", "cost of", "how much is", "how much for")) {
            String target = extractAfterTrigger(intent,
                    "what is rate of",
                    "what is the rate of",
                    "rate of",
                    "price of",
                    "cost of",
                    "how much is",
                    "how much for");
            target = normalizeFoodQuery(target);
            if (!target.isBlank()) {
                String priceReply = replyWithFood("SELECT food_name, price, category FROM food_items WHERE LOWER(food_name) LIKE ? OR LOWER(category) LIKE ? OR LOWER(description) LIKE ? LIMIT 5",
                        "%" + target + "%", "%" + target + "%", "%" + target + "%");
                if (!FALLBACK_REPLY.equals(priceReply)) {
                    return priceReply;
                }
            }

            String priceReply = replyWithFood("SELECT food_name, price, category FROM food_items WHERE LOWER(food_name) LIKE ? OR LOWER(category) LIKE ? OR LOWER(description) LIKE ? LIMIT 5",
                    "%" + normalizeFoodQuery(intent) + "%", "%" + normalizeFoodQuery(intent) + "%", "%" + normalizeFoodQuery(intent) + "%");
            if (!FALLBACK_REPLY.equals(priceReply)) {
                return priceReply;
            }
        }

        try {
            String restaurantItemsReply = replyWithRestaurantItems(intent);
            if (!FALLBACK_REPLY.equals(restaurantItemsReply)) {
                return restaurantItemsReply;
            }

            String restaurantLocationReply = replyWithRestaurantLocation(intent);
            if (!FALLBACK_REPLY.equals(restaurantLocationReply)) {
                return restaurantLocationReply;
            }

            String foodReply = replyWithFood("SELECT food_name, price, category FROM food_items WHERE LOWER(food_name) LIKE ? OR LOWER(category) LIKE ? OR LOWER(description) LIKE ? LIMIT 5",
                    "%" + normalizeFoodQuery(intent) + "%", "%" + normalizeFoodQuery(intent) + "%", "%" + normalizeFoodQuery(intent) + "%");
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
                .replace("what are item in", "")
                .replace("what are there in", "")
                .replace("what is there in", "")
                .replace("what are items of", "")
                .replace("items in", "")
                .replace("item in", "")
                .replace("items of", "")
                .replace("menu of", "")
                .replace("menu for", "")
                .replace("what is in", "")
                .replace("show items in", "")
                .replace("show menu of", "")
                .replace("what are available in", "")
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
        String sql = "SELECT o.order_id, o.status, o.total_amount, o.order_date, r.restaurant_name "
                + "FROM orders o LEFT JOIN restaurants r ON o.restaurant_id = r.restaurant_id "
                + "WHERE o.user_id=? ORDER BY o.order_date DESC LIMIT 5";
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
                String restaurantName = safe(rs.getString("restaurant_name"));
                String orderDate = rs.getTimestamp("order_date") == null
                        ? ""
                        : rs.getTimestamp("order_date").toLocalDateTime().toString().replace('T', ' ');
                while (rs.next()) {
                    orderCount++;
                }
                StringBuilder reply = new StringBuilder();
                reply.append("📦 You have ").append(orderCount).append(" orders in the database.\n");
                reply.append("Latest order #").append(latestOrderId).append("\n");
                if (!restaurantName.isBlank()) {
                    reply.append("• Restaurant: ").append(restaurantName).append("\n");
                }
                if (!orderDate.isBlank()) {
                    reply.append("• Placed on: ").append(orderDate).append("\n");
                }
                reply.append("• Status: ").append(safe(latestStatus)).append("\n");
                reply.append("• Total: ₹").append(String.format(Locale.ROOT, "%.2f", latestAmount));
                return reply.toString();
            }
        } catch (Exception e) {
            System.out.println("FoodVerse chatbot order query error: " + e.getMessage());
            return FALLBACK_REPLY;
        }
    }

    private JSONArray getSuggestions(String message) {
        String intent = normalize(message);
        List<String> suggestions;
        if (containsWord(intent, "pizza")) {
            suggestions = Arrays.asList("Show best restaurants", "What are items in Meghana", "Payment help");
        } else if (containsWord(intent, "order")) {
            suggestions = Arrays.asList("My order status", "Payment help", "Show best restaurants");
        } else {
            suggestions = Arrays.asList("Show best restaurants", "Recommend pizza", "What is rate of biryani");
        }
        return new JSONArray(suggestions);
    }

    private boolean containsPhrase(String intent, String... options) {
        for (String option : options) {
            if (intent.contains(option)) {
                return true;
            }
        }
        return false;
    }

    private boolean containsWord(String intent, String word) {
        return (" " + intent + " ").contains(" " + word + " ");
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

    private String normalizeFoodQuery(String text) {
        String normalized = normalizeLoose(text);
        normalized = normalized.replace("panner", "paneer");
        normalized = normalized.replace("mushrom", "mushroom");
        return normalized;
    }

    private String extractOrderId(String intent) {
        String digits = intent.replaceAll(".*?(\\d+).*", "$1");
        if (digits.equals(intent) || digits.isBlank()) {
            return "";
        }
        return digits;
    }

    private String replyWithRestaurantLocation(String place) {
        String normalizedPlace = normalizeLoose(place);
        if (normalizedPlace.isBlank()) {
            return FALLBACK_REPLY;
        }
        String sql = "SELECT restaurant_name, address FROM restaurants WHERE LOWER(restaurant_name) LIKE ? OR LOWER(cuisine_type) LIKE ? OR LOWER(address) LIKE ? ORDER BY rating DESC LIMIT 5";
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            String like = "%" + normalizedPlace + "%";
            statement.setString(1, like);
            statement.setString(2, like);
            statement.setString(3, like);

            try (ResultSet rs = statement.executeQuery()) {
                List<String> places = new ArrayList<>();
                while (rs.next()) {
                    String restaurantName = rs.getString("restaurant_name");
                    String address = rs.getString("address");
                    if (restaurantName != null && address != null) {
                        places.add("📍 " + restaurantName + "\n   " + address);
                    }
                }
                if (places.isEmpty()) {
                    return FALLBACK_REPLY;
                }
                return "Here you go:\n" + String.join("\n\n", places);
            }
        } catch (Exception e) {
            System.out.println("FoodVerse chatbot location query error: " + e.getMessage());
            return FALLBACK_REPLY;
        }
    }

    private String replyWithOrderById(User user, String orderIdText) {
        if (user == null) {
            return "Please log in first so I can look up your order.";
        }

        try {
            int orderId = Integer.parseInt(orderIdText);
            String sql = "SELECT o.order_id, o.status, o.total_amount, o.order_date, o.delivery_address, r.restaurant_name "
                    + "FROM orders o LEFT JOIN restaurants r ON o.restaurant_id = r.restaurant_id "
                    + "WHERE o.order_id=? AND o.user_id=?";
            try (Connection connection = DBConnection.getConnection();
                    PreparedStatement statement = connection.prepareStatement(sql)) {

                statement.setInt(1, orderId);
                statement.setInt(2, user.getUserId());

                try (ResultSet rs = statement.executeQuery()) {
                    if (!rs.next()) {
                        return FALLBACK_REPLY;
                    }

                    String status = rs.getString("status");
                    double totalAmount = rs.getDouble("total_amount");
                    String restaurantName = safe(rs.getString("restaurant_name"));
                    String deliveryAddress = safe(rs.getString("delivery_address"));
                    String orderDate = rs.getTimestamp("order_date") == null
                            ? ""
                            : rs.getTimestamp("order_date").toLocalDateTime().toString().replace('T', ' ');

                    StringBuilder reply = new StringBuilder();
                    reply.append("🧾 Order #").append(orderId).append(" details:\n");
                    if (!restaurantName.isBlank()) {
                        reply.append("• Restaurant: ").append(restaurantName).append("\n");
                    }
                    if (!orderDate.isBlank()) {
                        reply.append("• Placed on: ").append(orderDate).append("\n");
                    }
                    if (!deliveryAddress.isBlank()) {
                        reply.append("• Delivery address: ").append(deliveryAddress).append("\n");
                    }
                    reply.append("• Status: ").append(safe(status)).append("\n");
                    reply.append("• Total: ₹").append(String.format(Locale.ROOT, "%.2f", totalAmount));
                    return reply.toString();
                }
            }
        } catch (Exception e) {
            System.out.println("FoodVerse chatbot order-by-id query error: " + e.getMessage());
            return FALLBACK_REPLY;
        }
    }

    private String safe(String value) {
        return value == null ? "" : value;
    }
}
