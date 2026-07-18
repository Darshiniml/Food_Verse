package com.food_application.DAO;
import java.util.List;
import com.food_application.model.Notification;
public interface NotificationDAO { void addNotification(Notification n); List<Notification> getCustomerNotifications(int customerId,int offset,int limit); int getUnreadCount(int customerId); void markAsRead(int id,int customerId); void markAllAsRead(int customerId); void deleteNotification(int id,int customerId); void deleteAllNotifications(int customerId); }
