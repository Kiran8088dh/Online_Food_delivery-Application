package com.restaurant.servlet;

import com.restaurant.DAO.OrderDao;
import com.restaurantDaoImpl.OrderDaoImpl;
import com.restaurant.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/myOrders")
public class MyOrdersServlet extends HttpServlet {

    private OrderDao orderDao;

    @Override
    public void init() {
        orderDao = new OrderDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // 🔐 Check login
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // ✅ FIXED HERE
        Long userIdObj = (Long) session.getAttribute("userId");
        int userId = userIdObj.intValue();

        // 🔹 Fetch orders for this user
        List<Order> orders = orderDao.getOrdersByUserId(userId);

        // 🔹 Send data to JSP
        request.setAttribute("orderList", orders);

        // 🔹 Forward to JSP
        request.getRequestDispatcher("/MyOrders.jsp")
               .forward(request, response);
    }
}

