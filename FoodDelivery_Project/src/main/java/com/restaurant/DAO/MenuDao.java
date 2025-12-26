package com.restaurant.DAO;

import java.util.List;

import com.restaurant.model.Menu;
import com.restaurant.model.Restaurant;

public interface MenuDao {
    
    // Create
    void addMenu(Menu menu);

    // Read
    Menu getMenuById(int id);
    List<Menu> getAllMenus();
    List<Menu> getMenuByRestaurantId(int restaurantId);

    // Update
    void updateMenu(Menu menu);

    // Delete
    void deleteMenu(int id);
}