/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.qacha.controller;

import com.qacha.dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/test-conn")
public class TestConnectionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try (Connection conn = DBConnection.getConnection()) {
            resp.getWriter().println("✅ Database connected successfully!");
        } catch (SQLException e) {
            resp.getWriter().println("❌ Connection failed: " + e.getMessage());
        }
    }
}

