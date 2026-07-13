package com.food_application.payment;

public class RazorpayConfig {

    public static final String KEY_ID =
            System.getProperty("foodverse.razorpay.keyId",
                    System.getenv().getOrDefault(
                            "RAZORPAY_KEY_ID",
                            ""));

    public static final String KEY_SECRET =
            System.getProperty("foodverse.razorpay.keySecret",
                    System.getenv().getOrDefault(
                            "RAZORPAY_KEY_SECRET",
                            ""));
}
