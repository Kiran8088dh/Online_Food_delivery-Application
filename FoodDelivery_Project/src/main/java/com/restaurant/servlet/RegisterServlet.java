package com.restaurant.servlet;

import com.restaurant.DAO.UserDAO;
import com.restaurantDaoImpl.UserDaoImpl;
import com.restaurant.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDao;

    @Override
    public void init() {
        userDao = new UserDaoImpl();
    }

    // 🚫 Disable GET (prevents 405 error)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/register.jsp");
    }

    // ✅ Handle Register
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");
        String address = request.getParameter("address");

        // Keep values if error
        request.setAttribute("name", name);
        request.setAttribute("phone", phone);
        request.setAttribute("email", email);
        request.setAttribute("address", address);

        // 🔴 Basic validation
        if (name == null || phone == null || email == null ||
            password == null || confirm == null || address == null ||
            name.isEmpty() || phone.isEmpty() || email.isEmpty() ||
            password.isEmpty() || confirm.isEmpty() || address.isEmpty()) {

            request.setAttribute("regError", "All fields are required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirm)) {
            request.setAttribute("regError", "Passwords do not match.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try {
            // 🔴 Email already exists?
            User existingUser = userDao.findByEmail(email);
            if (existingUser != null) {
                request.setAttribute("regError", "Email already registered. Please login.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // ✅ Create user
            boolean success = userDao.createUser(name, phone, email, address, password);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/login");
            } else {
                request.setAttribute("regError", "Registration failed. Try again.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("regError", "Server error. Please try later.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
