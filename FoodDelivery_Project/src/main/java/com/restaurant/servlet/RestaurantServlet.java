package com.restaurant.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import com.restaurant.DAO.RestaurantDao;
import com.restaurantDaoImpl.RestaurantDaoImpl;
import com.restaurant.model.Restaurant;

@WebServlet("/restaurants")
public class RestaurantServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private RestaurantDao restaurantDao;

    @Override
    public void init() throws ServletException {
        restaurantDao = new RestaurantDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
                request.getRequestDispatcher("restaurant-form.jsp").forward(request, response);
                break;

            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Restaurant r = restaurantDao.getRestaurantById(id);
                request.setAttribute("restaurant", r);
                request.getRequestDispatcher("restaurant-form.jsp").forward(request, response);
                break;

            case "delete":
                deleteRestaurant(request, response);
                break;

            case "list":
            default:
                listRestaurants(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("insert".equals(action)) {
            insertRestaurant(request, response);
        } else if ("update".equals(action)) {
            updateRestaurant(request, response);
        } else {
            response.sendRedirect("restaurants");
        }
    }

    // ---------------- METHODS ----------------

    private void listRestaurants(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Restaurant> restaurants = restaurantDao.getAllRestaurants();
        request.setAttribute("restaurants", restaurants); // ✅ ONLY restaurants
        request.getRequestDispatcher("restaurant.jsp").forward(request, response);
    }

    private void insertRestaurant(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String name = request.getParameter("name");
        String address = request.getParameter("address");
        float rating = Float.parseFloat(request.getParameter("rating"));
        String description = request.getParameter("description");
        String image = request.getParameter("image");

        Restaurant restaurant = new Restaurant();
        restaurant.setName(name);
        restaurant.setAddress(address);
        restaurant.setRating(rating);
        restaurant.setDescription(description);
        restaurant.setImage(image);

        restaurantDao.addRestaurant(restaurant);
        response.sendRedirect("restaurants");
    }

    private void updateRestaurant(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        float rating = Float.parseFloat(request.getParameter("rating"));
        String description = request.getParameter("description");
        String image = request.getParameter("image");

        Restaurant restaurant = new Restaurant();
        restaurant.setId(id);
        restaurant.setName(name);
        restaurant.setAddress(address);
        restaurant.setRating(rating);
        restaurant.setDescription(description);
        restaurant.setImage(image);

        restaurantDao.updateRestaurant(restaurant);
        response.sendRedirect("restaurants");
    }

    private void deleteRestaurant(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        restaurantDao.deleteRestaurant(id);
        response.sendRedirect("restaurants");
    }
}
