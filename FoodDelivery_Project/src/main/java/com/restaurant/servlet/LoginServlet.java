package com.restaurant.servlet;

import com.restaurant.DAO.UserDAO;
import com.restaurantDaoImpl.UserDaoImpl;
import com.restaurant.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;



@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDaoImpl();
    }

    // ================== GET ==================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // ================== POST ==================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            User user = userDao.findByEmail(email);

            if (user == null) {
                request.setAttribute("loginError", "Email not registered");
                request.setAttribute("email", email);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            if (!user.getPassword().equals(password)) {
                request.setAttribute("loginError", "Invalid password");
                request.setAttribute("email", email);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            // ✅ LOGIN SUCCESS (IMPORTANT FIX HERE)
            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", user);          // optional (full user)
            session.setAttribute("userId", user.getId()); // ⭐ REQUIRED

            response.sendRedirect(request.getContextPath() + "/restaurants");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("loginError", "Something went wrong. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}