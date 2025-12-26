package com.restaurant.servlet;

import com.restaurant.model.Cart;
import com.restaurant.model.Order;
import com.restaurantDaoImpl.OrderDaoImpl;
import com.restaurant.DAO.OrderDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {

    private OrderDao orderDao;

    @Override
    public void init() {
        orderDao = new OrderDaoImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems() == null || cart.getItems().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/Cart.jsp");
            return;
        }

        int userId = 0;
        Long userIdObj = (Long) session.getAttribute("userId");
        if (userIdObj != null) {
            userId = userIdObj.intValue();
        }

        String shippingAddress = request.getParameter("shippingAddress");
        if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
            shippingAddress = "Not Provided";
        }

        float grandTotal = cart.getTotalCartPrice();

        Order order = new Order();
        order.setUserId(userId);
        order.setShippingAddress(shippingAddress);
        order.setTotalAmount(grandTotal);
        order.setOrderStatus("PLACED");
        order.setPaymentMode("COD");   // ⭐ REQUIRED

        // ✅ UUID-based order id
        String orderId = orderDao.createOrder(order);

        request.setAttribute("orderId", orderId);
        request.setAttribute("shippingAddress", shippingAddress);
        request.setAttribute("grandTotal", grandTotal);
        request.setAttribute("cartItems", cart.getItems());

        session.removeAttribute("cart");

        request.getRequestDispatcher("/OrderConfirmation.jsp")
               .forward(request, response);
    }
}
