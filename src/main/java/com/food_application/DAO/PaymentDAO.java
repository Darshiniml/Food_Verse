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
<<<<<<< HEAD
    double getTotalRevenue();

    int getTotalPayments();

    int getSuccessfulPayments();

    int getPendingPayments();

    double getTodayRevenue();

    double getMonthlyRevenue();
=======
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

}