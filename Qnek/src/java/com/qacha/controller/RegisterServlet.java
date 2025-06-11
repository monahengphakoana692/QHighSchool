/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.qacha.controller;

import com.qacha.dao.UserDAO;
import com.qacha.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse res)
throws ServletException, IOException {

    String firstName = req.getParameter("firstName");
    String lastName = req.getParameter("lastName");
    String email = req.getParameter("email");
    String phone = req.getParameter("phone");
    String username = req.getParameter("username");
    String password = req.getParameter("password");
    String role = req.getParameter("role");

    User user = new User();
    user.setFirstName(firstName);
    user.setLastName(lastName);
    user.setEmail(email);
    user.setPhone(phone);
    user.setUsername(username);
    user.setPassword(password);
    user.setRole(role);

    boolean success = UserDAO.register(user);

    if (success) {
        int userId = UserDAO.getUserIdByUsername(username);

        try (Connection conn = com.qacha.dao.DBConnection.getConnection()) {
            if ("student".equalsIgnoreCase(role)) {
                String sql = "INSERT INTO students (user_id, class_id, parent_name, parent_phone, address, date_of_birth) " +
                             "VALUES (?, 1, '', '', '', NULL)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                ps.executeUpdate();
            } else if ("teacher".equalsIgnoreCase(role)) {
                String sql = "INSERT INTO teachers (user_id, subject_specialization) VALUES (?, '')";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                ps.executeUpdate();
            }
        } catch (Exception e) {
        }

        res.sendRedirect("login.jsp");
    } else {
        req.setAttribute("errorMessage", "Registration failed. Try again.");
        req.getRequestDispatcher("register.jsp").forward(req, res);
    }
}
}