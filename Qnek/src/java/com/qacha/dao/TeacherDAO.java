/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.qacha.dao;

import com.qacha.model.User;
import java.sql.*;
import java.util.*;

public class TeacherDAO {

public static List<User> getAllTeachers() {
    List<User> list = new ArrayList<>();
    try (Connection conn = DBConnection.getConnection()) {
        String sql = "SELECT u.* FROM users u JOIN teachers t ON u.user_id = t.user_id";
        PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
        ResultSet rs = (ResultSet) ps.executeQuery();

        while (rs.next()) {
            User user = new User();
            user.setUserId(rs.getInt("user_id"));
            user.setFirstName(rs.getString("first_name"));
            user.setLastName(rs.getString("last_name"));
            user.setEmail(rs.getString("email"));
            user.setPhone(rs.getString("phone"));
            user.setUsername(rs.getString("username"));
            list.add(user);
        }
    } catch (Exception e) {
    }
    return list;
}
}