package com.food_application.DAOApplication;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.food_application.DAO.PaymentDAO;
import com.food_application.model.Payment;
import com.food_application.utility.DBConnection;

public class PaymentDAOImpl implements PaymentDAO {

    private Connection con;

    public PaymentDAOImpl() {

        con = DBConnection.getConnection();

    }
<<<<<<< HEAD
    @Override
    public double getTotalRevenue() {

        double revenue = 0;

        String sql = "SELECT SUM(amount) FROM payments WHERE payment_status='SUCCESS'";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                revenue = rs.getDouble(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return revenue;

    }
    @Override
    public int getTotalPayments() {

        int count = 0;

        String sql = "SELECT COUNT(*) FROM payments";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return count;

    }
    @Override
    public int getSuccessfulPayments() {

        int count = 0;

        String sql =
        "SELECT COUNT(*) FROM payments WHERE payment_status='SUCCESS'";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return count;

    }
    @Override
    public int getPendingPayments() {

        int count = 0;

        String sql =
        "SELECT COUNT(*) FROM payments WHERE payment_status='PENDING'";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return count;

    }
    @Override
    public double getTodayRevenue() {

        double revenue = 0;

        String sql =
        "SELECT SUM(amount) FROM payments WHERE DATE(payment_date)=CURDATE() AND payment_status='SUCCESS'";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                revenue = rs.getDouble(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return revenue;

    }
    @Override
    public double getMonthlyRevenue() {

        double revenue = 0;

        String sql =
        "SELECT SUM(amount) FROM payments WHERE MONTH(payment_date)=MONTH(CURDATE()) AND YEAR(payment_date)=YEAR(CURDATE()) AND payment_status='SUCCESS'";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                revenue = rs.getDouble(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return revenue;

    }
=======

>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6
    @Override
    public void addPayment(Payment payment) {

        String query =
        "INSERT INTO payments(order_id,payment_method,amount,payment_status) VALUES(?,?,?,?)";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, payment.getOrderId());
            ps.setString(2, payment.getPaymentMethod());
            ps.setDouble(3, payment.getAmount());
            ps.setString(4, payment.getPaymentStatus());

            ps.executeUpdate();

            System.out.println("Payment Added Successfully");

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public Payment getPaymentById(int paymentId) {

        Payment payment = null;

        String query =
        "SELECT * FROM payments WHERE payment_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, paymentId);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                payment = new Payment();

                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setOrderId(rs.getInt("order_id"));
                payment.setPaymentMethod(rs.getString("payment_method"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setPaymentStatus(rs.getString("payment_status"));

            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return payment;
    }

    @Override
    public List<Payment> getAllPayments() {

        List<Payment> payments = new ArrayList<>();

        String query = "SELECT * FROM payments";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Payment payment = new Payment();

                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setOrderId(rs.getInt("order_id"));
                payment.setPaymentMethod(rs.getString("payment_method"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setPaymentStatus(rs.getString("payment_status"));

                payments.add(payment);

            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return payments;
    }

    @Override
    public List<Payment> getPaymentsByOrderId(int orderId) {

        List<Payment> payments = new ArrayList<>();

        String query =
        "SELECT * FROM payments WHERE order_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Payment payment = new Payment();

                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setOrderId(rs.getInt("order_id"));
                payment.setPaymentMethod(rs.getString("payment_method"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setPaymentStatus(rs.getString("payment_status"));

                payments.add(payment);

            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return payments;
    }

    @Override
    public void updatePayment(Payment payment) {

        String query =
        "UPDATE payments SET order_id=?, payment_method=?, amount=?, payment_status=? WHERE payment_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, payment.getOrderId());
            ps.setString(2, payment.getPaymentMethod());
            ps.setDouble(3, payment.getAmount());
            ps.setString(4, payment.getPaymentStatus());
            ps.setInt(5, payment.getPaymentId());

            ps.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public void deletePayment(int paymentId) {

        String query =
        "DELETE FROM payments WHERE payment_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, paymentId);

            ps.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();
        }

    }

}