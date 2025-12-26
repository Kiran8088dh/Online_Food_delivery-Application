package com.restaurantDaoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.restaurant.Connection.DBConnection;
import com.restaurant.DAO.MenuDao;
import com.restaurant.model.Menu;

public class MenuDaoImpl implements MenuDao {

    private static final String INSERT_MENU =
        "INSERT INTO menu (Restaurant_id, Name, Description, Rating, Price, Image) " +
        "VALUES (?, ?, ?, ?, ?, ?)";

    private static final String SELECT_BY_ID =
        "SELECT * FROM menu WHERE Id = ?";

    private static final String GET_ALL_MENU =
        "SELECT * FROM menu";

    private static final String GET_MENU_BY_RESTAURANT_ID =
        "SELECT * FROM menu WHERE Restaurant_id = ?";

    private static final String UPDATE_MENU =
        "UPDATE menu SET Restaurant_id = ?, Name = ?, Description = ?, " +
        "Rating = ?, Price = ?, Image = ? WHERE Id = ?";

    private static final String DELETE_MENU =
        "DELETE FROM menu WHERE Id = ?";

    @Override
    public void addMenu(Menu menu) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(INSERT_MENU)) {

            statement.setInt(1, menu.getRestaurant_Id());
            statement.setString(2, menu.getName());
            statement.setString(3, menu.getDescription());   // your field name
            statement.setFloat(4, menu.getRating());
            statement.setFloat(5, menu.getPrice());
            statement.setString(6, menu.getImage());

            int res = statement.executeUpdate();
            System.out.println("Menu inserted, rows affected: " + res);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Menu getMenuById(int id) {
        Menu menu = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(SELECT_BY_ID)) {

            statement.setInt(1, id);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    menu = new Menu();
                    menu.setId(rs.getInt("Id"));
                    menu.setRestaurant_Id(rs.getInt("Restaurant_id"));
                    menu.setName(rs.getString("Name"));
                    menu.setDescription(rs.getString("Description")); // or "Discription" if DB uses that
                    menu.setRating(rs.getFloat("Rating"));
                    menu.setPrice(rs.getFloat("Price"));
                    menu.setImage(rs.getString("Image"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menu;
    }

    @Override
    public List<Menu> getAllMenus() {
        List<Menu> list = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(GET_ALL_MENU);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                Menu menu = new Menu();

                menu.setId(rs.getInt("Id"));
                menu.setRestaurant_Id(rs.getInt("Restaurant_id"));
                menu.setName(rs.getString("Name"));
                menu.setDescription(rs.getString("Description"));
                menu.setRating(rs.getFloat("Rating"));
                menu.setPrice(rs.getFloat("Price"));  // use float, not int
                menu.setImage(rs.getString("Image"));

                list.add(menu);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public List<Menu> getMenuByRestaurantId(int restaurantId) {
        List<Menu> list = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(GET_MENU_BY_RESTAURANT_ID)) {

            statement.setInt(1, restaurantId);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Menu menu = new Menu();
                menu.setId(rs.getInt("Id"));
                menu.setRestaurant_Id(rs.getInt("Restaurant_id"));
                menu.setName(rs.getString("Name"));
                menu.setDescription(rs.getString("Description"));
                menu.setRating(rs.getFloat("Rating"));
                menu.setPrice(rs.getFloat("Price"));
                menu.setImage(rs.getString("Image"));
                list.add(menu);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list; // ✅ Return the list instead of null
    }


    @Override
    public void updateMenu(Menu menu) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_MENU)) {

            statement.setInt(1, menu.getRestaurant_Id());
            statement.setString(2, menu.getName());
            statement.setString(3, menu.getDescription());
            statement.setFloat(4, menu.getRating());
            statement.setFloat(5, menu.getPrice());
            statement.setString(6, menu.getImage());
            statement.setInt(7, menu.getId());   // WHERE Id = ?

            int res = statement.executeUpdate();
            System.out.println("Menu updated, rows affected: " + res);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteMenu(int id) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_MENU)) {

            statement.setInt(1, id);

            int res = statement.executeUpdate();
            System.out.println("Menu deleted, rows affected: " + res);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
