package com.food_application.DAOApplication;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;
import com.food_application.DAO.UserDAO;
import com.food_application.model.User;
import com.food_application.utility.DBConnection;

import java.sql.PreparedStatement;
public class UserDAOImpl implements UserDAO {

    private Connection con;

    public UserDAOImpl() {
        con = DBConnection.getConnection();
    }

    
    @Override
    public void addUser(User user) {

        String query =
        "INSERT INTO users(name,email,password,phone,address,role) VALUES(?,?,?,?,?,?)";

        try {

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getRole());

            ps.executeUpdate();

            System.out.println("User Registered Successfully");

        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public User getUserById(int userId) {

        User user = null;

        String query = "SELECT * FROM users WHERE user_id=?";

        try {

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return user;
    }
    @Override
    public int getUserCount() {

        int count = 0;

        String query = "SELECT COUNT(*) FROM users";

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                count = rs.getInt(1);

            }

        } catch(Exception e) {

            e.printStackTrace();

        }

        return count;
    }
    
    @Override
    public List<User> getAllUsers() {

        List<User> users = new ArrayList<>();

        String query = "SELECT * FROM users";

        try {

            PreparedStatement ps =
                    con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                User user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));

                users.add(user);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return users;
    }

    @Override
    public void updateUser(User user) {

        String query =
        "UPDATE users SET name=?, email=?, password=?, phone=?, address=? WHERE user_id=?";

        try {

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setInt(6, user.getUserId());

            ps.executeUpdate();

            System.out.println("User Updated Successfully");

        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteUser(int userId) {

        String query =
        "DELETE FROM users WHERE user_id=?";

        try {

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, userId);

            ps.executeUpdate();

            System.out.println("User Deleted Successfully");

        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    @Override
   
    public User getUserByEmail(String email) {

        User user = null;

        String query = "SELECT * FROM users WHERE email=?";

        try {

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return user;
    }
    @Override
    public User validateUser(String email, String password) {

        User user = null;

        String query =
                "SELECT * FROM users WHERE email=? AND password=?";

        try {

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}