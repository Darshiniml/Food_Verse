package com.food_application.model;

import java.sql.Timestamp;

public class Notification {
    private int notificationId, customerId;
    private Integer orderId;
    private String title, message, notificationType;
    private boolean read;
    private Timestamp createdAt;
    public Notification() {}
    public Notification(int customerId, Integer orderId, String title, String message, String notificationType) { this.customerId=customerId; this.orderId=orderId; this.title=title; this.message=message; this.notificationType=notificationType; }
    public int getNotificationId(){return notificationId;} public void setNotificationId(int v){notificationId=v;}
    public int getCustomerId(){return customerId;} public void setCustomerId(int v){customerId=v;}
    public Integer getOrderId(){return orderId;} public void setOrderId(Integer v){orderId=v;}
    public String getTitle(){return title;} public void setTitle(String v){title=v;}
    public String getMessage(){return message;} public void setMessage(String v){message=v;}
    public String getNotificationType(){return notificationType;} public void setNotificationType(String v){notificationType=v;}
    public boolean isRead(){return read;} public void setRead(boolean v){read=v;}
    public Timestamp getCreatedAt(){return createdAt;} public void setCreatedAt(Timestamp v){createdAt=v;}
    @Override public String toString(){return "Notification{"+notificationId+", title='"+title+"'}";}
}
