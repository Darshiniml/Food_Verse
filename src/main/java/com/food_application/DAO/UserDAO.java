package com.food_application.DAO;



import java.util.List;
import com.food_application.model.User;

public interface UserDAO {

    void addUser(User user);

    User getUserById(int userId);

    List<User> getAllUsers();

    void updateUser(User user);

    void deleteUser(int userId);

    User getUserByEmail(String email);
    User validateUser(String email, String password);
    int getUserCount();
    
    
}
