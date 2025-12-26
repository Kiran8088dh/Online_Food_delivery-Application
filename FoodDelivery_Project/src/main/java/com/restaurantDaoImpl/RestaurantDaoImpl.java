package com.restaurantDaoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.restaurant.Connection.DBConnection;
import com.restaurant.DAO.RestaurantDao;
import com.restaurant.DAO.RestaurantDao;
import com.restaurant.model.Restaurant;

public class RestaurantDaoImpl implements RestaurantDao{
	
	
	
	   private static final String INSERT_RESTAURANT =
		        "INSERT INTO restaurant(name, address, rating, description, image) " +
		        "VALUES (?, ?, ?, ?, ?)";

		    private static final String SELECT_RESTAURANT_BY_ID =
		        "SELECT * FROM restaurant WHERE Id = ?";

		    private static final String UPDATE_RESTAURANT =
		        "UPDATE restaurant SET name = ?, address = ?, rating = ?, description = ?, image = ? " +
		        "WHERE Id = ?";

		    private static final String DELETE_RESTAURANT =
		        "DELETE FROM restaurant WHERE Id = ?";

		    private static final String SELECT_ALL_RESTAURANTS =
		        "SELECT Id, name, address, rating, description, image FROM restaurant";
		    
		    

	@Override
	public void addRestaurant(Restaurant restaurant) {
		// TODO Auto-generated method stub
		try (Connection connection = DBConnection.getConnection();
	             PreparedStatement statement = connection.prepareStatement(INSERT_RESTAURANT)) {

	            statement.setString(1, restaurant.getName());
	            statement.setString(2, restaurant.getAddress());
	            statement.setFloat(3, restaurant.getRating());
	            statement.setString(4, restaurant.getDescription());
	            statement.setString(5, restaurant.getImage());

	            int res = statement.executeUpdate();
	            System.out.println("Restaurant inserted, rows affected: " + res);

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
		
		

	@Override
	public Restaurant getRestaurantById(int id) {
		  Restaurant restaurant = null;

	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement statement = connection.prepareStatement(SELECT_RESTAURANT_BY_ID)) {

	            statement.setInt(1, id);
	            ResultSet rs = statement.executeQuery();

	            if (rs.next()) {
	                restaurant = new Restaurant();
	                restaurant.setId(rs.getInt("Id"));
	                restaurant.setName(rs.getString("name"));
	                restaurant.setAddress(rs.getString("address"));
	                restaurant.setRating(rs.getFloat("rating"));
	                restaurant.setDescription(rs.getString("description"));
	                restaurant.setImage(rs.getString("image"));
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return restaurant;
	}

	@Override
	public void updateRestaurant(Restaurant restaurant) {
		// TODO Auto-generated method stub
		try (Connection connection = DBConnection.getConnection();
	             PreparedStatement statement = connection.prepareStatement(UPDATE_RESTAURANT)) {

	            statement.setString(1, restaurant.getName());
	            statement.setString(2, restaurant.getAddress());
	            statement.setFloat(3, restaurant.getRating());
	            statement.setString(4, restaurant.getDescription());
	            statement.setString(5, restaurant.getImage());
	            statement.setInt(6, restaurant.getId());

	            int res = statement.executeUpdate();

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
		

	@Override
	public void deleteRestaurant(int id) {
		// TODO Auto-generated method stub
		 try (Connection connection = DBConnection.getConnection();
	             PreparedStatement statement = connection.prepareStatement(DELETE_RESTAURANT)) {

	            statement.setInt(1, id);

	            int res = statement.executeUpdate();

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
		
	}

	@Override
	public List<Restaurant> getAllRestaurants() {
		 List<Restaurant> restaurants = new ArrayList<>();

	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement statement = connection.prepareStatement(SELECT_ALL_RESTAURANTS);
	             ResultSet rs = statement.executeQuery()) {

	            while (rs.next()) {
	                Restaurant restaurant = new Restaurant();
	                restaurant.setId(rs.getInt("Id"));
	                restaurant.setName(rs.getString("name"));
	                restaurant.setAddress(rs.getString("address"));
	                restaurant.setRating(rs.getFloat("rating"));
	                restaurant.setDescription(rs.getString("description"));
	                restaurant.setImage(rs.getString("image"));
	                restaurants.add(restaurant);
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return restaurants;
	    }
	}
	
	
