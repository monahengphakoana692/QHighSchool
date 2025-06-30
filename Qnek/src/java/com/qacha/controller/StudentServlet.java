package com.qacha.controller;

import com.qacha.dao.StudentDAO;
import com.qacha.model.Student;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/student")
public class StudentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    String action = req.getParameter("action");

    if ("add".equalsIgnoreCase(action)) {
        Student s = new Student();
        s.setFirstName(req.getParameter("firstName"));
        s.setLastName(req.getParameter("lastName"));
        s.setParentName(req.getParameter("parentName"));
        s.setParentPhone(req.getParameter("parentPhone"));
        s.setDateOfBirth(req.getParameter("dob"));
        s.setAddress(req.getParameter("address"));
        s.setClassId(Integer.parseInt(req.getParameter("classId")));

        StudentDAO.insertStudent(s);
        res.sendRedirect("students.jsp");
    } else if ("edit".equalsIgnoreCase(action)) {
        Student s = new Student();
        s.setStudentId(Integer.parseInt(req.getParameter("studentId")));
        s.setParentName(req.getParameter("parentName"));
        s.setParentPhone(req.getParameter("parentPhone"));
        s.setDateOfBirth(req.getParameter("dob"));
        s.setAddress(req.getParameter("address"));
        s.setClassId(Integer.parseInt(req.getParameter("classId")));

        StudentDAO.updateStudent(s);
        res.sendRedirect("students.jsp");
    } else if ("delete".equalsIgnoreCase(action)) {
        int id = Integer.parseInt(req.getParameter("studentId"));
        StudentDAO.deleteStudent(id);
        res.sendRedirect("students.jsp");
    }
}

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            StudentDAO.deleteStudent(id);
            res.sendRedirect("students.jsp");
        }
    }
}
