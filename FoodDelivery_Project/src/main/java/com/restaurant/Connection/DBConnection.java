package com.restaurant.Connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/onlinefooddelivery";
    private static final String USER = "root";
    private static final String PASS = "kiran@123";

    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException e) {
            System.out.println("JDBC Driver not found! Make sure mysql-connector-j.jar is added to project.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Database connection failed. Check URL, username, or password.");
            e.printStackTrace();
        }
        return connection;
    }
}
