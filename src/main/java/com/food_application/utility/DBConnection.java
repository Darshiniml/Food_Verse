package com.food_application.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnection {

    private static final Logger LOGGER =
            Logger.getLogger(DBConnection.class.getName());

    private static final String URL =
            System.getProperty("foodverse.db.url",
                    System.getenv().getOrDefault(
                            "FOODVERSE_DB_URL",
                            "jdbc:mysql://localhost:3306/food_app"));

    private static final String USERNAME =
            System.getProperty("foodverse.db.username",
                    System.getenv().getOrDefault(
                            "FOODVERSE_DB_USERNAME",
                            "root"));
    private static final String PASSWORD =
            System.getProperty("foodverse.db.password",
                    System.getenv().getOrDefault(
                            "FOODVERSE_DB_PASSWORD",
                            ""));
    private static final ThreadLocal<Connection> BOUND_CONNECTION =
            new ThreadLocal<>();

    public static Connection getConnection() {

        try {
            Connection connection = BOUND_CONNECTION.get();
            if (connection != null && !connection.isClosed()) {
                return connection;
            }
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unable to create database connection", e);
            return null;
        }
    }

    public static void bindConnection(Connection connection) {
        BOUND_CONNECTION.set(connection);
    }

    public static void clearBoundConnection() {
        BOUND_CONNECTION.remove();
    }

    public static void closeQuietly(Connection connection) {
        if (connection == null) {
            return;
        }
        try {
            if (!connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Failed to close database connection", e);
        }
    }

}
