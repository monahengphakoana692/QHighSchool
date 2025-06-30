/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.qacha.dao;

import com.qacha.model.Grade;
import java.sql.*;
import java.util.*;

public class GradeDAO {


public static List<Grade> getGradesByStudent(int studentId) {
    List<Grade> grades = new ArrayList<>();
    try (Connection conn = DBConnection.getConnection()) {
        String sql = "SELECT g.*, s.subject_name FROM grades g " +
                     "LEFT JOIN subjects s ON g.subject_id = s.subject_id " +
                     "WHERE g.student_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, studentId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Grade g = new Grade();
            g.setGradeId(rs.getInt("grade_id"));
            g.setStudentId(rs.getInt("student_id"));
            g.setSubjectId(rs.getInt("subject_id"));
            g.setSubjectName(rs.getString("subject_name")); // from join
            g.setGradeValue(rs.getDouble("grade_value"));
            g.setTerm(rs.getString("term"));
            g.setAcademicYear(rs.getString("academic_year"));
            grades.add(g);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return grades;
}
}