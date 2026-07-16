package com.food_application.model;

public enum OrderStatus {
    PLACED,
    ACCEPTED,
    PREPARING,
    READY,
    ASSIGNED,
    PICKED_UP,
    OUT_FOR_DELIVERY,
    DELIVERED,
    CANCELLED;

    public static OrderStatus fromString(String value) {
        if (value == null || value.isBlank()) {
            return PLACED;
        }
        String normalized = value.trim().toUpperCase();
        if ("READY_FOR_PICKUP".equals(normalized) || "READY FOR PICKUP".equals(normalized)) {
            return READY;
        }
        if ("PENDING".equals(normalized)) {
            return PLACED;
        }
        try {
            return OrderStatus.valueOf(normalized);
        } catch (IllegalArgumentException ex) {
            return PLACED;
        }
    }

    public String dbValue() {
        return name();
    }
}
