<%-- 
    Document   : students
    Created on : 04 Jun 2025, 17:08:38
    Author     : Malomile Ramochele
--%>

<%@ page import="java.util.*, com.qacha.dao.StudentDAO, com.qacha.model.Student" %>
<%@ page session="true" %>
<html>
<head><title>Students</title></head>
<body>
    <h2>Register New Student</h2>
    <form action="student" method="post">
        Full Name: <input type="text" name="fullName" required><br>
        Parent Name: <input type="text" name="parentName" required><br>
        Parent Phone: <input type="text" name="parentPhone" required><br>
        Address: <input type="text" name="address"><br>
        DOB: <input type="date" name="dob"><br>
        Class ID: <input type="number" name="classId" required><br>
        <input type="submit" value="Register Student">
    </form>

    <h2>Registered Students</h2>
    <table border="1">
        <tr>
            <th>ID</th><th>Parent</th><th>Phone</th><th>Address</th><th>DOB</th><th>Class</th><th>Actions</th>
        </tr>
        <%
            List<Student> list = StudentDAO.getAllStudents();
            for (Student s : list) {
        %>
        <tr>
            <td><%= s.getStudentId() %></td>
            <td><%= s.getParentName() %></td>
            <td><%= s.getParentPhone() %></td>
            <td><%= s.getAddress() %></td>
            <td><%= s.getDateOfBirth() %></td>
            <td><%= s.getClassId() %></td>
            <td>
                <a href="edit_student.jsp?id=<%= s.getStudentId() %>">Edit</a> |
                <a href="student?action=delete&id=<%= s.getStudentId() %>">Delete</a>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
