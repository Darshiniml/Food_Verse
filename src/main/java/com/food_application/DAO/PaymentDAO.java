package com.food_application.DAO;

import java.util.List;

import com.food_application.model.Payment;

public interface PaymentDAO {

    void addPayment(Payment payment);

    Payment getPaymentById(int paymentId);

    List<Payment> getAllPayments();

    List<Payment> getPaymentsByOrderId(int orderId);

    void updatePayment(Payment payment);

    void deletePayment(int paymentId);

    double getTotalRevenue();

    int getTotalPayments();

    int getSuccessfulPayments();

    int getPendingPayments();

    double getTodayRevenue();

    double getMonthlyRevenue();


}