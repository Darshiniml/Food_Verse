package com.food_application.Servlet;
import java.io.*;import com.food_application.DAOApplication.NotificationDAOImpl;import com.food_application.model.User;import jakarta.servlet.annotation.WebServlet;import jakarta.servlet.http.*;
@WebServlet("/markAllNotifications") public class MarkAllNotificationsServlet extends HttpServlet{protected void doPost(HttpServletRequest q,HttpServletResponse r)throws IOException{User u=q.getSession(false)==null?null:(User)q.getSession(false).getAttribute("loggedUser");if(u!=null)new NotificationDAOImpl().markAllAsRead(u.getUserId());r.setStatus(204);}}
