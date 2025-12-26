package com.restaurant.DAO;

import java.util.List;

import com.restaurant.model.Order;


public interface OrderDao {

    String createOrder(Order order);

    Order getOrderById(String orderId);

    void updateOrderStatus(String orderId, String status);
    
    List<Order> getOrdersByUserId(int userId);
}
