package com.qacha.controller;

import com.qacha.dao.DBConnection;
import com.qacha.dao.TeacherDAO;
import com.qacha.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
@WebServlet("/teacher")
public class TeacherServlet extends HttpServlet {

@Override
protected void doPost(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

    String action = req.getParameter("action");

    if ("add".equalsIgnoreCase(action)) {
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String subject = req.getParameter("subject");

        try (Connection conn = DBConnection.getConnection()) {

            // Step 1: Insert into users
            String insertUser = "INSERT INTO users (username, password, role, first_name, last_name, email, phone) " +
                    "VALUES (?, ?, 'teacher', ?, ?, ?, ?)";

            PreparedStatement ps1 = conn.prepareStatement(insertUser, Statement.RETURN_GENERATED_KEYS);
            ps1.setString(1, username);
            ps1.setString(2, password);
            ps1.setString(3, firstName);
            ps1.setString(4, lastName);
            ps1.setString(5, email);
            ps1.setString(6, phone);

            int rowsAffected = ps1.executeUpdate();
            int userId = 0;

            if (rowsAffected > 0) {
                ResultSet rs = ps1.getGeneratedKeys();
                if (rs.next()) {
                    userId = rs.getInt(1);
                }
                rs.close();
            }
            ps1.close();

            // Step 2: Insert into teachers
            if (userId > 0) {
                String insertTeacher = "INSERT INTO teachers (user_id, subject_specialization) VALUES (?, ?)";
                PreparedStatement ps2 = conn.prepareStatement(insertTeacher);
                ps2.setInt(1, userId);
                ps2.setString(2, subject);
                ps2.executeUpdate();
                ps2.close();
            }
     
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to teacher list
        res.sendRedirect("teachers.jsp");
    }

if ("delete".equalsIgnoreCase(action)) {
    int userId = Integer.parseInt(req.getParameter("userId"));
    TeacherDAO.deleteTeacher(userId);
    res.sendRedirect("teachers.jsp");
}
else if ("edit".equalsIgnoreCase(action)) {
    int userId = Integer.parseInt(req.getParameter("userId"));
    String firstName = req.getParameter("firstName");
    String lastName = req.getParameter("lastName");
    String email = req.getParameter("email");
    String phone = req.getParameter("phone");

    User user = new User();
    user.setUserId(userId);
    user.setFirstName(firstName);
    user.setLastName(lastName);
    user.setEmail(email);
    user.setPhone(phone);

    TeacherDAO.updateTeacher(user);
    res.sendRedirect("teachers.jsp");
}

}
}