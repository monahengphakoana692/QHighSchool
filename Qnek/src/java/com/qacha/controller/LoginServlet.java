package com.qacha.controller;

import com.qacha.dao.UserDAO;
import com.qacha.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse res)
throws ServletException, IOException {

    String username = req.getParameter("username");
    String password = req.getParameter("password");

    User user = UserDAO.login(username, password);

    if (user != null) {
        HttpSession session = req.getSession();
        session.setAttribute("user", user);

        switch (user.getRole()) {
            case "principal":
                res.sendRedirect("principal_dashboard.jsp");
                break;
            case "teacher":
                res.sendRedirect("index.jsp");
                break;
            case "student":
                res.sendRedirect("student_dashboard.jsp");
                break;
            default:
                res.sendRedirect("dashboard.jsp"); // fallback
                break;
        }
    } else {
        req.setAttribute("errorMessage", "Invalid username or password");
        req.getRequestDispatcher("login.jsp").forward(req, res);
    }
}
}