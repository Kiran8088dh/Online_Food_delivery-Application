package com.restaurant.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.restaurant.model.Cart;
import com.restaurant.model.CartItem;
import com.restaurant.DAO.MenuDao;
import com.restaurantDaoImpl.MenuDaoImpl;
import com.restaurant.model.Menu;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private MenuDao menuDao;

    @Override
    public void init() throws ServletException {
        menuDao = new MenuDaoImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);

        // Get cart from session or create new
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addToCart(request, cart);
        } 
        else if ("update".equals(action)) {
            updateCartItem(request, cart);
        } 
        else if ("remove".equals(action)) {
            removeCartItem(request, cart);
        } 
        else if ("clear".equals(action)) {
            cart.clearCart();
        }

        // Redirect back to Cart page
        response.sendRedirect(request.getContextPath() + "/Cart.jsp");
    }

    // ================= METHODS =================

    private void addToCart(HttpServletRequest request, Cart cart) {

        int menuId = Integer.parseInt(request.getParameter("menuId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Menu menu = menuDao.getMenuById(menuId);

        if (menu != null) {
            CartItem item = new CartItem(
                    menu.getId(),
                    menu.getName(),
                    menu.getPrice(),
                    quantity
            );
            cart.addItem(item);
        }
    }

    private void updateCartItem(HttpServletRequest request, Cart cart) {

        int itemId = Integer.parseInt(request.getParameter("itemId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        if (quantity <= 0) {
            cart.removeItem(itemId);
        } else {
            cart.updateItem(itemId, quantity);
        }
    }

    private void removeCartItem(HttpServletRequest request, Cart cart) {

        int itemId = Integer.parseInt(request.getParameter("itemId"));
        cart.removeItem(itemId);
    }
}
