package com.food_application.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {"/admin/*", "/restaurant/*", "/delivery/*", "/cart", "/checkout", "/payment", "/placeOrder", "/myOrders", "/myDeliveries", "/orderDetails", "/availableOrders", "/restaurantOrders", "/manageRestaurants", "/manageFood", "/manageUsers", "/manageOrders", "/addRestaurant", "/addFood", "/updateRestaurant", "/updateFood", "/deleteRestaurant", "/deleteFood", "/deleteUser", "/acceptDelivery", "/updateDeliveryStatus"})
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String uri = httpRequest.getRequestURI();

        if (uri.endsWith("/login.jsp") || uri.endsWith("/register.jsp") || uri.endsWith("/home")
                || uri.endsWith("/home.jsp") || uri.endsWith("/login") || uri.endsWith("/register")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = httpRequest.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
