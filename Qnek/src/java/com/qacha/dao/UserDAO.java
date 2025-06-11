/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.qacha.dao;

import com.qacha.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

// Register a new user
public static boolean register(User user) {
    boolean result = false;
    try (Connection conn = DBConnection.getConnection()) {
        String sql = "INSERT INTO users (username, password, role, first_name, last_name, email, phone) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, user.getUsername());
        ps.setString(2, user.getPassword());
        ps.setString(3, user.getRole());
        ps.setString(4, user.getFirstName());
        ps.setString(5, user.getLastName());
        ps.setString(6, user.getEmail());
        ps.setString(7, user.getPhone());

        int rows = ps.executeUpdate();
        result = rows > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return result;
}

// Login method: fetch user based on username and password
public static User login(String username, String password) {
    User user = null;
    try (Connection conn = DBConnection.getConnection()) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            user = new User();
            user.setUserId(rs.getInt("user_id"));
            user.setUsername(rs.getString("username"));
            user.setPassword(rs.getString("password"));
            user.setRole(rs.getString("role"));
            user.setFirstName(rs.getString("first_name"));
            user.setLastName(rs.getString("last_name"));
            user.setEmail(rs.getString("email"));
            user.setPhone(rs.getString("phone"));
        }

        rs.close();
        ps.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return user;
}

   public static int getUserIdByUsername(String username) {
int userId = -1;
try (Connection conn = DBConnection.getConnection()) {
String sql = "SELECT user_id FROM users WHERE username = ?";
PreparedStatement ps = conn.prepareStatement(sql);
ps.setString(1, username);
ResultSet rs = ps.executeQuery();
if (rs.next()) {
userId = rs.getInt("user_id");
}
rs.close();
ps.close();
} catch (Exception e) {
e.printStackTrace();
}
return userId;
}
}