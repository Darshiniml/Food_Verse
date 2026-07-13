package com.food_application.filter;

import java.io.IOException;

import com.food_application.model.User;

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

@WebFilter(urlPatterns = {"/adminDashboard", "/manageRestaurants", "/manageFood", "/manageUsers", "/manageOrders", "/addRestaurant", "/addFood", "/updateRestaurant", "/updateFood", "/deleteRestaurant", "/deleteFood", "/deleteUser", "/payments", "/analytics", "/restaurantDashboard", "/restaurantOrders", "/restaurantMenu", "/deliveryDashboard", "/availableOrders", "/myDeliveries", "/acceptDelivery", "/updateDeliveryStatus", "/admin/*", "/restaurant/*", "/delivery/*"})
public class RoleFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        String contextPath = httpRequest.getContextPath();
        String uri = httpRequest.getRequestURI();

        if (session == null || session.getAttribute("loggedUser") == null) {
            httpResponse.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedUser");
        String adminPrefix = contextPath + "/admin";
        String restaurantPrefix = contextPath + "/restaurant";
        String deliveryPrefix = contextPath + "/delivery";

        if ((uri.startsWith(adminPrefix) || uri.endsWith("/adminDashboard") || uri.endsWith("/manageRestaurants") || uri.endsWith("/manageFood") || uri.endsWith("/manageUsers") || uri.endsWith("/manageOrders") || uri.endsWith("/addRestaurant") || uri.endsWith("/addFood") || uri.endsWith("/updateRestaurant") || uri.endsWith("/updateFood") || uri.endsWith("/deleteRestaurant") || uri.endsWith("/deleteFood") || uri.endsWith("/deleteUser") || uri.endsWith("/payments") || uri.endsWith("/analytics")) && !"ADMIN".equals(user.getRole())) {
            httpResponse.sendRedirect(contextPath + "/403.jsp");
            return;
        }

        if ((uri.startsWith(restaurantPrefix) || uri.endsWith("/restaurantDashboard") || uri.endsWith("/restaurantOrders") || uri.endsWith("/restaurantMenu")) && !"RESTAURANT".equals(user.getRole())) {
            httpResponse.sendRedirect(contextPath + "/403.jsp");
            return;
        }

        if ((uri.startsWith(deliveryPrefix) || uri.endsWith("/deliveryDashboard") || uri.endsWith("/availableOrders") || uri.endsWith("/myDeliveries") || uri.endsWith("/acceptDelivery") || uri.endsWith("/updateDeliveryStatus")) && !"DELIVERY_AGENT".equals(user.getRole())) {
            httpResponse.sendRedirect(contextPath + "/403.jsp");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
