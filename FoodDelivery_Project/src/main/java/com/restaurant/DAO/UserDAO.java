package com.restaurant.DAO;


import java.sql.SQLException;

import com.restaurant.model.User;

public interface UserDAO {
    boolean createUser(String name, String phone, String email, String address, String passwordHash) throws SQLException;
    User findByEmail(String email) throws SQLException;
}
