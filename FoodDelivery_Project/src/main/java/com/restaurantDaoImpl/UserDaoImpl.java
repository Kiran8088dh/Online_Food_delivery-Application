package com.restaurantDaoImpl;

import com.restaurant.Connection.DBConnection;
import com.restaurant.DAO.UserDAO;
import com.restaurant.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDaoImpl implements UserDAO {

    @Override
    public boolean createUser(String name, String phone, String email, String address, String password)
            throws SQLException {

        String sql = "INSERT INTO users (name, phone, email, address, password) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, email);
            ps.setString(4, address);
            ps.setString(5, password); // plain password (later you can hash)

            return ps.executeUpdate() == 1;
        }
    }

    @Override
    public User findByEmail(String email) throws SQLException {

        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setId(rs.getLong("id"));
                    u.setName(rs.getString("name"));
                    u.setPhone(rs.getString("phone"));
                    u.setEmail(rs.getString("email"));
                    u.setAddress(rs.getString("address"));
                    u.setPassword(rs.getString("password"));
                    return u;
                }
            }
        }
        return null;
    }
}
