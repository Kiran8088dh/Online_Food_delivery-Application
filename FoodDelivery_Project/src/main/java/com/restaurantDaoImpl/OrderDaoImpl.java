package com.restaurantDaoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.restaurant.Connection.DBConnection;
import com.restaurant.DAO.OrderDao;
import com.restaurant.model.Order;

public class OrderDaoImpl implements OrderDao {

    private static final String INSERT_ORDER =
        "INSERT INTO orders (order_id, user_id, total_amount, status, shipping_address, payment_mode) " +
        "VALUES (?, ?, ?, ?, ?, ?)";

    private static final String GET_ORDER_BY_ID =
        "SELECT * FROM orders WHERE order_id = ?";

    private static final String UPDATE_ORDER_STATUS =
        "UPDATE orders SET status = ? WHERE order_id = ?";

    @Override
    public String createOrder(Order order) {

        String orderId = java.util.UUID.randomUUID().toString();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(INSERT_ORDER)) {

            ps.setString(1, orderId);
            ps.setInt(2, order.getUserId());
            ps.setDouble(3, order.getTotalAmount());
            ps.setString(4, order.getOrderStatus());
            ps.setString(5, order.getShippingAddress());
            ps.setString(6, order.getPaymentMode());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderId;
    }

    @Override
    public Order getOrderById(String orderId) {

        Order order = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(GET_ORDER_BY_ID)) {

            ps.setString(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                order = new Order();
                order.setOrderId(rs.getString("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setOrderStatus(rs.getString("status"));
                order.setShippingAddress(rs.getString("shipping_address"));
                order.setPaymentMode(rs.getString("payment_mode"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return order;
    }

    @Override
    public void updateOrderStatus(String orderId, String status) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_ORDER_STATUS)) {

            ps.setString(1, status);
            ps.setString(2, orderId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ THIS METHOD MUST BE OUTSIDE ALL OTHER METHODS
    @Override
    public List<Order> getOrdersByUserId(int userId) {

        List<Order> orders = new ArrayList<>();

        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getString("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setOrderStatus(rs.getString("status"));
                order.setShippingAddress(rs.getString("shipping_address"));
                order.setPaymentMode(rs.getString("payment_mode"));

                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }
}
