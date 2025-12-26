package com.restaurant.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();

        // ✅ PUBLIC / GUEST ALLOWED URLs
        if (uri.endsWith("/login") ||
            uri.endsWith("/register") ||
            uri.endsWith("/placeOrder") ||
            uri.endsWith("/Cart.jsp") ||
            uri.endsWith("/OrderConfirmation.jsp") ||
            uri.contains("/css/") ||
            uri.contains("/js/") ||
            uri.contains("/images/")) {

            chain.doFilter(req, res);
            return;
        }

        HttpSession session = request.getSession(false);

        // 🔐 PROTECTED PAGES
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        chain.doFilter(req, res);
    }
}
