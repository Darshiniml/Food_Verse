package com.food_application.model;

public class Activity {

    private String icon;
    private String message;
    private String color;

    public Activity() {
    }

    public Activity(String icon, String message, String color) {
        this.icon = icon;
        this.message = message;
        this.color = color;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }
}