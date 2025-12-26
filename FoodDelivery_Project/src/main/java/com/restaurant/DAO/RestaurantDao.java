package com.restaurant.DAO;

import java.util.List;

import com.restaurant.model.Restaurant;

public interface RestaurantDao {
	
	  void addRestaurant(Restaurant restaurant);

	    Restaurant getRestaurantById(int id);

	    void updateRestaurant(Restaurant restaurant);

	    void deleteRestaurant(int id);

	    List<Restaurant> getAllRestaurants();
}
