package com.food_application.model;

<<<<<<< HEAD
import java.sql.Timestamp;

=======
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
public class Payment {

    private int paymentId;
    private int orderId;
    private double amount;
    private String paymentMethod;
    private String paymentStatus;
<<<<<<< HEAD
    private Timestamp paymentDate;
    public Timestamp getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(Timestamp paymentDate) {
		this.paymentDate = paymentDate;
	}

	public Payment() {
=======

    public Payment() {
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
    }

    public Payment(int paymentId,
            int orderId,
            double amount,
            String paymentMethod,
            String paymentStatus) {

        this.paymentId = paymentId;
        this.orderId = orderId;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
<<<<<<< HEAD
    
=======
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
}