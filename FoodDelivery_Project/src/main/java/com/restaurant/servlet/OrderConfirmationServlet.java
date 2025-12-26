package com.restaurant.servlet;

import java.io.IOException;
import java.util.Collection;
import com.restaurant.model.Cart;
import com.restaurant.model.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/orderConfirmation")
public class OrderConfirmationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        
        // 1. Session & User Check
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 2. Order ID Check
        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // 3. Retrieve Order Data from Session
        Cart lastOrderCart = (Cart) session.getAttribute("lastOrderCart");
        String shippingAddress = (String) session.getAttribute("lastShippingAddress");
        Double grandTotal = (Double) session.getAttribute("lastGrandTotal");

        // Safety: If session data is missing, redirect to home
        if (lastOrderCart == null || shippingAddress == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // 4. Prepare Data for JSP
        // If cart.getItems() returns a Map, use cart.getItems().values()
        request.setAttribute("cartItems", lastOrderCart.getItems()); 
        request.setAttribute("orderId", orderIdParam);
        request.setAttribute("shippingAddress", shippingAddress);
        request.setAttribute("grandTotal", grandTotal);

        // 5. Forward to the actual JSP file
        // IMPORTANT: Ensure the filename matches exactly (OrderConfirmation.jsp)
        request.getRequestDispatcher("OrderConfirmation.jsp").forward(request, response);
    }
}