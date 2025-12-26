package com.restaurant.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import com.restaurant.DAO.MenuDao;
import com.restaurantDaoImpl.MenuDaoImpl;
import com.restaurant.model.Menu;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private MenuDao menuDao;

    @Override
    public void init() {
        menuDao = new MenuDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rid = request.getParameter("Restaurant_Id");

        if (rid == null || rid.isEmpty()) {
            response.sendRedirect("restaurants");
            return;
        }

        int restaurantId;
        try {
            restaurantId = Integer.parseInt(rid);
        } catch (NumberFormatException e) {
            response.sendRedirect("restaurants");
            return;
        }

        List<Menu> menuList = menuDao.getMenuByRestaurantId(restaurantId);

        request.setAttribute("menuList", menuList);
        request.setAttribute("restaurantId", restaurantId); // optional

        request.getRequestDispatcher("menu.jsp").forward(request, response);
    }
}
