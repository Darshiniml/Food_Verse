package com.food_application.payment;

import org.json.JSONObject;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;

public class RazorpayService {

    public Order createOrder(double amount)
            throws Exception {

        RazorpayClient client =
                new RazorpayClient(
                        RazorpayConfig.KEY_ID,
                        RazorpayConfig.KEY_SECRET);

        JSONObject options =
                new JSONObject();

        options.put("amount",
                (int)(amount * 100));

        options.put("currency", "INR");

        options.put("receipt",
                "receipt_" + System.currentTimeMillis());

        return client.orders.create(options);

    }

}