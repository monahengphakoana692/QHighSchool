package com.qacha.dao;

import com.qacha.model.Student;
import java.sql.*;
import java.util.*;

public class StudentDAO {

    public static void insertStudent(Student s) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO students (class_id, parent_name, parent_phone, address, date_of_birth) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, s.getClassId());
            ps.setString(2, s.getParentName());
            ps.setString(3, s.getParentPhone());
            ps.setString(4, s.getAddress());
            ps.setString(5, s.getDateOfBirth());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static List<Student> getAllStudents() {
        List<Student> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM students";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Student s = new Student();
                s.setStudentId(rs.getInt("student_id"));
                s.setClassId(rs.getInt("class_id"));
                s.setParentName(rs.getString("parent_name"));
                s.setParentPhone(rs.getString("parent_phone"));
                s.setAddress(rs.getString("address"));
                s.setDateOfBirth(rs.getString("date_of_birth"));

                // These fields must exist in your students table if you want to use them in your JSP:
                try { s.setFirstName(rs.getString("first_name")); } catch (SQLException ignored) {}
                try { s.setLastName(rs.getString("last_name")); } catch (SQLException ignored) {}

                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void deleteStudent(int id) {
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM students WHERE student_id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void updateStudent(Student s) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE students SET parent_name=?, parent_phone=?, address=?, date_of_birth=?, class_id=? WHERE student_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, s.getParentName());
            ps.setString(2, s.getParentPhone());
            ps.setString(3, s.getAddress());
            ps.setString(4, s.getDateOfBirth());
            ps.setInt(5, s.getClassId());
            ps.setInt(6, s.getStudentId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
