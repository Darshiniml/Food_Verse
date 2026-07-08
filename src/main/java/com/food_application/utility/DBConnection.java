package com.food_application.utility;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static Connection con;

    private static final String URL =
            "jdbc:mysql://localhost:3306/food_app";

    private static final String USERNAME = "root";

    private static final String PASSWORD = "Darsh123";

    public static Connection getConnection() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(URL, USERNAME, PASSWORD);

            

        } catch (Exception e) {

            e.printStackTrace();

        }

        return con;

    }

}